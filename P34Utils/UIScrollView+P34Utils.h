//
//  UIScrollView+P34Utils.h
//  AldoCoppola
//
//  Created by Глеб Тарасов on 05.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Utils)

@property(nonatomic) CGFloat contentOffsetX;
@property(nonatomic) CGFloat contentOffsetY;

@property(nonatomic) CGFloat contentSizeWidth;
@property(nonatomic) CGFloat contentSizeHeight;

- (void)setContentOffsetX:(CGFloat)contentOffsetX animated:(BOOL)animated;
- (void)setContentOffsetY:(CGFloat)contentOffsetY animated:(BOOL)animated;

@end
