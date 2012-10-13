//
//  BlockSwipeGestureRecognizer.m
//  iGuides
//
//  Created by Глеб Тарасов on 15.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BlockSwipeGestureRecognizer.h"

@interface BlockSwipeGestureRecognizer()

@property(copy, nonatomic) BasicBlock action;

@end

@implementation BlockSwipeGestureRecognizer

- (id)initWithAction:(BasicBlock)action
{
    self = [super initWithTarget:self action:@selector(swiped:)];
    if (self)
    {
        self.action = action;
        self.delegate = self;
    }
    return self;
}

- (void)swiped:(UISwipeGestureRecognizer *)sender
{
    if (self.action)
        self.action();
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

@end
