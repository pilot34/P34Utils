//
//  DownloadProgress.m
//  abookclub
//
//  Created by Глеб Тарасов on 28.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DownloadProgress.h"
#import "StringUtils.h"

@implementation DownloadProgress

- (NSString *)remainingTimeString
{
    return [StringUtils timeIntervalToStringFull:self.remainingTime];
}

- (NSString *)bytesString
{
    return [NSString stringWithFormat:@"%@ / %@", [StringUtils sizeToString:self.downloadedBytes], [StringUtils sizeToString:self.totalBytes]];
}

@end
