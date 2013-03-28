//
//  UILabel+Utils.m
//  Intuit
//
//  Created by Глеб Тарасов on 16.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UILabel+P34Utils.h"
#import "NSString+NimbusCore.h"
#import "P34Utils.h"

@implementation UILabel (Utils)

- (void)heightToFit
{
    self.height = [self.text heightWithFont:self.font 
                         constrainedToWidth:self.width 
                              lineBreakMode:self.lineBreakMode];
}

- (void)adjustFontSizeToFit
{
    CGFloat fsize = self.font.pointSize;
    float height = [self.text sizeWithFont:[self.font fontWithSize:fsize]
                    constrainedToSize:CGSizeMake(self.width, MAXFLOAT)
                        lineBreakMode:UILineBreakModeWordWrap].height;
    
    while (height > self.height && fsize > 1)
    {
        fsize -= 1;
        height = [self.text sizeWithFont:[self.font fontWithSize:fsize]
                  constrainedToSize:CGSizeMake(self.width,MAXFLOAT)
                      lineBreakMode:UILineBreakModeWordWrap].height;
    };
    
    if (fsize < self.font.pointSize)
        self.font = [self.font fontWithSize:fsize];
}


- (void)adjustFontSizeToFitWithoutWordBreaks
{
    [self adjustFontSizeToFit];
    
    CGFloat fsize = self.font.pointSize;
    for (NSString *word in [[self.text stringByReplacingOccurrencesOfString:@"\n"
                                                                 withString:@" "] componentsSeparatedByString:@" "])
    {
        float width = [word sizeWithFont:[self.font fontWithSize:fsize]].width;
        while (width > self.width && fsize > 1)
        {
            fsize -= 1;
            width = [word sizeWithFont:[self.font fontWithSize:fsize]].width;
        }
    }
    
    if (fsize < self.font.pointSize)
        self.font = [self.font fontWithSize:fsize];
}

@end
