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

#pragma mark - Coordinates

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = top;
    self.frame = newFrame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.height;
}

- (void)setBottom:(CGFloat)bottom
{
    [self setBottom:bottom changeHeight:NO];
}

- (void)setBottom:(CGFloat)bottom changeHeight:(BOOL)changeHeight
{
    if (changeHeight)
    {
        self.height = bottom - self.top;   
    }
    else
    {
        self.top = bottom - self.height;
    }
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = left;
    self.frame = newFrame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.width;
}

- (void)setRight:(CGFloat)right
{
    [self setRight:right changeWidth:NO];
}

- (void)setRight:(CGFloat)right changeWidth:(BOOL)changeWidth
{
    if (changeWidth)
    {
        self.width = right - self.left;
    }
    else
    {
        self.left = right - self.width;
    }
}

- (CGFloat)width
{
    return self.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect newFrame = self.frame;
    newFrame.size.width = width;
    self.frame = newFrame;
}

- (CGFloat)height
{
    return self.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect newFrame = self.frame;
    newFrame.size.height = height;
    self.frame = newFrame;
 
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect newFrame = self.frame;
    newFrame.origin = origin;
    self.frame = newFrame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect newFrame = self.frame;
    newFrame.size = size;
    self.frame = newFrame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)rightOffset
{
    return self.superview.width - self.left - self.width;
}

- (void)setRightOffset:(CGFloat)rightOffset
{
    [self setRightOffset:rightOffset changeWidth:NO];
}

- (void)setRightOffset:(CGFloat)offset changeWidth:(BOOL)changeWidth
{
    if (changeWidth)
    {
        self.width = self.superview.width - offset - self.left;
    }
    else
    {
        self.left = self.superview.width - offset - self.width;
    }
}

- (CGFloat)bottomOffset
{
    return self.superview.height - self.top - self.height;
}

- (void)setBottomOffset:(CGFloat)bottomOffset
{
    [self setBottomOffset:bottomOffset changeHeight:NO];
}

- (void)setBottomOffset:(CGFloat)offset changeHeight:(BOOL)changeHeight
{
    if (changeHeight)
    {
        self.height = self.superview.height - offset - self.top;
    }
    else
    {
        self.top = self.superview.height - offset - self.height;
    }
}

- (void)roundOrigin
{
    self.origin = CGPointMake(roundf(self.left), roundf(self.top));
}

#pragma mark - Other Helpers

- (void)removeAllSubviews
{
    for (UIView *view in self.subviews) 
    {
        [view removeFromSuperview];
    }
}

- (void)lineUpSubviews:(NSArray *)subviews padding:(CGFloat)padding
{
    UIView *prev = nil;
    for (UIView *v in subviews) 
    {
        if (prev)
        {
            self.top = prev.bottom + padding;
        }
        
        prev = v;
    }
}

- (void)addTapAction:(BasicBlock)action
{
    self.userInteractionEnabled = YES;
    BlockTapGestureRecognizer *b = [[BlockTapGestureRecognizer alloc] initWithAction:action];
    [self addGestureRecognizer:b];
}

- (void)removeAllGestureRecognizers
{
    for (UIGestureRecognizer *g in self.gestureRecognizers)
        [self removeGestureRecognizer:g];
}

@end
