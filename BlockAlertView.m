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
@property(nonatomic, copy) BasicBlock cancelAction;

@end

@implementation BlockAlertView

@synthesize cancelAction = _cancelAction;
@synthesize submitAction = _submitAction;

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle submitButtonTitle:(NSString *)submitButtonTitle
{
    self = [super initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:submitButtonTitle, nil];
    if (self)
    {
        self.delegate = self;
    }
    return self;
}

+ (void)showTitle:(NSString *)title text:(NSString *)text cancelButton:(NSString *)cancelButton action:(BasicBlock)action
{
    BlockAlertView *b = [[BlockAlertView alloc] initWithTitle:title message:text cancelButtonTitle:cancelButton submitButtonTitle:nil];
    b.cancelAction = action;
    [b show];
}


+ (void)showTitle:(NSString *)title text:(NSString *)text cancelButton:(NSString *)cancelButton
{
    [self showTitle:title text:text cancelButton:cancelButton action:nil];
}

+ (void)showTitle:(NSString *)title text:(NSString *)text cancelButton:(NSString *)cancelButton submitButton:(NSString *)submitButton action:(BasicBlock)action
{
    BlockAlertView *b = [[BlockAlertView alloc] initWithTitle:title message:text cancelButtonTitle:cancelButton submitButtonTitle:submitButton];
    b.submitAction = action;
    [b show];
}

+ (void)showTitle:(NSString *)title text:(NSString *)text cancelButton:(NSString *)cancelButton submitButton:(NSString *)submitButton action:(BasicBlock)action cancelAction:(BasicBlock)cancelAction
{
    BlockAlertView *b = [[BlockAlertView alloc] initWithTitle:title message:text cancelButtonTitle:cancelButton submitButtonTitle:submitButton];
    b.submitAction = action;
    b.cancelAction = cancelAction;
    [b show];
}

#pragma mark - UIAlertViewDelegate


// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex > 0 && self.submitAction)
        self.submitAction();
    
    if (buttonIndex == 0 && self.cancelAction)
        self.cancelAction();
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    if (self.cancelAction)
        self.cancelAction();
}


@end
