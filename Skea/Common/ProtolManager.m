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
    NSString *email = [AppConfig getUserEmail];
    if (StringIsNullOrEmpty(email)) {
        return;
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:email forKey:@"email"];
    NSDate *day = [NSDate dateWithTimeIntervalSince1970:[gameDetail.date intValue]*(24*60*60)];
    NSString *dayStr = [day stringDateWithFormat:@"yyyy-MM-dd"];
    [dict setObject:dayStr forKey:@"date"];
    
    [dict setObject:_S(@"%d",gameDetail.heighScore) forKey:@"heighScore"];
    [dict setObject:_S(@"%d",gameDetail.factScore) forKey:@"factScore"];
    [dict setObject:_S(@"%d",gameDetail.exerciseTime) forKey:@"exerciseTime"];
    
    int level = [AppConfig getGameLevel];
    [dict setObject:_S(@"%d",level) forKey:@"level"];
    
    [dict setObject:_S(@"%.2f",[gameDetail getExplosiveScore]) forKey:@"explosive"];
    [dict setObject:_S(@"%.2f",[gameDetail getEnduranceScore]) forKey:@"endurance"];
    
    
    NSString *exerciseData = @"{}";
    NSString *scoreData = @"{}";
    [dict setObject:exerciseData forKey:@"exerciseData"];
    [dict setObject:scoreData forKey:@"scoreData"];
    
    [[BaseEngine sharedEngine] RunRequest:dict path:SK_SAVE_RECORD completionHandler:^(id responseObject) {
        
    } errorHandler:^(NSError *error) {
        
    } finishHandler:^(id responseObject) {
        
    }];
    
}
- (void)updateGameData
{
    
}

@end