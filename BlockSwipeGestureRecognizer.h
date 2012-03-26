//
//  BlockSwipeGestureRecognizer.h
//  iGuides
//
//  Created by Глеб Тарасов on 15.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockSwipeGestureRecognizer : UISwipeGestureRecognizer
    <
    UIGestureRecognizerDelegate
    >

- (id)initWithAction:(BasicBlock)action;

@end
