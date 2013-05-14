//
//  FilesDownloader.m
//  abookclub
//
//  Created by Глеб Тарасов on 26.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FilesDownloader.h"
#import "AFNetworking.h"
#import "NSArray+P34Utils.h"
#import "P34Utils.h"

#define PARTIALLY_DOWNLOAD_EXTENSION @"part"
#define CUT_DOWNLOAD_SIZE_PERIOD 3

static FilesDownloader *__shared;

@interface FilesDownloader()

@property(strong, atomic) NSSet *observers;
@property(strong, atomic) NSArray *portionsQueue;
@property (strong, nonatomic) AFHTTPClient *client;
@property(strong, atomic) DownloadPortion *currentPortion;
@property(strong, atomic) NSDate *startDownloadingPortionDate;
@property(strong, atomic) NSArray *currentRequests;

@property(atomic) BOOL wasError;

@end

@implementation FilesDownloader

+ (id)shared
{
    if (!__shared)
    {
        @synchronized(self)
        {
            if (!__shared)
            {
                __shared = [[self alloc] init];
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
        self.client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://google.com"]];
        
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(didStartRequest:)
                                                   name:AFNetworkingOperationDidStartNotification
                                                 object:nil];
    }
    return self;
}


- (BOOL)createFolder:(NSString *)folder
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:folder])
    {
        if(![fileManager createDirectoryAtPath:folder 
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:NULL])
        {
            NSLog(@"Error: Create folder failed %@", folder);
            return NO;
        }
    }
    
    return YES;
}

- (void)addObserver:(id<FilesDownloaderDelegate>)observer
{
    NSMutableSet *newObs = self.observers ? self.observers.mutableCopy : [NSMutableSet set];
    
    if (![newObs containsObject:observer])
        [newObs addObject:observer];
    
    self.observers = newObs;
}

- (void)removeObserver:(__unsafe_unretained id)observer
{
    NSMutableSet *newObs = self.observers ? self.observers.mutableCopy : [NSMutableSet set];
    
    if ([newObs containsObject:observer])
        [newObs removeObject:observer];
    
    self.observers = newObs;    
}

- (NSArray *)requestsForPortion:(DownloadPortion *)portion
{
    NSMutableArray *result = [NSMutableArray array];
    
    WSELF;
    for (NSString *url in portion.files) 
    {
        NSString *path = [portion.destinationFolder stringByAppendingPathComponent:url.lastPathComponent];
        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:req];

        NSString *tempPath = [path stringByAppendingPathExtension:PARTIALLY_DOWNLOAD_EXTENSION];
        operation.outputStream = [NSOutputStream outputStreamToFileAtPath:tempPath append:NO];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [NSFileManager.defaultManager moveItemAtPath:tempPath
                                                      toPath:path
                                                       error:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [wself didFinishRequest:operation];
                });
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [NSFileManager.defaultManager removeItemAtPath:tempPath error:nil];
            [wself didFailRequest:operation];
        }];
        
        [result addObject:operation];
    }
    
    return result;
}


- (void)performEnqueue
{
        NSArray *requests = [self requestsForPortion:self.currentPortion];
        
        if (requests.count == 0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self didDownloadPortion];
            });
            return;
        }
        
        for (AFHTTPRequestOperation *r in requests)
        {
            [self.client enqueueHTTPRequestOperation:r];
        }
        
        self.startDownloadingPortionDate = NSDate.date;
}


