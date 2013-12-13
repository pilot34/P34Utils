//
//  UITableView+Utils.m
//  Intuit
//
//  Created by Глеб Тарасов on 13.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UITableView+P34Utils.h"
#import "UIView+P34Utils.h"

@implementation UITableView (Utils)

- (id)cellFromStoryboard:(Class)class
{
    NSString *cellName = NSStringFromClass(class);
    return [self dequeueReusableCellWithIdentifier:cellName];
}

- (id)cellFromNib:(Class)class
{
    NSString *cellName = NSStringFromClass(class);
    id result = [self dequeueReusableCellWithIdentifier:cellName];
    
    if (result)
        return result;
    else
        return [class fromNib];
}

- (id)cellFromNib:(UINib *)nib class:(Class)class
{
    NSString *cellName = NSStringFromClass(class);
    id result = [self dequeueReusableCellWithIdentifier:cellName];
    
    if (result)
        return result;
    else
        return [[nib instantiateWithOwner:nil options:nil] firstObject];
}

- (void)heightToFit
{
    self.height = self.contentSize.height;
}

- (void)clearBackground
{
    // to clear background in iOS4
    self.backgroundView = nil;
    self.opaque = NO;
    self.backgroundColor = UIColor.clearColor;
}

@end
