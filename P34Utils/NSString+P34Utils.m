//
//  NSString+Utils.m
//  Intuit
//
//  Created by Глеб Тарасов on 13.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+P34Utils.h"
#import "P34Utils.h"
#import <CommonCrypto/CommonDigest.h>

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

- (CGFloat)heightWithFont:(UIFont *)font
       constrainedToWidth:(CGFloat)width
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0"))
    {
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:self
                                                                  attributes:@{ NSFontAttributeName : font }];
        CGFloat result = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                           context:nil].size.height;
        return ceilf(result);
    }
    else
    {
        return ceilf([self sizeWithFont:font
                      constrainedToSize:CGSizeMake(width, MAXFLOAT)].height);
    }
}

- (NSString *)stringByAddingPercentEscapesForURLParameter
{
    
    CFStringRef buffer =
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (__bridge CFStringRef)self,
                                            NULL,
                                            (__bridge CFStringRef)@";/?:@&=+$,",
                                            kCFStringEncodingUTF8);
    
    NSString *result = [NSString stringWithString:(__bridge NSString *)buffer];
    
    CFRelease(buffer);
    
    return result;
}

- (NSString *)md5Hash
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14],
            result[15]
            ];
}

- (NSString *)sha1Hash
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14],
            result[15], result[16], result[17], result[18], result[19]
            ];
}

@end
