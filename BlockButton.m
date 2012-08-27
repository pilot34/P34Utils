//
//  BlockButton.m
//  SportDiary
//
//  Created by Gleb Tarasov on 27.08.12.
//  Copyright (c) 2012 Gleb Taraov. All rights reserved.
//

#import "BlockButton.h"

@implementation BlockButton

- (id)init
{
    self = [super init];
    if (self)
    {
        [self addTarget:self
                 action:@selector(tapped)
       forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    return [self init];
}

- (id)initWithAction:(BasicBlock)action
{
    self = [self init];
    if (self)
    {
        self.action = action;
    }
    return self;
}

- (UIButtonType)buttonType
{
    return UIButtonTypeCustom;
}

- (void)tapped
{
    if (self.action)
        self.action();
}

@end
