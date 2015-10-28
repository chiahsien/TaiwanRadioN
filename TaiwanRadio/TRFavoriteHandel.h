// TRFavoriteHandel.h
// 
// Copyright (c) 2015年 Shinren Pan <shinren.pan@gmail.com>

#import <Foundation/Foundation.h>

/// 電台收藏 Handle.
@interface TRFavoriteHandel : NSObject


///-----------------------------------------------------------------------------
/// @name Class methods
///-----------------------------------------------------------------------------

/**
 *  收藏一個電台.
 *
 *  @param radioId 電台 Id.
 */
+ (void)addRadioIdToFavorites:(NSString *)radioId;

/**
 *  移除一個電台.
 *
 *  @param radioId 電台 Id.
 */
+ (void)removeRadioIdFromFavorites:(NSString *)radioId;

/**
 *  返回電台是否已加入收藏.
 *
 *  @param radioId 電台 Id.
 *
 *  @return 返回電台是否已加入收藏.
 */
+ (BOOL)radioIdInFavorites:(NSString *)radioId;

/**
 *  返回收藏列表.
 *
 *  @return 返回收藏列表.
 */
+ (NSMutableArray *)favorites;

@end
