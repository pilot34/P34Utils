//
//  NSSet+Utils.m
//  Intuit
//
//  Created by Глеб Тарасов on 16.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSSet+Utils.h"

@implementation NSSet (Utils)

#pragma mark - LINQ

- (BOOL)any
{
    return self.count > 0;
}

- (NSSet *)where:(PredicateBlock)predicate
{
    NSMutableSet *result = [NSMutableSet set];
    for (id obj in self) 
    {
        if (predicate(obj))
            [result addObject:obj];
    }
    
    return result;
}

- (NSSet *)select:(SelectBlock)transform
{
    NSMutableSet *result = [NSMutableArray array];
    for (id obj in self) 
    {
        [result addObject:transform(obj)];
    }
    
    return result; 
}

- (BOOL)any:(PredicateBlock)predicate
{
    for (id obj in self) 
    {
        if (predicate(obj))
            return YES;
    }
    
    return NO;
}

@end
