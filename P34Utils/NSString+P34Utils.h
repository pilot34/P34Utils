//
//  NSString+P34Utils.h
//  Intuit
//
//  Created by Глеб Тарасов on 13.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

- (NSString *)stringByTrimming;
- (NSString *)stringBySimpleStrippingTags;
- (NSRange)fullRange;

- (CGFloat)heightWithFont:(UIFont *)font
       constrainedToWidth:(CGFloat)width;

- (NSString *)stringByAddingPercentEscapesForURLParameter;

- (NSString *)md5Hash;
- (NSString *)sha1Hash;

@end
