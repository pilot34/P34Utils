//
//  UIView+P34Utils.h
//  erundopel
//
//  Created by Глеб Тарасов on 11.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P34Utils.h"

@interface UIView (Utils)

+ (id)fromNib;
+ (id)fromNibWithOwner:(id)owner;
+ (id)fromNib:(NSString *)nibName withOwner:(id)owner;

- (void)removeAllGestureRecognizers;
- (void)removeAllSubviews;

@property(nonatomic) BOOL visible;

@end
