// TRFavoriteHandel.m
//
// Copyright (c) 2015年 Shinren Pan <shinren.pan@gmail.com>

#import "TRFavoriteHandel.h"


@implementation TRFavoriteHandel

#pragma mark - Class methods
+ (void)addRadioIdToFavorites:(NSString *)radioId
{
    NSMutableArray *favorite = [self favorites];
    
    if([favorite containsObject:radioId])
    {
        return;
    }
    
    [favorite addObject:radioId];
    [[NSUserDefaults standardUserDefaults]setObject:favorite forKey:@"favorite"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (void)removeRadioIdFromFavorites:(NSString *)radioId
{
    NSMutableArray *favorite = [self favorites];
    
    if(![favorite containsObject:radioId])
    {
        return;
    }
    
    [favorite removeObject:radioId];
    [[NSUserDefaults standardUserDefaults]setObject:favorite forKey:@"favorite"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (BOOL)radioIdInFavorites:(NSString *)radioId
{
    return [[self favorites]containsObject:radioId];
}

+ (NSMutableArray *)favorites
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *temp               = [userDefault objectForKey:@"favorite"];
    NSMutableArray *favorite    = [NSMutableArray arrayWithArray:temp];
    
    if(!favorite)
    {
        favorite = [NSMutableArray array];
    }
    
    return favorite;
}

@end
