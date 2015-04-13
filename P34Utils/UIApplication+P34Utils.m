//
//  UIApplication+Utils.m
//  Intuit
//
//  Created by Глеб Тарасов on 23.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIApplication+P34Utils.h"

@implementation UIApplication (Utils)

#ifndef P34_APP_EXTENSIONS
+ (BOOL)landscape
{
    return UIInterfaceOrientationIsLandscape([[self sharedApplication] statusBarOrientation]);
}
#endif

@end
