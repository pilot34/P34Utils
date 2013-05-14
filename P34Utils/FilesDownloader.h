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

@protocol FilesDownloaderDelegate <NSObject>

@optional

- (void)filesDownloaderDidFailForPortion:(DownloadPortion *)portion;
- (void)filesDownloaderDidDownloadPortion:(DownloadPortion *)portion;
- (void)filesDownloaderDidChangeProgress:(DownloadProgress *)progress
                              forPortion:(DownloadPortion *)portion;

@end

@interface FilesDownloader : NSObject

+ (id)shared;

- (void)addObserver:(id<FilesDownloaderDelegate>)observer;
- (void)removeObserver:(id)observer;
- (void)enqueuePortion:(DownloadPortion *)portion;

- (BOOL)isDownloadingPortion:(NSString *)portion;

// нужно вызывать в applicationDidEnterForeground
- (void)resume;

- (void)cancelAllPortions;
- (void)cancelPortion:(NSString *)portion;

@end
