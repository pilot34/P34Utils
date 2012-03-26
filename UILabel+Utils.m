//
//  UILabel+Utils.m
//  Intuit
//
//  Created by Глеб Тарасов on 16.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UILabel+Utils.h"

@implementation UILabel (Utils)

- (void)heightToFit
{
    self.height = [self.text heightWithFont:self.font 
                         constrainedToWidth:self.width 
                              lineBreakMode:self.lineBreakMode];
}

@end
