//
//  FilesDownloader.m
//  abookclub
//
//  Created by Глеб Тарасов on 26.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FilesDownloader.h"
#import "ASINetworkQueue.h"
#import "NSArray+Utils.h"
#import "NSString+NimbusCore.h"

#define CUT_DOWNLOAD_SIZE_PERIOD 3
#define BANDWIDTH_WWAN_LIMIT 16000

static FilesDownloader *__shared;

@interface FilesDownloader()

@property(strong, atomic) NSSet *observers;
@property(strong, atomic) NSArray *portionsQueue;
@property(strong, atomic) ASINetworkQueue *queue;
@property(strong, atomic) DownloadPortion *currentPortion;
@property(strong, atomic) NSDate *startDownloadingPortionDate;
@property(strong, atomic) NSArray *currentRequests;

@property(atomic) unsigned long long downlodedSizeFromCurrentPortion;
@property(atomic) unsigned long long cutDownloadedSize;
@property(atomic) BOOL wasError;

@end

@implementation FilesDownloader

@synthesize portionsQueue = _portionsQueue;
@synthesize observers = _observers;
@synthesize queue = _queue;
@synthesize currentPortion = _currentPortion;
@synthesize startDownloadingPortionDate = _startDownloadingPortionDate;
@synthesize currentRequests = _currentRequests;
@synthesize wasError = _wasError;
@synthesize downlodedSizeFromCurrentPortion = _downloadedSizeFromCurrentPortion;
@synthesize cutDownloadedSize = _cutDownloadedSize;

+ (FilesDownloader *)shared
{
    if (!__shared)
    {
        @synchronized(self)
        {
            if (!__shared)
            {
                __shared = [[self alloc] init];
                
                // чтобы через edge много не скачало
                [ASIHTTPRequest throttleBandwidthForWWANUsingLimit:BANDWIDTH_WWAN_LIMIT];
            }
        }
    }
    
    return __shared;
}

- (id)init
{
    self = [super init];
    if (self) 
    {
        self.queue = [ASINetworkQueue queue];
    }
    return self;
}


- (BOOL)createFolder:(NSString *)folder
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:folder])
    {
        NSDictionary *attrs = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:1] forKey:@"com.apple.MobileBackup"];
        if(![fileManager createDirectoryAtPath:folder 
                   withIntermediateDirectories:YES
                                    attributes:attrs 
                                         error:NULL])
        {
            NSLog(@"Error: Create folder failed %@", folder);
            return NO;
        }
    }
    
    return YES;
}

- (NSString *)storeDataFolder
{
    NSString *result = nil;
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                          NSUserDomainMask, 
                                                          YES) lastObject];
    if (docs)
    {
        result = [docs stringByAppendingPathComponent:@"data"];
        if (![self createFolder:result])
            return nil;
    }
    
    return result;
}

- (NSString *)pathForUrl:(NSString *)url inPortion:(NSString *)portionTitle
{
    NSString *folder = [self storeDataFolder];
    NSString *extension = [url pathExtension];
    NSString *file = [url md5Hash];
    NSString *result = [[folder stringByAppendingPathComponent:file] stringByAppendingPathExtension:extension];
    return result;
}

- (void)addObserver:(id<FilesDownloaderDelegate>)observer
{
    NSMutableSet *newObs = self.observers ? self.observers.mutableCopy : [NSMutableSet set];
    
    if (![newObs containsObject:observer])
        [newObs addObject:observer];
    
    self.observers = newObs;
}

- (void)removeObserver:(id)observer
{
    NSMutableSet *newObs = self.observers ? self.observers.mutableCopy : [NSMutableSet set];
    
    if ([newObs containsObject:observer])
        [newObs removeObject:observer];
    
    self.observers = newObs;    
}

