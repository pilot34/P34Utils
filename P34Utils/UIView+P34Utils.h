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

// добавляет BlockTapGestureRecognizer
- (void)addTapAction:(BasicBlock)action;
- (void)removeAllGestureRecognizers;

// выстраивает view по высоте друг за другом
- (void)lineUpSubviews:(NSArray *)subviews padding:(CGFloat)padding;

// удаляем все дочерние view
- (void)removeAllSubviews;

@property(nonatomic) BOOL visible;

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGPoint origin;
@property(nonatomic) CGSize size;

@property(nonatomic) CGFloat rightOffset;
@property(nonatomic) CGFloat bottomOffset;

- (void)setRight:(CGFloat)right changeWidth:(BOOL)changeWidth;
- (void)setBottom:(CGFloat)bottom changeHeight:(BOOL)changeHeight;

- (void)setRightOffset:(CGFloat)offset changeWidth:(BOOL)changeWidth;
- (void)setBottomOffset:(CGFloat)offset changeHeight:(BOOL)changeHeight;

- (void)roundOrigin;

@end
