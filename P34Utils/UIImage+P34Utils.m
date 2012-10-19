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

@end