- (NSArray *)requestsForPortion:(DownloadPortion *)portion
{
    NSMutableArray *result = [NSMutableArray array];
    self.downlodedSizeFromCurrentPortion = 0;
    
    for (NSString *url in portion.files) 
    {
        NSString *path = [self pathForUrl:url inPortion:portion.title];
        NSString *partPath = [path stringByAppendingPathExtension:@"part"];

        // если уже скачали - добавлять не надо, но сохраним размер для правильного прогресса
        if ([NSFileManager.defaultManager fileExistsAtPath:path])
        {
            unsigned long long fileSize = [[NSFileManager.defaultManager attributesOfItemAtPath:path
                                                                                          error:nil] fileSize];
            self.downlodedSizeFromCurrentPortion += fileSize;
            continue;
        }
        
        ASIHTTPRequest *r = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
        r.downloadDestinationPath = path;
        r.temporaryFileDownloadPath = partPath;
        r.allowResumeForFileDownloads = YES;
        r.downloadProgressDelegate = self.queue;
        r.showAccurateProgress = YES;
        r.shouldContinueWhenAppEntersBackground = YES;
        [result addObject:r];
    }
    return result;
}

- (void)performEnqueue
{
    @autoreleasepool 
    {
        [self.queue reset];
        self.queue.downloadProgressDelegate = self;
        self.queue.queueDidFinishSelector = @selector(didDownloadPortion:);
        self.queue.requestDidStartSelector = @selector(didStartRequest:);
        self.queue.requestDidFailSelector = @selector(didFailRequest:);
        self.queue.requestDidFinishSelector = @selector(didFinishRequest:);
        self.queue.showAccurateProgress = YES;
        self.queue.shouldCancelAllRequestsOnFailure = YES;
        self.queue.delegate = self;
        NSArray *requests = [self requestsForPortion:self.currentPortion];
        
        if (requests.count == 0)
        {
            [self performSelectorOnMainThread:@selector(didDownloadPortion:)
                                   withObject:self.queue
                                waitUntilDone:NO];
            return;
        }
        
        for (ASIHTTPRequest *r in requests)
        {
            [self.queue addOperation:r];
        }
        
        self.startDownloadingPortionDate = NSDate.date;
        self.cutDownloadedSize = 0;
        
        [self.queue go];    
    }
}


- (void)enqueuePortion:(DownloadPortion *)portion
{
    if (self.queue.isSuspended)
    {
        // если ничего не скачиваем - сразу запускаем очередь
        self.currentPortion = portion;
        [self performSelectorInBackground:@selector(performEnqueue) withObject:nil];
    }
    else 
    {
        // иначе сохраняем на потом
        self.portionsQueue = [self.portionsQueue arrayByAddingObject:portion];
    }
}

- (void)notifyObserversWithProgress:(DownloadProgress *)progress
{
    for (id observer in self.observers) 
    {
        if ([observer respondsToSelector:@selector(filesDownloaderDidChangeProgress:forPortion:)])
        {
            [observer filesDownloaderDidChangeProgress:progress
                                            forPortion:self.currentPortion];
        }
    }
}

- (void)notifyObserversWithFinish
{
    for (id observer in self.observers) 
    {
        if ([observer respondsToSelector:@selector(filesDownloaderDidDownloadPortion:)])
            [observer filesDownloaderDidDownloadPortion:self.currentPortion];
    }
}

- (void)notifyObserversWithError
{
    for (id observer in self.observers) 
    {
        if ([observer respondsToSelector:@selector(filesDownloaderDidFailForPortion:)])
            [observer filesDownloaderDidFailForPortion:self.currentPortion];
    }    
}

- (void)downloadFileSynchronous:(NSString *)url
{
    ASIHTTPRequest *r = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    r.downloadDestinationPath = [self pathForUrl:url inPortion:nil];
    [r startSynchronous];
}

- (NSTimeInterval)remainingTimeInterval
{
    CGFloat bytesPerSecond = self.bytesPerSecond;
    
    if (bytesPerSecond == 0)
        return 0;
    
    CGFloat estimateSize = self.queue.totalBytesToDownload - self.queue.bytesDownloadedSoFar;
    CGFloat estimateSeconds = estimateSize / bytesPerSecond;
    return roundf(estimateSeconds);
}

