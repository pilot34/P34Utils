//
//  Analytics.m
//  Intuit
//
//  Created by Глеб Тарасов on 25.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Analytics.h"
#import "GANTracker.h"
#import "UIDevice+IdentifierAddition.h"
#import "Utils.h"

@implementation Analytics

+ (void)startWithId:(NSString *)id
{
    [[GANTracker sharedTracker] startTrackerWithAccountID:id 
                                           dispatchPeriod:10 
                                                 delegate:nil];
    
    [[GANTracker sharedTracker] setCustomVariableAtIndex:1
                                                    name:@"app_version"
                                                   value:APP_VERSION
                                                   scope:kGANVisitorScope
                                               withError:nil];
    
    [[GANTracker sharedTracker] setCustomVariableAtIndex:2
                                                    name:@"ios_version"
                                                   value:UIDevice.currentDevice.systemVersion
                                                   scope:kGANVisitorScope
                                               withError:nil];
    
    [[GANTracker sharedTracker] setCustomVariableAtIndex:3
                                                    name:@"identifier"
                                                   value:UIDevice.currentDevice.uniqueDeviceIdentifier
                                                   scope:kGANVisitorScope
                                               withError:nil];
}


+ (void)setCustomVariable:(NSString *)name value:(NSString *)value
{
    [[GANTracker sharedTracker] setCustomVariableAtIndex:5
                                                    name:name
                                                   value:value
                                                   scope:kGANVisitorScope
                                               withError:nil];
}

+ (void)trackPageView:(NSString *)page
{
    [[GANTracker sharedTracker] trackPageview:page
                                    withError:nil];
}

+ (void)trackEvent:(NSString *)event
            action:(NSString *)action
{
    [[GANTracker sharedTracker] trackEvent:event
                                    action:action
                                     label:event
                                     value:0
                                 withError:nil];
}

+ (void)trackEvent:(NSString *)event
{
    [self trackEvent:event action:event];
}


@end
