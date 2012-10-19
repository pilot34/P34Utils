//
//  UIWebView+Utils.m
//  Intuit
//
//  Created by Глеб Тарасов on 08.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIWebView+P34Utils.h"

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

- (void)loadRequestWithString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self loadRequest:request];
}

@end
