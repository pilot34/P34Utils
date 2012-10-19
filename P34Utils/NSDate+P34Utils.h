//
//  NSDate+P34Utils.h
//  AldoCoppola
//
//  Created by Глеб Тарасов on 05.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TIME_INTERVAL_FOR_ONE_DAY 86400

@interface NSDate (Utils)

- (NSDate *)dateWithoutTime;
- (NSDate *)firstDayOfMonth;

@end
