//
//  UITableViewCell+Utils.h
//  Intuit
//
//  Created by Глеб Тарасов on 21.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Utils)

+ (CGFloat)heightForText:(NSString *)text withImage:(BOOL)image withAccessory:(UITableViewCellAccessoryType)accessory withFont:(UIFont *)font inTableView:(UITableView *)tableView;

@end
