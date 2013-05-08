//
//  BlockAlertView.h
//  Intuit
//
//  Created by Глеб Тарасов on 23.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P34Utils.h"

typedef void(^BlockAlertStringBlock)(NSString *textValue);

@interface BlockAlertView : UIAlertView

+ (void)showTitle:(NSString *)title
             text:(NSString *)text
     cancelButton:(NSString *)cancelButton
           action:(BasicBlock)action;


+ (void)showTitle:(NSString *)title
             text:(NSString *)text
     cancelButton:(NSString *)cancelButton;

+ (void)showText:(NSString *)text
    cancelButton:(NSString *)cancelButton;


+ (void)showTitle:(NSString *)title
             text:(NSString *)text
     cancelButton:(NSString *)cancelButton
     submitButton:(NSString *)submitButton
           action:(BasicBlock)action;


+ (void)showTitle:(NSString *)title
             text:(NSString *)text
     cancelButton:(NSString *)cancelButton
     submitButton:(NSString *)submitButton
           action:(BasicBlock)action
     cancelAction:(BasicBlock)cancelAction;


+ (void)showTitle:(NSString *)title
             text:(NSString *)text
     cancelButton:(NSString *)cancelButton
     submitButton:(NSString *)submitButton
      placeholder:(NSString *)placeholder
           action:(BlockAlertStringBlock)action
     cancelAction:(BasicBlock)cancelAction;

+ (void)showTitle:(NSString *)title
             text:(NSString *)text
     cancelButton:(NSString *)cancelButton
      firstButton:(NSString *)firstButton
     secondButton:(NSString *)secondButton
      firstAction:(BasicBlock)firstAction
     secondAction:(BasicBlock)secondAction
     cancelAction:(BasicBlock)cancelAction;

@end
