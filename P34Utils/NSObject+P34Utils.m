//
//  NSObject+Utils.m
//  Intuit
//
//  Created by Глеб Тарасов on 18.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSObject+P34Utils.h"

@implementation NSObject (Utils)

- (void)performSelectorAfterRunLoop:(SEL)aSelector
{
    [self performSelector:aSelector withObject:nil afterDelay:0];
}

@end
