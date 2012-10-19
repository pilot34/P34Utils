//
//  UIView+Fading.m
//  News360Core
//
//  Created by Глеб Тарасов on 11.11.11.
//  Copyright (c) 2011 News360. All rights reserved.
//

#import "UIView+Fading.h"
#import "UIView+P34Utils.h"
#import <QuartzCore/QuartzCore.h>

#define OPAQUE_COLOR (id)[UIColor colorWithRed:0\
                                         green:0\
                                          blue:0\
                                         alpha:1].CGColor

#define TRANSPARENT_COLOR (id)[UIColor colorWithRed:0\
                                              green:0\
                                               blue:0\
                                              alpha:0].CGColor

@implementation UIView (Fading)

- (CAGradientLayer *)gradientFirstTransparent:(BOOL)firstTransparent vertical:(BOOL)vertical
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    if (vertical)
    {
        gradient.startPoint = CGPointMake(0, 0.5);
        gradient.endPoint = CGPointMake(1, 0.5);        
    }
    else   
    {
        gradient.startPoint = CGPointMake(0.5, 0);
        gradient.endPoint = CGPointMake(0.5, 1);
    }
    
    if (firstTransparent)
    {
        gradient.colors = @[TRANSPARENT_COLOR,
                           OPAQUE_COLOR];
    }
    else
    {
        gradient.colors = @[OPAQUE_COLOR,
                           TRANSPARENT_COLOR];
    }
    
    return gradient;
}

- (CGRect)opaqueFrameForType:(FadingType)type withSize:(CGFloat)size
{
    CGFloat left = 0;
    CGFloat right = self.width;
    CGFloat top = 0;
    CGFloat bottom = self.height;
    
    if ((type & FadingTypeLeft) == FadingTypeLeft)
    {
        left += size;
    }
    
    if ((type & FadingTypeRight) == FadingTypeRight)
    {
        right -= size;
    }
    
    if ((type & FadingTypeTop) == FadingTypeTop)
    {
        top += size;
    }
    
    if ((type & FadingTypeBottom) == FadingTypeBottom)
    {
        bottom -= size;
    }
    
    return CGRectMake(left, top, right - left, bottom - top);
}

- (NSArray *)gradientsForType:(FadingType)type withSize:(CGFloat)size
{
    NSMutableArray *gradients = [NSMutableArray array];
    
    if ((type & FadingTypeLeft) == FadingTypeLeft)
    {
        CAGradientLayer *g = [self gradientFirstTransparent:YES vertical:YES];
        g.frame = CGRectMake(0, 0, size, self.height);
        [gradients addObject:g];
    }
    
    if ((type & FadingTypeRight) == FadingTypeRight)
    {
        CAGradientLayer *g = [self gradientFirstTransparent:NO vertical:YES];
        g.frame = CGRectMake(self.width - size, 0, size, self.height);
        [gradients addObject:g];
    }
    
    if ((type & FadingTypeTop) == FadingTypeTop)
    {
        CAGradientLayer *g = [self gradientFirstTransparent:YES vertical:NO];
        g.frame = CGRectMake(0, 0, self.width, size);
        [gradients addObject:g];
    }
    
    if ((type & FadingTypeBottom) == FadingTypeBottom)
    {
        CAGradientLayer *g = [self gradientFirstTransparent:NO vertical:NO];
        g.frame = CGRectMake(0, self.height - size, self.width, size);
        [gradients addObject:g];
    }
    
    
    return gradients;
}

- (void)setVerticalFadingAt:(CGFloat)fadingLocation direction:(VerticalFadingDirection)direction fadingWidth:(CGFloat)fadingWidth;
{
    NSAssert(fadingLocation >= 0, @"fadingLocation >= 0");
    NSAssert(fadingWidth >= 0, @"fadingWidth >= 0");
    
    if (direction == VerticalFadingDirectionTransparentRight)
    {
        NSAssert(fadingLocation >= fadingWidth, @"fadingLocation >= fadingWidth");
        NSAssert(fadingLocation <= self.width, @"fadingLocation <= self.width");
    }
    else if (direction == VerticalFadingDirectionTransparentLeft)
    {
        NSAssert(fadingLocation + fadingWidth <= self.width, @"fadingLocation + fadingWidth <= self.width");
    }
    
    CALayer *mask = [CALayer layer];
    mask.frame = self.layer.bounds;
    CAGradientLayer *gradient;
    CALayer *opaqueLayer = [CALayer layer];
    opaqueLayer.backgroundColor = (__bridge CGColorRef)OPAQUE_COLOR;
    
    if (direction == VerticalFadingDirectionTransparentLeft)
    {
        gradient = [self gradientFirstTransparent:YES vertical:YES];
        gradient.frame = CGRectMake(fadingLocation, 0, fadingWidth, self.height);
        opaqueLayer.frame = CGRectMake(fadingLocation + fadingWidth, 0, self.width - fadingLocation - fadingWidth, self.height);
        
    }
    else if (direction == VerticalFadingDirectionTransparentRight)
    {
        gradient = [self gradientFirstTransparent:NO vertical:YES];
        gradient.frame = CGRectMake(fadingLocation - fadingWidth, 0, fadingWidth, self.height);
        opaqueLayer.frame = CGRectMake(0, 0, fadingLocation - fadingWidth, self.height);
    }
    else
    {
        @throw [NSException exceptionWithName:@"error" reason:@"wrong type" userInfo:nil];
    }

    
    [mask addSublayer:gradient];
    [mask addSublayer:opaqueLayer];
    self.layer.mask = mask;
}

- (void)removeFading
{
    if (self.layer.mask != nil)
        self.layer.mask = nil;
}

- (void)addFading:(FadingType)fadingType withSize:(CGFloat)size
{
    NSArray *gradients = [self gradientsForType:fadingType withSize:size];
    
    CALayer *mask = [CALayer layer];
    mask.frame = self.layer.bounds;
    CALayer *opaqueLayer = [CALayer layer];
    opaqueLayer.backgroundColor = (__bridge CGColorRef)OPAQUE_COLOR;
    opaqueLayer.frame = [self opaqueFrameForType:fadingType withSize:size];
    
    for (CAGradientLayer *l in gradients) 
    {
        [mask addSublayer:l];
    }
    [mask addSublayer:opaqueLayer];
    self.layer.mask = mask;
}

-(void)updateFading:(FadingType)fadingType withSize:(CGFloat)size
{
    CALayer* mask = self.layer.mask;
    mask.frame = self.bounds;
    
    for (CAGradientLayer *l in mask.sublayers) 
    {
        if( [l isKindOfClass:[CAGradientLayer class]] )
        {
            if( l.frame.origin.y == 0 && l.frame.size.height == size ) //FadingTypeTop
                l.frame = CGRectMake(0, 0, self.width, size);
            
            else if( l.frame.origin.y != 0 && l.frame.size.height == size ) //FadingTypeBottom
                l.frame = CGRectMake(0, self.height - size, self.width, size);
            
            else if( l.frame.origin.x == 0 && l.frame.size.width == size ) //FadingTypeLeft
                l.frame = CGRectMake(0, 0, size, self.height);
            
            else if( l.frame.origin.x != 0 && l.frame.size.width == size ) //FadingTypeRight
                l.frame = CGRectMake(self.width - size, 0, size, self.height);
            
        }else
        {
            l.frame = [self opaqueFrameForType:fadingType withSize:size];
        }
    }
    
    //self.layer.mask = mask;
}

@end
