//
//  Utils.h
//  Intuit
//
//  Created by Глеб Тарасов on 11.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

typedef void(^BasicBlock)(void);
typedef void(^ErrorBlock)(NSError *error);

void doAfter(CGFloat delay, BasicBlock action);

#ifdef UTILS_IMPORT_NIMBUS

#import "NimbusCore.h"
#import "NimbusCore+Additions.h"
#import "Reachability.h"
#import "Reachability+Utils.h"
#import "EGOCache.h"
#import "UILabel+Utils.h"
#import "UITableViewCell+Utils.h"

#endif

#import "UIViewController+Utils.h"
#import "UIView+Utils.h"
#import "UIScrollView+Utils.h"
#import "UIView+Fading.h"
#import "UIWebView+Utils.h"
#import "UITableView+Utils.h"
#import "UIImage+Utils.h"
#import "UIApplication+Utils.h"
#import "UIColor+Utils.h"
#import "NSObject+Utils.h"
#import "NSString+Utils.h"
#import "NSDate+Utils.h"
#import "NSMutableString+Utils.h"
#import "NSMutableArray+Utils.h"
#import "NSArray+Utils.h"
#import "NSSet+Utils.h"
#import "NSFileManager+Utils.h"
#import "StringUtils.h"

#import "BlockAlertView.h"
#import "BlockTapGestureRecognizer.h"
#import "BlockSwipeGestureRecognizer.h"
#import "AlignedLabel.h"
#import "ImageViewWithPattern.h"
#import "VideoPlayingResolver.h"
#import "HiddenTabBarController.h"
#import "StretchableImageView.h"
#import "KeyboardListener.h"

#ifdef UTILS_IMPORT_FILES_DOWNLOADER

#import "DownloadProgress.h"
#import "FilesDownloader.h"
#import "DownloadPortion.h"

#endif

#ifdef UTILS_IMPORT_GOOGLE_ANALYTICS 

#import "Analytics.h"
#import "UIDevice+IdentifierAddition.h"

#endif



#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
