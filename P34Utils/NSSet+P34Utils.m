//
//  NSSet+Utils.m
//  Intuit
//
//  Created by Глеб Тарасов on 16.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSSet+P34Utils.h"

@implementation NSSet (Utils)

#pragma mark - LINQ

- (BOOL)any
{
    return self.count > 0;
}

- (NSArray *)sortedArrayByKey:(NSString *)key
{
    NSSortDescriptor *s = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
    return [self sortedArrayUsingDescriptors:@[s]];
}

- (NSSet *)setByRemovingObject:(id)object
{
    NSMutableSet *copy = self.mutableCopy;
    [copy removeObject:object];
    return copy;
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
    NSMutableSet *result = [NSMutableSet set];
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

- (void)each:(EnumerateBlock)action
{
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        action(obj);
    }];
}

@end
