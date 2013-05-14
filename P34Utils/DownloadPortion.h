//
//  DownloadPortion.h
//  abookclub
//
//  Created by Глеб Тарасов on 27.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadPortion : NSObject

@property(strong, nonatomic, readonly) NSString *title;
@property(strong, nonatomic, readonly) NSArray *files;
@property (strong, nonatomic, readonly) NSString *destinationFolder;

- (id)initWithSingleUrl:(NSString *)url destination:(NSString *)folder;
- (id)initWithSingleUrl:(NSString *)url title:(NSString *)title destination:(NSString *)folder;
- (id)initWithTitle:(NSString *)title files:(NSArray *)files destination:(NSString *)folder;

@end
