//
//  FilesDownloader.h
//  abookclub
//
//  Created by Глеб Тарасов on 26.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadPortion.h"
#import "DownloadProgress.h"
#import "ASIHTTPRequest.h"

@protocol FilesDownloaderDelegate <NSObject>

@optional

- (void)filesDownloaderDidFailForPortion:(DownloadPortion *)portion;
- (void)filesDownloaderDidDownloadPortion:(DownloadPortion *)portion;
- (void)filesDownloaderDidChangeProgress:(DownloadProgress *)progress
                              forPortion:(DownloadPortion *)portion;

@end

@interface FilesDownloader : NSObject

+ (FilesDownloader *)shared;

- (void)addObserver:(id<FilesDownloaderDelegate>)observer;
- (void)removeObserver:(id)observer;
- (void)enqueuePortion:(DownloadPortion *)portion;

- (void)downloadFileSynchronous:(NSString *)url;

- (BOOL)isDownloadingPortion:(NSString *)portion;

// нужно вызывать в applicationDidEnterForeground
- (void)resume;

- (void)cancelPortion:(NSString *)portion;

// для наследников
- (NSString *)pathForUrl:(NSString *)url inPortion:(NSString *)portionTitle;
- (BOOL)createFolder:(NSString *)folder;
- (NSString *)storeDataFolder;

@end
