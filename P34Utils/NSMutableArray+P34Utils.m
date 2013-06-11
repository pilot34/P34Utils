//
//  NSMutableArray+Utils.m
//  Intuit
//
//  Created by Глеб Тарасов on 13.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSMutableArray+P34Utils.h"

@implementation NSMutableArray (Utils)

- (id)popObject
{
    if (self.count == 0)
        return nil;
    
    NSInteger lastIndex = self.count - 1;
    id result = self[lastIndex];
    [self removeObjectAtIndex:lastIndex];
    return result;
}

- (id)popFirstObject
{
    if (self.count == 0)
        return nil;
    
    id result = self[0];
    [self removeObjectAtIndex:0];
    return result;
}

- (id)popRandomObject
{
    if (self.count == 0)
        return nil;

    NSInteger index = arc4random() % self.count;
    id element = self[index];
    [self removeObjectAtIndex:index];
    return element;
}

@end
