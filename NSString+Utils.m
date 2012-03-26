//
//  NSString+Utils.m
//  Intuit
//
//  Created by Глеб Тарасов on 13.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (BOOL)containsString:(NSString *)string
{
    return [self rangeOfString:string].location != NSNotFound;
}

- (BOOL)startsWith:(NSString *)string
{
    return [self rangeOfString:string].location == 0;
}

- (BOOL)endsWith:(NSString *)string
{
    return [self rangeOfString:string].location + string.length == self.length;
}

- (NSString *)stringByTrimming
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (CGFloat)heightWithSystemFont:(CGFloat)fontSize
       constrainedToWidth:(CGFloat)width
{
    return [self heightWithFont:[UIFont systemFontOfSize:fontSize]
                                      constrainedToWidth:width
                                           lineBreakMode:UILineBreakModeTailTruncation];
}

@end
