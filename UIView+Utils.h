//
//  UIView+Utils.h
//  erundopel
//
//  Created by Глеб Тарасов on 11.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIViewAutoresizingAll UIViewAutoresizingFlexibleLeftMargin \
                                | UIViewAutoresizingFlexibleWidth\
                                | UIViewAutoresizingFlexibleRightMargin\
                                | UIViewAutoresizingFlexibleTopMargin\
                                | UIViewAutoresizingFlexibleHeight\
                                | UIViewAutoresizingFlexibleBottomMargin

@interface UIView (Utils)

+ (id)fromNib;
+ (id)fromNibWithOwner:(id)owner;
+ (id)fromNib:(NSString *)nibName withOwner:(id)owner;

// выстраивает view по высоте друг за другом
- (void)lineUpSubviews:(NSArray *)subviews padding:(CGFloat)padding;

// удаляем все дочерние view
- (void)removeAllSubviews;


@property(nonatomic, assign) CGFloat left;
@property(nonatomic, assign) CGFloat right;
@property(nonatomic, assign) CGFloat top;
@property(nonatomic, assign) CGFloat bottom;

@property(nonatomic, assign) CGFloat centerX;
@property(nonatomic, assign) CGFloat centerY;

@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;

@property(nonatomic, assign) CGPoint origin;
@property(nonatomic, assign) CGSize size;

@property(nonatomic, assign) CGFloat rightOffset;
@property(nonatomic, assign) CGFloat bottomOffset;

- (void)setRight:(CGFloat)right changeWidth:(BOOL)changeWidth;
- (void)setBottom:(CGFloat)bottom changeHeight:(BOOL)changeHeight;

- (void)setRightOffset:(CGFloat)offset changeWidth:(BOOL)changeWidth;
- (void)setBottomOffset:(CGFloat)offset changeHeight:(BOOL)changeHeight;

@end
