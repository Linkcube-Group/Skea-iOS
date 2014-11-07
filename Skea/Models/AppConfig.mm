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
    [[NSUserDefaults standardUserDefaults] setObject:[detail JSONString] forKey:_S(@"game_%@",detail.date)];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (GameDetail *)getGameDetail:(NSString *)date
{
    NSString *gameStr = [[NSUserDefaults standardUserDefaults] objectForKey:_S(@"game_%@",date)];
    if (gameStr) {
        GameDetail *detail = [[GameDetail alloc] initWithJson:gameStr];
        return detail;
    }
    
    return nil;
}

+ (NSArray *)getGameRecodeDates
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"gameRecordList"];
}
+ (void)setGameRecordDate:(double)timer
{
    NSArray *ary = [[NSUserDefaults standardUserDefaults] objectForKey:@"gameRecordList"];
    if (ary && [ary count]>0) {
        if (fabs([[ary lastObject] doubleValue]-timer/(24*60*60))<1) {
            return;
        }
    }
    NSMutableArray *temp = [NSMutableArray arrayWithArray:ary];
    [temp addObject:[NSNumber numberWithInt:timer/(24*60*60)]];
    [[NSUserDefaults standardUserDefaults] setObject:temp forKey:@"gameRecordList"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
