//  TRRadioPlayer.h
//
// Copyright (c) 2015年 Shinren Pan <shinren.pan@gmail.com>

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

/// 電台狀態改變 Notification.
extern NSString * const TRRaidoStatusChangedNotification;

/// 電台狀態.
typedef NS_ENUM(NSUInteger, TRRaidoStatus){
    /// 初始狀態.
    TRRaidoStatusNormal = 0,
    /// 緩衝中.
    TRRaidoStatusBuffer,
    /// 正在播放.
    TRRaidoStatusPlaying,
    /// 暫停.
    TRRaidoStatusPaused,
    /// 錯誤.
    TRRaidoStatusError
};

/// Radio Player.
@interface TRRadioPlayer : AVPlayer


///-----------------------------------------------------------------------------
/// @name Properties
///-----------------------------------------------------------------------------

/// 目前電台名稱.
@property (nonatomic, copy) NSString *radioTitle;

/// 目前電台 Id.
@property (nonatomic, copy) NSString *radioId;

/// 目前電台狀態.
@property (nonatomic, readonly) TRRaidoStatus radioStatus;

/// 是否正在播放.
@property (nonatomic, readonly) BOOL isPlaying;

/// 電台狀態顏色.
@property (nonatomic, readonly) UIColor *statusColor;


///-----------------------------------------------------------------------------
/// @name Class methods
///-----------------------------------------------------------------------------

/**
 *  返回 singleton 物件.
 *
 *  @return 返回 singleton 物件.
 */
+ (instancetype)singleton;


///-----------------------------------------------------------------------------
/// @name Public methods
///-----------------------------------------------------------------------------

/// 繼續播放.
- (void)resume;

@end
