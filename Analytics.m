//
//  Analytics.m
//  Intuit
//
//  Created by Глеб Тарасов on 25.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Analytics.h"
#import "GANTracker.h"

@implementation Analytics

+ (void)startWithId:(NSString *)id
{
    [[GANTracker sharedTracker] startTrackerWithAccountID:id 
                                           dispatchPeriod:10 
                                                 delegate:nil];
    
    [[GANTracker sharedTracker] setCustomVariableAtIndex:1
                                                    name:@"app_version"
                                                   value:[NSBundle.mainBundle.infoDictionary objectForKey:@"CFBundleVersion"]
                                               withError:nil];
    
    [[GANTracker sharedTracker] setCustomVariableAtIndex:2
                                                    name:@"ios_version"
                                                   value:UIDevice.currentDevice.systemVersion
                                               withError:nil];
    
}

+ (void)trackPageView:(NSString *)page
{
    [[GANTracker sharedTracker] trackPageview:page
                                    withError:nil];
}

+ (void)trackEvent:(NSString *)event
             value:(NSInteger)value
{
    [[GANTracker sharedTracker] trackEvent:event
                                    action:nil
                                     label:nil
                                     value:value
                                 withError:nil];
}

+ (void)trackEvent:(NSString *)event
{
    [self trackEvent:event value:0];
}


@end
