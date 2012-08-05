//
//  NSArray+Utils.h
//  Intuit
//
//  Created by Глеб Тарасов on 16.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^PredicateBlock)(id element);
typedef id(^SelectBlock)(id element);

@interface NSArray (Utils)

@property(nonatomic, readonly, unsafe_unretained) id firstObject;
@property(nonatomic, readonly, unsafe_unretained) id randomObject;

- (NSArray *)shuffled;
- (NSArray *)reversed;

@property(nonatomic, readonly) BOOL any;

- (NSArray *)where:(PredicateBlock)predicate;
- (NSArray *)select:(SelectBlock)transform;
- (BOOL)any:(PredicateBlock)predicate;

- (NSDictionary *)dictionaryWithKeyBlock:(SelectBlock)keyBlock;
- (NSDictionary *)dictionaryWithKeyBlock:(SelectBlock)keyBlock valueBlock:(SelectBlock)valueBlock;

@end
