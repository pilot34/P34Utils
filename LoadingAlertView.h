//
//  LoadingAlertView.h
//  Intuit
//
//  Created by Gleb Tarasov on 13.10.12.
//
//

#import <UIKit/UIKit.h>

@interface LoadingAlertView : UIAlertView

+ (LoadingAlertView *)showWithTitle:(NSString *)title;
- (void)dismiss;

@end
