//
//  NSMutableString+Utils.m
//  iGuides
//
//  Created by Глеб Тарасов on 27.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSMutableString+P34Utils.h"

@implementation NSMutableString (Utils)

- (void)replaceOccurrencesOfString:(NSString *)pattern withString:(NSString *)replaceStr
{
    [self replaceOccurrencesOfString:pattern withString:replaceStr options:0 range:NSMakeRange(0, self.length)];
}

@end
