//
//  VideoPlayingResolver.h
//  News360iPhone
//
//  Created by Глеб Тарасов on 13.10.11.
//  Copyright (c) 2011 News360. All rights reserved.
//

// У Эппла была опечатка до 4.3
#define UIMoviePlayerControllerDidEnterFullcreenNotification @"UIMoviePlayerControllerDidEnterFullcreenNotification"
#define UIMoviePlayerControllerDidExitFullcreenNotification @"UIMoviePlayerControllerDidExitFullcreenNotification"
#define UIMoviePlayerControllerDidEnterFullscreenNotification @"UIMoviePlayerControllerDidEnterFullscreenNotification"
#define UIMoviePlayerControllerDidExitFullscreenNotification @"UIMoviePlayerControllerDidExitFullscreenNotification"

@protocol VideoPlayingResolverDelegate <NSObject>

@optional
- (void)videoPlayingResolverDidStartPlaying;
- (void)videoPlayingResolverDidFinishPlaying:(BOOL)wasRotation;

@end

@interface VideoPlayingResolver : NSObject

@property(nonatomic, readonly) BOOL isPlaying;
@property(nonatomic, unsafe_unretained) id<VideoPlayingResolverDelegate> delegate;

@end