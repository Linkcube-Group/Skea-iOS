//
//  GameDetail.m
//  Skea
//
//  Created by mosn on 10/30/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "GameDetail.h"

@implementation GameDetail
- (NSDictionary*)dictionaryAlias
{
    return @{@"dateInterval":@[@"date"]};
}
- (NSString *)getStandard
{
    float rate = self.factScore*1.0/self.heighScore;
    if (rate>0.95) {
        return @"真棒!";
    }
    else if (rate>0.8){
        return @"优异!";
    }
    else if (rate>0.4){
        return @"普通";
    }
    return @"虚弱";
    
}

- (float)getExplosiveScore
{
    __block int num = 0;
    __block float rate = 0.0;
    [self.aryGameInfo.array enumerateObjectsUsingBlock:^(GameInfo *obj, NSUInteger idx, BOOL *stop) {
        if (obj.progressTime==2) {
            num++;
            rate+=obj.scoreRate;
        }
    }];
    
    rate = rate/num;
    
    return rate;
}
///爆发力
- (NSString *)getExplosive
{
    
    float rate = [self getExplosiveScore];
    if (rate>0.95) {
        return @"真棒!";
    }
    else if (rate>0.8){
        return @"优异!";
    }
    else if (rate>0.4){
        return @"普通";
    }
    return @"虚弱";
}


- (float)getEnduranceScore
{
    __block int num = 0;
    __block float rate = 0.0;
    [self.aryGameInfo.array enumerateObjectsUsingBlock:^(GameInfo *obj, NSUInteger idx, BOOL *stop) {
        if (obj.progressTime==12) {
            num++;
            rate+=obj.scoreRate;
        }
    }];
    
    rate = rate/num;
    return rate;
}
///耐力
- (NSString *)getEndurance
{
    float rate = [self getEnduranceScore];
    
    if (rate>0.95) {
        return @"真棒!";
    }
    else if (rate>0.8){
        return @"优异!";
    }
    else if (rate>0.4){
        return @"普通";
    }
    return @"虚弱";
}
@end
