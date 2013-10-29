//
//  NSArray+Utils.m
//  Intuit
//
//  Created by Глеб Тарасов on 16.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSArray+P34Utils.h"

@implementation NSArray (Utils)

- (id)firstObject
{
    if (self.count == 0)
        return nil;
    return self[0];
}

- (id)randomObject
{
    if (self.count == 0)
        return nil;
    
    NSInteger index = arc4random() % self.count;
    return self[index];
}

- (NSArray *)arrayByRemovingObject:(id)object
{
    NSMutableArray *copy = self.mutableCopy;
    [copy removeObject:object];
    return copy;
}

- (NSArray *)shuffled
{
	NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:[self count]];
    
	for (id anObject in self)
	{
		NSUInteger randomPos = arc4random()%([tmpArray count]+1);
		[tmpArray insertObject:anObject atIndex:randomPos];
	}
    
	return [NSArray arrayWithArray:tmpArray];
}

- (NSArray *)reversed
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator)
    {
        [array addObject:element];
    }
    return array;
}

- (NSArray *)sortedArrayByKey:(NSString *)key
{
    NSSortDescriptor *s = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
    return [self sortedArrayUsingDescriptors:@[s]];
}

- (NSArray *)sortedArrayAlphabetically
{
    return [self sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

#pragma mark - LINQ

- (BOOL)any
{
    return self.count > 0;
}

- (id)single:(PredicateBlock)predicate
{
    id first = [self first:predicate];
    assert(first != nil);
    return first;
}

- (id)first:(PredicateBlock)predicate
{
    for (id obj in self)
    {
        if (predicate(obj))
            return obj;
    }
    
    return nil;
}

- (NSArray *)where:(PredicateBlock)predicate
{
    NSMutableArray *result = [NSMutableArray array];
    for (id obj in self) 
    {
        if (predicate(obj))
            [result addObject:obj];
    }
    
    return result;
}

- (NSArray *)select:(SelectBlock)transform
{
    NSMutableArray *result = [NSMutableArray array];
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
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        action(obj);
    }];
}

- (NSDictionary *)dictionaryWithKeyBlock:(SelectBlock)keyBlock
{
    return [self dictionaryWithKeyBlock:keyBlock valueBlock:^id(id element) {
        return element;
    }];
}

- (NSDictionary *)dictionaryWithKeyBlock:(SelectBlock)keyBlock valueBlock:(SelectBlock)valueBlock
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (id obj in self)
    {
        id key = keyBlock(obj);
        id value = valueBlock(obj);
        result[key] = value;
    }
    return result;
}

@end
