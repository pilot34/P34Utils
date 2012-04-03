//
//  StringUtils.h
//  Intuit
//
//  Created by Глеб Тарасов on 11.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtils : NSObject

+ (NSArray *)splitByCapitalLetters:(NSString *)string;

+ (NSString *)getCase:(NSInteger)num 
           nominative:(NSString *)nominative
             genitive:(NSString *)genitive 
       pluralGenitive:(NSString *)pluralGenitive;

+ (NSString *)sizeToString:(NSInteger)bytes;

+ (NSString *)timeIntervalToStringFull:(NSTimeInterval)time;
+ (NSString *)timeIntervalToStringShort:(NSTimeInterval)time;

@end
