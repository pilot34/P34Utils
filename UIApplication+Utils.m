//
//  UIApplication+Utils.m
//  Intuit
//
//  Created by Глеб Тарасов on 23.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIApplication+Utils.h"

@implementation UIApplication (Utils)

+ (BOOL)landscape
{
    return UIInterfaceOrientationIsLandscape([[self sharedApplication] statusBarOrientation]);
}

@end
