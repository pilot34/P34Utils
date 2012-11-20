//
//  CustomButton.m
//  Intuit
//
//  Created by Глеб Тарасов on 20.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomButton.h"
#import "P34Utils.h"

@implementation CustomButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.height = self.buttonHeight;
    
    UIImage *bg = [UIImage imageNamed:self.imageName];
    CGFloat vCenter = roundf(bg.size.height / 2);
    UIImage *bgScaled = [bg stretchableImageWithLeftCapWidth:vCenter topCapHeight:0];
    
    UIImage *bgPressed = [UIImage imageNamed:self.pressedImageName];
    UIImage *bgPressedScaled = [bgPressed stretchableImageWithLeftCapWidth:vCenter topCapHeight:0];
    
    [self setBackgroundImage:bgScaled forState:UIControlStateNormal];
    [self setBackgroundImage:bgPressedScaled forState:UIControlStateHighlighted];
    
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:self.textSize]];
    
    [self setTitleColor:self.textColor forState:UIControlStateNormal];
    [self setTitleColor:self.textColor forState:UIControlStateHighlighted];
    [self setTitleColor:self.disabledTextColor forState:UIControlStateDisabled];
}

- (CGFloat)buttonHeight
{
    @throw [NSException exceptionWithName:@"error" reason:@"abstract method" userInfo:nil]; 
}

- (NSInteger)textSize
{
    @throw [NSException exceptionWithName:@"error" reason:@"abstract method" userInfo:nil];   
}

- (NSString *)imageName
{
    @throw [NSException exceptionWithName:@"error" reason:@"abstract method" userInfo:nil];
}

- (NSString *)pressedImageName
{
    @throw [NSException exceptionWithName:@"error" reason:@"abstract method" userInfo:nil];
}

- (UIColor *)textColor
{
    @throw [NSException exceptionWithName:@"error" reason:@"abstract method" userInfo:nil];
}

- (UIColor *)disabledTextColor
{
    @throw [NSException exceptionWithName:@"error" reason:@"abstract method" userInfo:nil];
    
}

@end
