//
//  BlockTapGestureRecognizer.h
//  iGuides
//
//  Created by Глеб Тарасов on 16.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P34Utils.h"

@interface BlockTapGestureRecognizer : UITapGestureRecognizer
    <
    UIGestureRecognizerDelegate
    >

- (id)initWithAction:(BasicBlock)action;

@end
