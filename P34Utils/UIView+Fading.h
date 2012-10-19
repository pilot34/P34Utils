//
//  UIView+Fading.h
//  News360Core
//
//  Created by Глеб Тарасов on 11.11.11.
//  Copyright (c) 2011 News360. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    // Слева прозрачно
    VerticalFadingDirectionTransparentLeft,
    // Справа прозрачно
    VerticalFadingDirectionTransparentRight
} VerticalFadingDirection;

typedef enum
{
    FadingTypeTop = 1,
    FadingTypeBottom = 2,
    FadingTypeLeft = 4,
    FadingTypeRight = 8
    
} FadingType;

@interface UIView (Fading)


// Добавляет затухающую прозрачность. 
// fadingLocation - координата края градиента, с которого alpha = 0.
// direction - в какую сторону градиент.
// fadingWidth - ширина самого градиента (когда alpha изменяется от 0 до 1).
- (void)setVerticalFadingAt:(CGFloat)fadingLocation direction:(VerticalFadingDirection)direction fadingWidth:(CGFloat)fadingWidth;

// Добавляет затухающую прозрачность по бокам view.
// Перечисление флаговое, можно задавать несколько.
- (void)addFading:(FadingType)fadingType withSize:(CGFloat)size;

- (void)removeFading;

- (void)updateFading:(FadingType)fadingType withSize:(CGFloat)size;

@end
