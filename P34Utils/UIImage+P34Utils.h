//
//  UIImage+P34Utils.h
//  iGuides
//
//  Created by Глеб Тарасов on 22.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

+ (UIImage *)onePixelImageWithColor:(UIColor *)color;

- (UIImage *)stretchableImageByWidth;
- (UIImage *)stretchableImageByWidthAndHeight;
- (UIImage *)scaleForDimension:(CGFloat)min;

@end
