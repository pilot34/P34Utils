//
//  HiddenTabBarController.m
//  Intuit
//
//  Created by Глеб Тарасов on 25.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HiddenTabBarController.h"

@interface HiddenTabBarController ()

@end

@implementation HiddenTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    for (UIView *v in self.view.subviews) 
    {
        if (v == self.tabBar)
            v.hidden = YES;
        else
            v.frame = self.view.bounds;
    }
}

@end
