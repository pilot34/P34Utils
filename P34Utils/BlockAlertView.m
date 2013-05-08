//
//  BlockAlertView.m
//  Intuit
//
//  Created by Глеб Тарасов on 23.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BlockAlertView.h"

@interface BlockAlertView()

@property(nonatomic, copy) BasicBlock submitAction;
@property(copy, nonatomic) BasicBlock secondAction;
@property(nonatomic, copy) BasicBlock cancelAction;
@property(copy, nonatomic) BlockAlertStringBlock submitStringAction;

@end

@implementation BlockAlertView

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  submitButtonTitle:(NSString *)submitButtonTitle
{
    return [super initWithTitle:title
                        message:message
                       delegate:self
              cancelButtonTitle:cancelButtonTitle
              otherButtonTitles:submitButtonTitle, nil];
}

+ (void)showTitle:(NSString *)title
             text:(NSString *)text
     cancelButton:(NSString *)cancelButton
           action:(BasicBlock)action
{
    BlockAlertView *b = [[BlockAlertView alloc] initWithTitle:title message:text cancelButtonTitle:cancelButton submitButtonTitle:nil];
    b.cancelAction = action;
    [b show];
}

+ (void)showText:(NSString *)text
    cancelButton:(NSString *)cancelButton
{
    [self showTitle:nil text:text cancelButton:cancelButton action:nil];
}


+ (void)showTitle:(NSString *)title
             text:(NSString *)text
     cancelButton:(NSString *)cancelButton
{
    [self showTitle:title text:text cancelButton:cancelButton action:nil];
}

+ (void)showTitle:(NSString *)title
             text:(NSString *)text
     cancelButton:(NSString *)cancelButton
     submitButton:(NSString *)submitButton
           action:(BasicBlock)action
{
    BlockAlertView *b = [[BlockAlertView alloc] initWithTitle:title message:text cancelButtonTitle:cancelButton submitButtonTitle:submitButton];
    b.submitAction = action;
    [b show];
}

+ (void)showTitle:(NSString *)title
             text:(NSString *)text
     cancelButton:(NSString *)cancelButton
     submitButton:(NSString *)submitButton
           action:(BasicBlock)action
     cancelAction:(BasicBlock)cancelAction
{
    BlockAlertView *b = [[BlockAlertView alloc] initWithTitle:title message:text cancelButtonTitle:cancelButton submitButtonTitle:submitButton];
    b.submitAction = action;
    b.cancelAction = cancelAction;
    [b show];
}

+ (void)showTitle:(NSString *)title
             text:(NSString *)text
     cancelButton:(NSString *)cancelButton
     submitButton:(NSString *)submitButton
      placeholder:(NSString *)placeholder
           action:(BlockAlertStringBlock)action
     cancelAction:(BasicBlock)cancelAction
{
 
    BlockAlertView *b = [[BlockAlertView alloc] initWithTitle:title message:text cancelButtonTitle:cancelButton submitButtonTitle:submitButton];
    b.alertViewStyle = UIAlertViewStylePlainTextInput;
    b.submitStringAction = action;
    b.cancelAction = cancelAction;
    UITextField *field = [b textFieldAtIndex:0];
    field.placeholder = placeholder;
    [b show];
}

+ (void)showTitle:(NSString *)title
             text:(NSString *)text
     cancelButton:(NSString *)cancelButton
      firstButton:(NSString *)firstButton
     secondButton:(NSString *)secondButton
      firstAction:(BasicBlock)firstAction
     secondAction:(BasicBlock)secondAction
     cancelAction:(BasicBlock)cancelAction
{
    BlockAlertView *b = [[BlockAlertView alloc] initWithTitle:title message:text delegate:nil cancelButtonTitle:cancelButton otherButtonTitles:firstButton, secondButton, nil];
    b.delegate = b;
    b.submitAction = firstAction;
    b.secondAction = secondAction;
    b.cancelAction = cancelAction;
    [b show];
}

#pragma mark - UIAlertViewDelegate


// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 && self.submitAction)
        self.submitAction();
    
    if (buttonIndex == 2 && self.secondAction)
        self.secondAction();
    
    if (buttonIndex == 1 && self.submitStringAction)
    {
        UITextField *field = [alertView textFieldAtIndex:0];
        self.submitStringAction(field.text);
    }
    
    if (buttonIndex == 0 && self.cancelAction)
        self.cancelAction();
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    if (self.cancelAction)
        self.cancelAction();
}


@end
