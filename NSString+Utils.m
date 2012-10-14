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
    return [self rangeOfString:string options:NSBackwardsSearch].location + string.length == self.length;
}

- (NSString *)stringByTrimming
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSRange)fullRange
{
    return NSMakeRange(0, self.length);
}

- (NSString *)stringBySimpleStrippingTags
{
    NSMutableString *ms = [NSMutableString stringWithCapacity:[self length]];

    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    NSString *s = nil;
    while (![scanner isAtEnd])
    {
        [scanner scanUpToString:@"<" intoString:&s];
        if (s != nil)
            [ms appendString:s];
        [scanner scanUpToString:@">" intoString:NULL];
        if (![scanner isAtEnd])
            [scanner setScanLocation:[scanner scanLocation]+1];
        s = nil;
    }
    
    return ms;
}

@end
