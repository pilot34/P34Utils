//
//  UITableView+Utils.m
//  Intuit
//
//  Created by Глеб Тарасов on 13.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UITableView+Utils.h"
#import "UIView+Utils.h"

@implementation UITableView (Utils)

- (id)cellFromNib:(Class)class
{
    NSString *cellName = NSStringFromClass(class);
    id result = [self dequeueReusableCellWithIdentifier:cellName];
    
    if (result)
        return result;
    else
        return [class fromNib];
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
