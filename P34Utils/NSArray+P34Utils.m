//
//  NSArray+Utils.m
//  Intuit
//
//  Created by Глеб Тарасов on 16.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSArray+P34Utils.h"

@implementation NSArray (Utils)

- (id)randomObject
{
    if (self.count == 0)
        return nil;
    
    NSInteger index = arc4random() % self.count;
    return self[index];
}

- (BOOL)any
{
    return self.count > 0;
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

- (NSDictionary *)dictionaryWithKeyBlock:(id (^)(id))keyBlock
{
    return [self dictionaryWithKeyBlock:keyBlock valueBlock:^id(id element) {
        return element;
    }];
}

- (NSDictionary *)dictionaryWithKeyBlock:(id (^)(id))keyBlock valueBlock:(id (^)(id))valueBlock
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
