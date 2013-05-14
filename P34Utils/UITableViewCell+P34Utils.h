//
//  UITableViewCell+P34Utils.h
//  Intuit
//
//  Created by Глеб Тарасов on 21.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Utils)

+ (CGFloat)heightForText:(NSString *)text 
               withImage:(BOOL)image 
         withDetailLabel:(BOOL)detailLabel
           withAccessory:(UITableViewCellAccessoryType)accessoryType
                withFont:(UIFont *)font 
             inTableView:(UITableView *)tableView;

- (UITableViewCell *)previousCell;

@end
