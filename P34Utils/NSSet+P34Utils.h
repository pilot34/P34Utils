//
//  NSSet+P34Utils.h
//  Intuit
//
//  Created by Глеб Тарасов on 16.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+P34Utils.h"

@interface NSSet (Utils)


@property(nonatomic, readonly) BOOL any;

- (NSArray *)sortedArrayByKey:(NSString *)key;
- (NSSet *)where:(PredicateBlock)predicate;
- (NSSet *)select:(SelectBlock)transform;
- (BOOL)any:(PredicateBlock)predicate;

@end
