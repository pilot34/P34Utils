//
//  UIScrollView+Utils.m
//  AldoCoppola
//
//  Created by Глеб Тарасов on 05.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIScrollView+P34Utils.h"

@implementation UIScrollView (Utils)

- (void)setContentOffsetX:(CGFloat)contentOffsetX animated:(BOOL)animated
{
    CGPoint offset = self.contentOffset;
    offset.x = contentOffsetX;
    [self setContentOffset:offset animated:animated];
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY animated:(BOOL)animated
{
    CGPoint offset = self.contentOffset;
    offset.y = contentOffsetY;
    [self setContentOffset:offset animated:animated];
}

@end
