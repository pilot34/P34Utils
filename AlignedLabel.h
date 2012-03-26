//
//  AlignedLabel.h
//  iGuides
//
//  Created by Глеб Тарасов on 17.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;


@interface AlignedLabel : UILabel

@property (nonatomic) VerticalAlignment verticalAlignment;

@end
