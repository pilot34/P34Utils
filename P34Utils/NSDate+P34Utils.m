//
//  NSDate+Utils.m
//  AldoCoppola
//
//  Created by Глеб Тарасов on 05.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDate+P34Utils.h"

@implementation NSDate (Utils)

- (NSDate *)dateWithoutTime
{
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit
                                                                        |NSMonthCalendarUnit
                                                                        |NSDayCalendarUnit)
                                                              fromDate:self];
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

- (NSDate *)firstDayOfMonth
{
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit
                                                                        |NSMonthCalendarUnit)
                                                              fromDate:self];
    comps.day = 1;
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

@end
