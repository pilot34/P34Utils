//
//  UITableViewCell+Utils.m
//  Intuit
//
//  Created by Глеб Тарасов on 21.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UITableViewCell+P34Utils.h"
#import "NSString+P34Utils.h"

@implementation UITableViewCell (Utils)

+ (CGFloat)heightForText:(NSString *)text 
               withImage:(BOOL)image 
         withDetailLabel:(BOOL)detailLabel
           withAccessory:(UITableViewCellAccessoryType)accessoryType
                withFont:(UIFont *)font 
             inTableView:(UITableView *)tableView

{
    CGFloat contentWidth = tableView.frame.size.width;
    
	// reduce width for accessories
	switch (accessoryType) 
	{
		case UITableViewCellAccessoryDisclosureIndicator:
		case UITableViewCellAccessoryCheckmark:
			contentWidth -= 20.0f;
			break;
		case UITableViewCellAccessoryDetailDisclosureButton:
			contentWidth -= 33.0f;
			break;
		case UITableViewCellAccessoryNone:
			break;
        default:
            break;
	}
	
	// reduce width for grouped table views
	if (tableView.style == UITableViewStyleGrouped)
	{
		contentWidth -= 19.0f;
	}
    
    // image width
    if (image)
        contentWidth -= 40.0f;
    
    // закладываемся максимум на 2 буквы в detailLabel
    if (detailLabel)
        contentWidth -= 36.0f;

	
	return [text heightWithFont:font
             constrainedToWidth:contentWidth] + 20.f;
}

- (UITableViewCell *)previousCell
{
    UITableView *tableView = (UITableView *)self.superview;
    NSInteger index = [tableView.visibleCells indexOfObject:self];
    if (index > 0 && index != NSNotFound)
    {
        return (tableView.visibleCells)[index - 1];
    }
    else 
    {
        return nil;
    }
}

@end
