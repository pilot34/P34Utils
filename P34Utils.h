//
//  Utils.h
//  Intuit
//
//  Created by Глеб Тарасов on 11.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

typedef void(^BasicBlock)(void);
typedef void(^IdBlock)(id obj);
typedef void(^ObjectBlock)(NSObject *obj);
typedef void(^StringBlock)(NSString *str);
typedef void(^NumberBlock)(NSNumber *num);
typedef void(^ArrayBlock)(NSArray *arr);
typedef void(^DictionaryBlock)(NSDictionary *dict);
typedef void(^SetBlock)(NSSet *set);
typedef void(^IntegerBlock)(NSInteger num);
typedef void(^BoolBlock)(BOOL val);
typedef void(^ErrorBlock)(NSError *error);

void doAfter(CGFloat delay, BasicBlock action);
BOOL isIphone5OrLarger();
BOOL isIphone5();
BOOL isIphone6();
BOOL isIphone6Plus();
BOOL isIpad();
BOOL isRetina();

#if DEBUG_LOG
#   define log(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define log(...)
#endif


#define APP_VERSION (NSBundle.mainBundle.infoDictionary)[@"CFBundleVersion"]


#import "Reachability.h"
#import "Reachability+P34Utils.h"
#import "UILabel+P34Utils.h"
#import "UITableViewCell+P34Utils.h"


#import "UIViewController+P34Utils.h"
#import "UIView+P34Utils.h"
#import "UIScrollView+P34Utils.h"
#import "UIView+Fading.h"
#import "UIWebView+P34Utils.h"
#import "UITableView+P34Utils.h"
#import "UIImage+P34Utils.h"
#import "UIApplication+P34Utils.h"
#import "UIColor+P34Utils.h"
#import "NSObject+P34Utils.h"
#import "NSString+P34Utils.h"
#import "NSDate+P34Utils.h"
#import "NSMutableString+P34Utils.h"
#import "NSMutableArray+P34Utils.h"
#import "NSArray+P34Utils.h"
#import "NSSet+P34Utils.h"
#import "NSManagedObject+P34Utils.h"
#import "NSFileManager+P34Utils.h"
#import "NSAttributedString+P34Utils.h"
#import "NSMutableAttributedString+P34Utils.h"
#import "StringUtils.h"

#import "BlockButton.h"
#import "BlockAlertView.h"
#import "BlockTapGestureRecognizer.h"
#import "BlockSwipeGestureRecognizer.h"
#import "AlignedLabel.h"
#import "ImageViewWithPattern.h"
#import "VideoPlayingResolver.h"
#import "HiddenTabBarController.h"
#import "StretchableImageView.h"
#import "KeyboardListener.h"
#import "LoadingAlertView.h"


#define UIViewAutoresizingAll UIViewAutoresizingFlexibleLeftMargin \
                                | UIViewAutoresizingFlexibleWidth\
                                | UIViewAutoresizingFlexibleRightMargin\
                                | UIViewAutoresizingFlexibleTopMargin\
                                | UIViewAutoresizingFlexibleHeight\
                                | UIViewAutoresizingFlexibleBottomMargin


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define WSELF           __weak typeof(self) wself = self
#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
