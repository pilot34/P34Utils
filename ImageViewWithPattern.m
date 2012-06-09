//
//  ImageViewWithPattern.m
//  Intuit
//
//  Created by Глеб Тарасов on 31.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageViewWithPattern.h"

@implementation ImageViewWithPattern

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithPatternImage:self.image];
    self.image = nil;
    [self setNeedsDisplay];
}
@end
