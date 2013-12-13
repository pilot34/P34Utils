//
//  UITableView+P34Utils.h
//  Intuit
//
//  Created by Глеб Тарасов on 13.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Utils)

- (id)cellFromStoryboard:(Class)class;
- (id)cellFromNib:(Class)class;
- (id)cellFromNib:(UINib *)nib class:(Class)class;
- (void)heightToFit;
- (void)clearBackground;

@end
