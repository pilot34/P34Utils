//
//  NSArray+P34Utils.h
//  Intuit
//
//  Created by Глеб Тарасов on 16.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Utils)

@property(nonatomic, readonly, unsafe_unretained) id randomObject;

- (NSArray *)sortedArrayAlphabetically;
- (NSArray *)sortedArrayByKey:(NSString *)key;
- (NSArray *)arrayByRemovingObject:(id)object;
- (NSArray *)shuffled;
- (NSArray *)reversed;

@property(nonatomic, readonly) BOOL any;

- (NSDictionary *)dictionaryWithKeyBlock:(id (^)(id obj))keyBlock;
- (NSDictionary *)dictionaryWithKeyBlock:(id (^)(id obj))keyBlock valueBlock:(id (^)(id obj))valueBlock;

@end
