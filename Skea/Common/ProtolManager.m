//
//  ProtolManager.m
//  BossZP
//
//  Created by mosn on 4/28/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "ProtolManager.h"


@interface ProtolManager()

@end


@implementation ProtolManager

+ (ProtolManager *)shareProtolManager
{
    static ProtolManager * singleClient;
    static dispatch_once_t pred;
    dispatch_once(&pred,^{
        singleClient=[[self alloc] initManager];
    } );
    return singleClient;
}


- (id)initManager
{
    if (self=[super init]) {
        
    }
    return self;
}


- (void)sendGameData:(GameDetail *)gameDetail
{
    if (gameDetail==nil) {
        return;
    }
    NSString *email = [AppConfig getUserEmail];
    if (StringIsNullOrEmpty(email)) {
        return;
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:email forKey:@"email"];
    NSDate *day = [NSDate dateWithTimeIntervalSince1970:[gameDetail.dateInterval intValue]*(24*60*60)];
    NSString *dayStr = gameDetail.dateInterval;// [day stringDateWithFormat:@"yyyy-MM-dd"];
    [dict setObject:dayStr forKey:@"date"];
    
    [dict setObject:_S(@"%d",gameDetail.heighScore) forKey:@"heighScore"];
    [dict setObject:_S(@"%d",gameDetail.factScore) forKey:@"factScore"];
    [dict setObject:_S(@"%d",gameDetail.exerciseTime) forKey:@"exerciseTime"];
    
    int level = [AppConfig getGameLevel];
    [dict setObject:_S(@"%d",level) forKey:@"level"];
    
    [dict setObject:_S(@"%.2f",[gameDetail getExplosiveScore]) forKey:@"explosive"];
    [dict setObject:_S(@"%.2f",[gameDetail getEnduranceScore]) forKey:@"endurance"];
    
    
    __block NSMutableArray *exercisAry = [[NSMutableArray alloc] init];
    __block NSMutableArray *scoreAry = [[NSMutableArray alloc] init];
    [gameDetail.aryGameInfo.array enumerateObjectsUsingBlock:^(GameInfo *obj, NSUInteger idx, BOOL *stop) {
        if (obj.halfScroes) {
            NSDictionary *dict1 = @{@"progessTime":_S(@"%d",obj.progressTime),@"halfScores":obj.halfScroes.array};
            NSDictionary *dict2 = @{@"progessTime":_S(@"%d",obj.progressTime),@"scoreRate":_S(@"%.2f",obj.scoreRate)};
            
            [exercisAry addObject:dict1];
            [scoreAry addObject:dict2];
        }
        
    }];
    
    NSString *exerciseData = [exercisAry JSONString];
    NSString *scoreData = [scoreAry JSONString];
    [dict setObject:exerciseData forKey:@"exerciseData"];
    [dict setObject:scoreData forKey:@"scoreData"];
    
    [[BaseEngine sharedEngine] RunRequest:dict path:SK_SAVE_RECORD completionHandler:^(id responseObject) {
        DLog(@"save success");
    } errorHandler:^(NSError *error) {
        DLog(@"save failed");
    } finishHandler:^(id responseObject) {
        if (responseObject!=nil) {
            DLog(@"save complete error");
        }
    }];
    
}
- (void)updateGameData
{
    NSString *email = [AppConfig getUserEmail];
    if (StringIsNullOrEmpty(email)) {
        return;
    }
    NSString *dayStr = @"2014-12-01"; //产品发布后开始
    GameDetail *detail = [AppConfig getLastGameDetail];
    if (detail !=nil) {
       // NSDate *day = [NSDate dateWithTimeIntervalSince1970:[detail.dateInterval intValue]*(24*60*60)];
        dayStr = detail.dateInterval;/// [day stringDateWithFormat:@"yyyy-MM-dd"];
    }

   
    
    [[BaseEngine sharedEngine] RunRequest:[@{@"email":email,@"begin":dayStr} mutableCopy] path:SK_GET_RECORD completionHandler:^(id responseObject) {
    
        NSArray *ary = [responseObject objectForKey:@"records"];
        if (ary && [ary count]>0) {
            [ary enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                if (obj) {
                    __block GameDetail *tempDetail = [[GameDetail alloc] initWithDictionary:obj];
                    NSString *scoreStr = [obj objectForKey:@"scoreData"];
                    NSArray *aryScores = [scoreStr objectFromJSONString];
                    if (aryScores && [aryScores count]>0) {
                        [aryScores enumerateObjectsUsingBlock:^(NSDictionary *obj1, NSUInteger idx, BOOL *stop) {
                            GameInfo *info = [[GameInfo alloc] initWithDictionary:obj1];
                            [tempDetail.aryGameInfo addObject:info];
                        }];
                    }
                    
                    [AppConfig saveGameDetail:tempDetail];
                }
            }];
        }
        
    } errorHandler:^(NSError *error) {
        showCustomAlertMessage(@"同步记录失败");
    } finishHandler:^(id responseObject) {
       
    }];
}

@end