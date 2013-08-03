//
//  ButtonWithBackground.m
//  Intuit
//
//  Created by Глеб Тарасов on 13.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ButtonWithBackground.h"

@implementation ButtonWithBackground

- (void)prepareImageforState:(UIControlState)state
{
    UIImage *i = [self backgroundImageForState:state];
    UIImage *normal = [self backgroundImageForState:UIControlStateNormal];
    
    // if default value - no changes
    if (state != UIControlStateNormal && [i isEqual:normal])
        return;
    
    CGFloat v = roundf(i.size.height / 2);
    CGFloat h;
    if (self.tag > 0)
    {
        h = i.size.width - 1;
    }
    else if (self.tag < 0)
    {
        h = 1;
    }
    else 
    {
        h = roundf(i.size.width / 2);
    }
    UIImage *scaled = [i stretchableImageWithLeftCapWidth:h topCapHeight:v];
    [self setBackgroundImage:scaled forState:state];
}

- (void)prepareButtonImages
{
    [self prepareImageforState:UIControlStateNormal];
    [self prepareImageforState:UIControlStateHighlighted];
    [self prepareImageforState:UIControlStateSelected];
    [self prepareImageforState:UIControlStateDisabled];
}

- (void)awakeFromNib
{
    [self prepareButtonImages];
}

@end
