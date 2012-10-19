//
//  UIWebView+P34Utils.h
//  Intuit
//
//  Created by Глеб Тарасов on 08.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (Utils)

- (UIScrollView *)scrollView;
- (void)loadRequestWithString:(NSString *)urlString;

@end
