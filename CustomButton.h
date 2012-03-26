//
//  CustomButton.h
//  Intuit
//
//  Created by Глеб Тарасов on 20.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton

- (CGFloat)buttonHeight;
- (NSInteger)textSize;
- (NSString *)imageName;
- (NSString *)pressedImageName;
- (UIColor *)textColor;
- (UIColor *)disabledTextColor;

@end
