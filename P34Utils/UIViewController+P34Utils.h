//
//  UIViewController+P34Utils.h
//  Intuit
//
//  Created by Глеб Тарасов on 11.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)

+ (id)fromNib:(NSString *)nibName;
+ (id)fromNib;
+ (id)fromStoryboard:(UIStoryboard *)storyboard;

@end
