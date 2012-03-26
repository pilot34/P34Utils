//
//  UIWebView+Utils.m
//  Intuit
//
//  Created by Глеб Тарасов on 08.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIWebView+Utils.h"

@implementation UIWebView (Utils)

- (UIScrollView *)scrollView
{
    for (id v in self.subviews) 
    {
        if ([v isKindOfClass:UIScrollView.class])
            return v;
    }
    return nil;
}

@end
