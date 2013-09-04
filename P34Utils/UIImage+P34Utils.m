//
//  UIImage+Utils.m
//  iGuides
//
//  Created by Глеб Тарасов on 22.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIImage+P34Utils.h"
#import "UIImage+Resize.h"

@implementation UIImage (Utils)

- (UIImage *)stretchableImageByWidth
{
    return [self stretchableImageWithLeftCapWidth:roundf(self.size.width / 2) topCapHeight:0];
}

- (UIImage *)stretchableImageByWidthAndHeight
{
    return [self stretchableImageWithLeftCapWidth:roundf(self.size.width / 2) topCapHeight:roundf(self.size.height / 2)];
}

- (UIImage *)scaleForDimension:(CGFloat)min
{
    CGFloat minSide = MIN(self.size.width, self.size.height);
    CGFloat scale = min / minSide;
    CGSize newSize = CGSizeMake((int)(self.size.width * scale), 
                                (int)(self.size.height * scale));
    
    return [self resizedImage:newSize interpolationQuality:kCGInterpolationDefault];
}

+ (UIImage *)onePixelImageWithColor:(UIColor *)color
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *data = malloc(sizeof(unsigned char) * 4);
    
    CGFloat red, green, blue, alpha;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    data[0] = (unsigned char)(255 * alpha);
    data[1] = (unsigned char)(255 * red);
    data[2] = (unsigned char)(255 * green);
    data[3] = (unsigned char)(255 * blue);
    CGContextRef context = CGBitmapContextCreate(data, 1, 1, 8, 4, colorSpace,
                                                 kCGImageAlphaPremultipliedFirst);
    
    free(data);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRef ref = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    UIImage *image = [UIImage imageWithCGImage:ref];
    CFRelease(ref);
    
    return image;
}

@end
