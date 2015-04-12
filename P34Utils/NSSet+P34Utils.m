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

@end
