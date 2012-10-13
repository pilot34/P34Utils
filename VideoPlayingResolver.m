//
//  VideoPlayingResolver.m
//  News360iPhone
//
//  Created by Глеб Тарасов on 13.10.11.
//  Copyright (c) 2011 News360. All rights reserved.
//

#import "VideoPlayingResolver.h"

@interface VideoPlayingResolver()

@property(nonatomic, assign) BOOL isPlaying;
@property(nonatomic, assign) BOOL wasRotation;
@property(nonatomic, assign) BOOL listenOrientationOnInit;

@end

@implementation VideoPlayingResolver

- (void)subscribeToNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                           selector:@selector(movieDidEnterFullScreen) 
                                               name:UIMoviePlayerControllerDidEnterFullcreenNotification
                                             object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                           selector:@selector(movieDidExitFullScreen)
                                               name:UIMoviePlayerControllerDidExitFullcreenNotification
                                             object:nil];
    
    // чтобы работало во всех версиях - добавляем и те и те нотификации
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                           selector:@selector(movieDidEnterFullScreen) 
                                               name:UIMoviePlayerControllerDidEnterFullscreenNotification
                                             object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                           selector:@selector(movieDidExitFullScreen)
                                               name:UIMoviePlayerControllerDidExitFullscreenNotification
                                             object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(didRotate) 
                                                 name:UIDeviceOrientationDidChangeNotification 
                                               object:nil];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.listenOrientationOnInit = [UIDevice.currentDevice isGeneratingDeviceOrientationNotifications];
        [UIDevice.currentDevice beginGeneratingDeviceOrientationNotifications];
        
        [self subscribeToNotifications];
    }
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (!self.listenOrientationOnInit)
        [UIDevice.currentDevice endGeneratingDeviceOrientationNotifications];
}

#pragma mark - Notifications

- (void)movieDidEnterFullScreen
{
    self.isPlaying = YES;
    self.wasRotation = NO;
    
    if ([self.delegate respondsToSelector:@selector(videoPlayingResolverDidStartPlaying)])
        [self.delegate videoPlayingResolverDidStartPlaying];
}

- (void)movieDidExitFullScreen
{
    self.isPlaying = NO;
    
    if ([self.delegate respondsToSelector:@selector(videoPlayingResolverDidFinishPlaying:)])
        [self.delegate videoPlayingResolverDidFinishPlaying:self.wasRotation];
}

- (void)didRotate
{
    self.wasRotation = YES;
}

@end