- (void)enqueuePortion:(DownloadPortion *)portion
{
    log(@"enqueuePortion %@ to queue %@", portion.title, self.queue);
    
    // отключаем таймер, чтобы не засыпало, пока качаем
    UIApplication.sharedApplication.idleTimerDisabled = YES;
    
    @synchronized(self.class)
    {
        if (!self.currentPortion)
        {
            log(@"currentPortion = %@", portion.title);
            // если ничего не скачиваем - сразу запускаем очередь
            self.currentPortion = portion;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self performEnqueue];
            });
        }
        else 
        {
            log(@"added to queue %@", portion.title);
            // иначе сохраняем на потом
            self.portionsQueue = self.portionsQueue ? [self.portionsQueue arrayByAddingObject:portion] : @[portion];
        }
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
//
//- (NSInteger)bytesPerSecond
//{
//    CGFloat spentSeconds = -self.startDownloadingPortionDate.timeIntervalSinceNow;
//    
//    if (spentSeconds > CUT_DOWNLOAD_SIZE_PERIOD && self.cutDownloadedSize == 0)
//    {
//        // обрезаем то, что скачано за первую секунду, чтобы не влияло на скорость уже загруженное
//        self.cutDownloadedSize = self.queue.bytesDownloadedSoFar;
//    }
//    
//    CGFloat downloadedSize = self.queue.bytesDownloadedSoFar - self.cutDownloadedSize;
//    return roundf(downloadedSize / spentSeconds);
//}
//
//- (NSTimeInterval)remainingTimeInterval
//{
//    CGFloat bytesPerSecond = self.bytesPerSecond;
//    
//    if (bytesPerSecond == 0)
//        return 0;
//    
//    CGFloat estimateSize = self.queue.totalBytesToDownload - self.queue.bytesDownloadedSoFar;
//    CGFloat estimateSeconds = estimateSize / bytesPerSecond;
//    return roundf(estimateSeconds);
//}

- (void)resume
{
    if (self.currentPortion)
    {
        DownloadPortion *c = self.currentPortion;
        self.currentPortion = nil;
        [self.client.operationQueue cancelAllOperations];
        // немного отложим, чтоб успели очиститься старые реквесты
        doAfter(2, ^{
            [self enqueuePortion:c];
        });
    }
}

- (BOOL)isDownloadingPortion:(NSString *)portion
{
    @synchronized(self.class)
    {
        return [self.currentPortion.title isEqualToString:portion] || [self.portionsQueue any:^BOOL(id object){
            DownloadPortion *p = object;
            return [p.title isEqualToString:portion];
        }];
    }
}

- (void)cancelAllPortions
{
    @synchronized(self.class)
    {
        self.portionsQueue = nil;
        self.currentPortion = nil;
        [self.client.operationQueue cancelAllOperations];
    }
}

- (void)cancelPortion:(NSString *)portion
{
    @synchronized(self.class)
    {
        if ([self.currentPortion.title isEqualToString:portion])
        {
            // чтобы уведомление не отправилось - обнуляем
            self.currentPortion = nil;
            [self.client.operationQueue cancelAllOperations];
            
            // откладываем, иначе реквесты cancell-ется
            [self performSelector:@selector(didDownloadPortion) withObject:nil afterDelay:1];
        }
        else
        {
            self.portionsQueue = [self.portionsQueue where:^BOOL(id object){
                DownloadPortion *p = object;
                return ![p.title isEqualToString:portion];
            }];
        }
    }
}

- (void)didDownloadPortion
{
    // возвращаем засыпание в зад
    if (self.portionsQueue.count == 0)
        UIApplication.sharedApplication.idleTimerDisabled = NO;
    
    if (self.wasError)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self notifyObserversWithError];
        });
        
        [self.client.operationQueue cancelAllOperations];
        self.currentPortion = nil;
        self.wasError = NO;
        return;
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self notifyObserversWithFinish];
    });
    
    [self.client.operationQueue cancelAllOperations];
    self.currentPortion = nil;
    
    @synchronized(self.class)
    {
        if (self.portionsQueue.count > 0)
        {
            DownloadPortion *first = self.portionsQueue.firstObject;
            self.portionsQueue = [self.portionsQueue subarrayWithRange:NSMakeRange(1, self.portionsQueue.count - 1)];
            [self enqueuePortion:first];
        }
    }
}

- (void)didStartRequest:(NSNotification *)notification
{
    id request = notification.object;
    NSArray *requests = self.currentRequests ? self.currentRequests : @[];
    self.currentRequests = [requests arrayByAddingObject:request];
}

- (void)removeRequestFromCurrent:(NSOperation *)request
{
    NSMutableArray *requests = self.currentRequests.mutableCopy;
    [requests removeObject:request];
    self.currentRequests = requests;
}

- (void)didFinishRequest:(NSOperation *)request
{
    [self removeRequestFromCurrent:request];
}

- (void)didFailRequest:(NSOperation *)request
{
    self.wasError = YES;
    [self removeRequestFromCurrent:request];    
}

@end
