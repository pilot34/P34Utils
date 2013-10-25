//
//  BlockTapGestureRecognizer.m
//  iGuides
//
//  Created by Глеб Тарасов on 16.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BlockTapGestureRecognizer.h"

@interface BlockTapGestureRecognizer()

@property(copy, nonatomic) BasicBlock action;

@end

@implementation BlockTapGestureRecognizer

- (id)initWithAction:(BasicBlock)action
{
    self = [super initWithTarget:self action:@selector(tapped:)];
    if (self)
    {
        self.action = action;
        self.delegate = self;
    }
    return self;
}

- (void)tapped:(UITapGestureRecognizer *)sender
{

    if (self.action)
        self.action();
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch 
{
    return ![[touch.view class] isSubclassOfClass:[UIButton class]] || ![[touch.view class] isSubclassOfClass:[UITextField class]];
}

@end
