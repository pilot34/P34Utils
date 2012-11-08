//
//  Analytics.m
//  Intuit
//
//  Created by Глеб Тарасов on 25.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Analytics.h"
#import "GAI.h"
#import "GAITracker.h"
#import "UIDevice+IdentifierAddition.h"

@implementation Analytics

+ (void)startWithId:(NSString *)id
{
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [[GAI sharedInstance] trackerWithTrackingId:id];
}

+ (void)trackPageView:(NSString *)page
{
    [[[GAI sharedInstance] defaultTracker] trackView:page];
}

+ (void)trackEvent:(NSString *)event
            action:(NSString *)action
{
    [[[GAI sharedInstance] defaultTracker] trackEventWithCategory:event
                                                       withAction:action
                                                        withLabel:action
                                                        withValue:@0];
}

+ (void)trackEvent:(NSString *)event
{
    [self trackEvent:event action:event];
}


@end
