//
//  UIView+Utils.m
//  erundopel
//
//  Created by Глеб Тарасов on 11.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIView+P34Utils.h"

@implementation UIView (Utils)

#pragma mark - Xib

+ (id)fromNib
{
    return [self fromNibWithOwner:nil];
}

+ (id)fromNibWithOwner:(id)owner
{
    return [self fromNib:NSStringFromClass(self) 
               withOwner:owner];
}

+ (id)fromNib:(NSString *)nibName withOwner:(id)owner
{
    return [[NSBundle mainBundle] loadNibNamed:nibName
                                          owner:owner 
                                        options:nil][0];
}

- (BOOL)visible
{
    return !self.hidden;
}

- (void)setVisible:(BOOL)visible
{
    [self setHidden:!visible];
}

#pragma mark - Other Helpers

- (void)removeAllSubviews
{
    for (UIView *view in self.subviews) 
    {
        [view removeFromSuperview];
    }
}

- (void)removeAllGestureRecognizers
{
    for (UIGestureRecognizer *g in self.gestureRecognizers)
        [self removeGestureRecognizer:g];
}

@end
