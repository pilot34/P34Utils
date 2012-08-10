//
//  KeyboardListener.m
//  AldoCoppola
//
//  Created by Gleb Tarasov on 27.07.12.
//
//

#import "KeyboardListener.h"

@interface KeyboardListener()

@property(nonatomic) BOOL isKeyboardVisible;

@end

@implementation KeyboardListener

@synthesize isKeyboardVisible = _isKeyboardVisible;

- (id)init
{
    self = [super init];
    if (self)
    {
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(keyboardWillAppear)
                                                   name:UIKeyboardWillShowNotification
                                                 object:nil];
        
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(keyboardWillDisappear)
                                                   name:UIKeyboardWillHideNotification
                                                 object:nil];
    }
    return self;
}

- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)keyboardWillAppear
{
    self.isKeyboardVisible = YES;
}

- (void)keyboardWillDisappear
{
    self.isKeyboardVisible = NO;
}


@end