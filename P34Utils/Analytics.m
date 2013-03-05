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
#import "Flurry.h"

static BOOL __use_flurry;

@implementation Analytics

+ (void)startWithGoogleId:(NSString *)google flurryId:(NSString *)flurryId
{
    [self startWithId:google];
    [Flurry startSession:flurryId];
    __use_flurry = YES;
}

+ (void)startWithId:(NSString *)id
{
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [[GAI sharedInstance] trackerWithTrackingId:id];
}

+ (void)trackPageView:(NSString *)page
{
    [[[GAI sharedInstance] defaultTracker] trackView:page];
    
    if (__use_flurry)
        [Flurry logPageView];
}

+ (void)trackEvent:(NSString *)event
            action:(NSString *)action
{
    [[[GAI sharedInstance] defaultTracker] trackEventWithCategory:event
                                                       withAction:action
                                                        withLabel:action
                                                        withValue:@0];
    
    if (__use_flurry)
        [Flurry logEvent:event withParameters:@{ @"action" : action }];
}

+ (void)trackEvent:(NSString *)event
{
    [self trackEvent:event action:event];
}


@end