- (NSInteger)bytesPerSecond
{
    CGFloat spentSeconds = -self.startDownloadingPortionDate.timeIntervalSinceNow;
    
    if (spentSeconds > CUT_DOWNLOAD_SIZE_PERIOD && self.cutDownloadedSize == 0)
    {
        // обрезаем то, что скачано за первую секунду, чтобы не влияло на скорость уже загруженное
        self.cutDownloadedSize = self.queue.bytesDownloadedSoFar;
    }
    
    CGFloat downloadedSize = self.queue.bytesDownloadedSoFar - self.cutDownloadedSize;
    return roundf(downloadedSize / spentSeconds);
}

- (void)resume
{
    if (self.currentPortion)
    {
        [self.queue reset];
        // немного отложим, чтоб успели очиститься старые реквесты
        [self performSelector:@selector(enqueuePortion:) 
                   withObject:self.currentPortion
                   afterDelay:2];
    }
}

- (BOOL)isDownloadingPortion:(NSString *)portion
{
    return [self.currentPortion.title isEqualToString:portion] || [self.portionsQueue any:^BOOL(id object){
        DownloadPortion *p = object;
        return [p.title isEqualToString:p.title];
    }];
}

- (void)cancelPortion:(NSString *)portion
{
    if ([self.currentPortion.title isEqualToString:portion])
    {
        // чтобы уведомление не отправилось - обнуляем
        self.currentPortion = nil;
        [self didDownloadPortion:self.queue];
    }
    else
    {
        self.portionsQueue = [self.portionsQueue where:^BOOL(id object){
            DownloadPortion *p = object;
            return ![p.title isEqualToString:portion];
        }];
    }
}

- (void)cancelAndDeletePortion:(NSString *)portion 
{
    [self cancelPortion:portion];
}

#pragma mark - ASIHTTPRequestDownloadProgress

- (void)setProgress:(CGFloat)progress
{
    // если head еще не загрузились - не обновляем
    if (self.queue.totalBytesToDownload == 0)
        return;
    
    DownloadProgress *p = [[DownloadProgress alloc] init];
    p.bytesPerSecond = self.bytesPerSecond;
    
    // хз, почему надо делить пополам, но так заработало корректно
    p.totalBytes = self.queue.totalBytesToDownload / 2 + self.downlodedSizeFromCurrentPortion;
    p.downloadedBytes = self.queue.bytesDownloadedSoFar / 2 + self.downlodedSizeFromCurrentPortion;
    p.progress = ((CGFloat)p.downloadedBytes) / p.totalBytes;
    p.remainingTime = self.remainingTimeInterval;
    
    [self performSelectorOnMainThread:@selector(notifyObserversWithProgress:) 
                           withObject:p
                        waitUntilDone:NO];
}

- (void)didDownloadPortion:(ASINetworkQueue *)queue
{
    if (self.wasError)
    {
        [self performSelectorOnMainThread:@selector(notifyObserversWithError)
                               withObject:nil 
                            waitUntilDone:YES];
        
        [self.queue reset];
        self.currentPortion = nil;
        self.wasError = NO;
        return;
    }
    
    [self performSelectorOnMainThread:@selector(notifyObserversWithFinish)
                           withObject:nil 
                        waitUntilDone:YES];
    
    [self.queue reset];
    self.currentPortion = nil;
    
    if (self.portionsQueue.count > 0)
    {
        DownloadPortion *first = self.portionsQueue.firstObject;
        self.portionsQueue = [self.portionsQueue subarrayWithRange:NSMakeRange(1, self.portionsQueue.count - 1)];
        [self enqueuePortion:first];
    }
}

- (void)didStartRequest:(ASIHTTPRequest *)request
{
    NSArray *requests = self.currentRequests ? self.currentRequests : [NSArray array];
    self.currentRequests = [requests arrayByAddingObject:request];
}

- (void)removeRequestFromCurrent:(ASIHTTPRequest *)request
{
    NSMutableArray *requests = self.currentRequests.mutableCopy;
    [requests removeObject:request];
    self.currentRequests = requests;
}

- (void)didFinishRequest:(ASIHTTPRequest *)request
{
    [self removeRequestFromCurrent:request];
}

- (void)didFailRequest:(ASIHTTPRequest *)request
{
    self.wasError = YES;
    [self removeRequestFromCurrent:request];    
}

@end
