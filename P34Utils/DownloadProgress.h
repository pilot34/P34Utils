//
//  DownloadProgress.h
//  abookclub
//
//  Created by Глеб Тарасов on 28.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadProgress : NSObject

@property(nonatomic) CGFloat progress;
@property(nonatomic) NSInteger downloadedBytes;
@property(nonatomic) NSInteger totalBytes;
@property(nonatomic) NSInteger bytesPerSecond;
@property(nonatomic) NSTimeInterval remainingTime;

- (NSString *)remainingTimeString;
- (NSString *)bytesString;

@end
