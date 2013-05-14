//
//  DownloadPortion.m
//  abookclub
//
//  Created by Глеб Тарасов on 27.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DownloadPortion.h"

@interface DownloadPortion()


@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *files;
@property (strong, nonatomic) NSString *destinationFolder;

@end

@implementation DownloadPortion : NSObject

- (id)initWithSingleUrl:(NSString *)url title:(NSString *)title destination:(NSString *)folder
{
    return [self initWithTitle:title files:@[url] destination:folder];
}

- (id)initWithSingleUrl:(NSString *)url destination:(NSString *)folder
{
    return [self initWithSingleUrl:url title:url destination:folder];
}

- (id)initWithTitle:(NSString *)title files:(NSArray *)files destination:(NSString *)folder
{
    self = [super init];
    if (self)
    {
        self.title = title;
        self.files = files;
        self.destinationFolder = folder;
    }
    return self;
}

- (NSString *)description
{
    return self.title;
}

@end

