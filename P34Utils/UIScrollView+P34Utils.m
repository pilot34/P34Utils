//
//  UIScrollView+Utils.m
//  AldoCoppola
//
//  Created by Глеб Тарасов on 05.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIScrollView+P34Utils.h"

@implementation UIScrollView (Utils)

- (CGFloat)contentOffsetX
{
    return self.contentOffset.x;
}

- (void)setContentOffsetX:(CGFloat)contentOffsetX animated:(BOOL)animated
{
    CGPoint offset = self.contentOffset;
    offset.x = contentOffsetX;
    [self setContentOffset:offset animated:animated];
}

- (void)setContentOffsetX:(CGFloat)contentOffsetX
{
    [self setContentOffsetX:contentOffsetX animated:NO];
}

- (CGFloat)contentOffsetY
{
    return self.contentOffset.y;
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY animated:(BOOL)animated
{
    CGPoint offset = self.contentOffset;
    offset.y = contentOffsetY;
    [self setContentOffset:offset animated:animated];
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY
{
    [self setContentOffsetY:contentOffsetY animated:NO];
}

- (CGFloat)contentSizeWidth
{
    return self.contentSize.width;
}

- (void)setContentSizeWidth:(CGFloat)contentSizeWidth
{
    self.contentSize = CGSizeMake(contentSizeWidth, self.contentSizeHeight);
}

- (CGFloat)contentSizeHeight
{
    return self.contentSize.height;
}

- (void)setContentSizeHeight:(CGFloat)contentSizeHeight
{
    self.contentSize = CGSizeMake(self.contentSizeWidth, contentSizeHeight);
}

@end
