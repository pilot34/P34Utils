//
//  Reachability+Utils.m
//  Intuit
//
//  Created by Глеб Тарасов on 06.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Reachability+P34Utils.h"

static Reachability *__wifiShared;
static Reachability *__internetShared;

@implementation Reachability (Utils)

+ (Reachability *)wifiShared
{
    if (!__wifiShared)
    {
        @synchronized(self)
        {
            if (!__wifiShared)
            {
                __wifiShared = [Reachability reachabilityForLocalWiFi];
            }
        }
    }
    
    return __wifiShared;
}

+ (Reachability *)internetShared
{
    if (!__internetShared)
    {
        @synchronized(self)
        {
            if (!__internetShared)
            {
                __internetShared = [Reachability reachabilityForInternetConnection];
            }
        }
    }
    
    return __internetShared;
}

+ (BOOL)isWiFiReachable
{
    return [[self wifiShared] isReachable];
}

+ (BOOL)isInternetReachable
{
    return [[self internetShared] isReachable];
}

@end
