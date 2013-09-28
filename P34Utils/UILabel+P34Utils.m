//
//  UILabel+Utils.m
//  Intuit
//
//  Created by Глеб Тарасов on 16.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UILabel+P34Utils.h"
#import "P34Utils.h"

@implementation UILabel (Utils)

- (void)heightToFit
{
    self.height = [self.attributedText boundingRectWithSize:CGSizeMake(self.width,
                                                                       CGFLOAT_MAX)
                                                    options:NSStringDrawingUsesFontLeading
                                                    context:nil].size.height;
    
    if (self.numberOfLines > 0)
    {
        NSMutableString *str = [@"a" mutableCopy];
        for (int i = 1; i < self.numberOfLines; ++i)
            [str appendString:@"\na"];
        
        CGFloat maxHeight = [str heightWithFont:self.font
                             constrainedToWidth:self.width
                                  lineBreakMode:self.lineBreakMode];
        
        if (self.height > maxHeight)
            self.height = maxHeight;
    }
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
