//
//  StretchableImageView.m
//  AldoCoppola
//
//  Created by Глеб Тарасов on 24.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StretchableImageView.h"
#import "UIImage+P34Utils.h"

@implementation StretchableImageView

- (void)awakeFromNib
{
    self.image = [self.image stretchableImageByWidthAndHeight];
}


@end
