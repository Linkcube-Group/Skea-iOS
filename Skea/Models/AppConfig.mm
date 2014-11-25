//
//  AppConfig.m
//  BossZP
//
//  Created by mosn on 4/9/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "AppConfig.h"

@implementation AppConfig
+ (NSString *)getSinaAccessToken
{
    NSString *kName = @"SinaKeyToken";
    return [[NSUserDefaults standardUserDefaults] objectForKey:kName];
}

+ (void)setSinaAccessToken:(NSString *)token
{
    NSString *kName =@"SinaKeyToken";
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveGameDetail:(GameDetail *)detail
{
    [[NSUserDefaults standardUserDefaults] setObject:[detail dictionary] forKey:_S(@"game_%@",detail.dateInterval)];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (GameDetail *)getGameDetail:(NSString *)date
{
    NSDictionary *gameStr = [[NSUserDefaults standardUserDefaults] objectForKey:_S(@"game_%@",date)];
    if (gameStr) {
        GameDetail *detail = [[GameDetail alloc] initWithDictionary:gameStr];
        return detail;
    }
    
    return nil;
}

+ (GameDetail *)getLastGameDetail
{
    NSArray *ary = [self getGameRecodeDates];
    if (ary && [ary count]>0) {
        NSString *date = _S(@"%@",[ary lastObject]);
        return [self getGameDetail:date];
    }
    return nil;
}

+ (NSArray *)getGameRecodeDates
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"gameRecordList"];
}
+ (void)setGameRecordDate:(NSString *)timer
{
    NSArray *ary = [[NSUserDefaults standardUserDefaults] objectForKey:@"gameRecordList"];
    if (ary && [ary count]>0) {
        if ([ary containsString:timer]) {
            return;
        }
    }
    
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    if (ary) {
        [temp addObjectsFromArray:ary];
    }
    [temp addObject:timer];
    [[NSUserDefaults standardUserDefaults] setObject:temp forKey:@"gameRecordList"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)getGameLevel
{
    int level = [[[NSUserDefaults standardUserDefaults] objectForKey:@"gameLevel"] intValue];
    if (level<1) {
        level = 1;
    }
    return level;
}
+ (void)setGameLevel:(int)level
{
    [[NSUserDefaults standardUserDefaults] setInteger:level forKey:@"gameLevel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setUserEmail:(NSString *)email
{
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"userEmail"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserEmail
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userEmail"];
}
@end
