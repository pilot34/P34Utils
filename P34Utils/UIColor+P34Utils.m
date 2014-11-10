//
//  UIColor+Utils.m
//  AldoCoppola
//
//  Created by Глеб Тарасов on 06.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIColor+P34Utils.h"

@implementation UIColor (Utils)

+ (UIColor *)colorWithRGBHex:(UInt32)hex 
{
	int r = (hex >> 16) & 0xFF;
	int g = (hex >> 8) & 0xFF;
	int b = (hex) & 0xFF;
	
	return [UIColor colorWithRed:r / 255.0f
						   green:g / 255.0f
							blue:b / 255.0f
						   alpha:1.0f];
}

- (NSUInteger)RGBHex
{
    CGFloat red, green, blue, alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    NSInteger ired, igreen, iblue;
    ired = roundf(red * 255);
    igreen = roundf(green * 255);
    iblue = roundf(blue * 255);
    NSUInteger result = (ired << 16) | (igreen << 8) | iblue;
    NSLog(@"hex %lX", (unsigned long)result);
    return result;
}

@end
