//
//  StringUtils.m
//  Intuit
//
//  Created by Глеб Тарасов on 11.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils

+ (NSArray *)splitByCapitalLetters:(NSString *)string
{
    if (!string)
        return nil;
    
    if (string.length == 0)
        return [NSArray array];
    
    if (string.length == 1)
        return [NSArray arrayWithObject:[string lowercaseString]];
    
    NSMutableArray *result = [NSMutableArray array];
    NSInteger lastCapital = 0;
    
    for (int i = 1; i < string.length + 1; ++i)
    {
        unichar c = i == string.length ? 0 : [string characterAtIndex:i];
        
        if (isupper(c) || i == string.length)
        {
            NSRange range;
            range.length = i - lastCapital;
            range.location = lastCapital;
            
            NSString *part = [string substringWithRange:range];
            [result addObject:part.lowercaseString];
            lastCapital = i;
        }
    }
    
    return result;
}

@end
