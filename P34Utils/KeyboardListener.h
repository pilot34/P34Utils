//
//  KeyboardListener.h
//  AldoCoppola
//
//  Created by Gleb Tarasov on 27.07.12.
//
//

#import <Foundation/Foundation.h>

@protocol KeyboardListenerDelegate <NSObject>

- (void)keyboardListenerStatusChanged;

@end


// Следит, видна клавиатура или нет. Надо создавать только когда клавиатуры нет.
@interface KeyboardListener : NSObject

@property(unsafe_unretained, nonatomic) id<KeyboardListenerDelegate> delegate;
@property(nonatomic, readonly) BOOL isKeyboardVisible;

@end
