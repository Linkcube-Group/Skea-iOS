//
//  GameDetail.h
//  Skea
//
//  Created by mosn on 10/30/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "ModelBase.h"
#import "GameInfo.h"

@interface GameDetail : ModelBase

@property (strong,nonatomic) GameInfoList *aryGameInfo;
@property (nonatomic) int heighScore;
@property (nonatomic) int factScore;
@property (nonatomic) int exerciseTime;
@property (nonatomic) int level;
@property (strong,nonatomic) NSString *date;
///爆发力
@property (nonatomic) float explosive;
///耐力
@property (nonatomic) float endurance;

- (NSString *)getStandard;
- (NSString *)getExplosive;
- (NSString *)getEndurance;

- (float)getExplosiveScore;
- (float)getEnduranceScore;
@end
