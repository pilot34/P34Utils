//
//  LoadingAlertView.m
//  Intuit
//
//  Created by Gleb Tarasov on 13.10.12.
//
//

#import "LoadingAlertView.h"

@implementation LoadingAlertView

+ (LoadingAlertView *)showWithTitle:(NSString *)title
{
    LoadingAlertView *a = [[LoadingAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [a show];
    
    indicator.center = CGPointMake(a.bounds.size.width / 2, a.bounds.size.height - 50);
    [indicator startAnimating];
    [a addSubview:indicator];
    
    return a;
}

- (void)dismiss
{
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

@end
