// AppDelegate.m
//
// Copyright (c) 2015年 Shinren Pan <shinren.pan@gmail.com>

#import "AppDelegate.h"
#import "TRRadioPlayer.h"

#import <MediaPlayer/MediaPlayer.h>


@implementation AppDelegate

#pragma mark - LifeCycle
- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self __setupRemoteControl];
    [self __setupUIAppearance];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = nil;
}

#pragma mark - Private
- (void)__setupRemoteControl
{
    // 設置 Remote Control
    
    MPRemoteCommandCenter *center = [MPRemoteCommandCenter sharedCommandCenter];
    
    // 耳機線控 play / pause
    [center.togglePlayPauseCommand addTargetWithHandler:
     ^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent *event) {
         if([TRRadioPlayer singleton].isPlaying)
         {
             [[TRRadioPlayer singleton]pause];
         }
         else
         {
             [[TRRadioPlayer singleton]resume];
         }
        
         return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    // 控制面板 play
    [center.playCommand addTargetWithHandler:^(MPRemoteCommandEvent *event) {
        [[TRRadioPlayer singleton]resume];
        
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    // 控制面板 pause
    [center.pauseCommand addTargetWithHandler:^(MPRemoteCommandEvent *event) {
        [[TRRadioPlayer singleton]pause];
        
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    // 控制面板 stop
    [center.stopCommand addTargetWithHandler:^(MPRemoteCommandEvent *event) {
        [[TRRadioPlayer singleton]pause];
        
        return MPRemoteCommandHandlerStatusSuccess;
    }];
}

- (void)__setupUIAppearance
{
    // 設置 UIAppearance
    
    [[UITabBar appearance]setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
}

@end
