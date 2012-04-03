//
//  TransparentTableView.m
//  Intuit
//
//  Created by Глеб Тарасов on 06.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TransparentTableView.h"

@implementation TransparentTableView

- (void)awakeFromNib
{
    // в iOS 4 без этого фон черный
    self.backgroundView = nil;
    self.backgroundColor = UIColor.clearColor;
    self.opaque = NO;
}

@end
