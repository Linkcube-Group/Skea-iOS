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
@property (nonatomic) int totalScore;
@property (nonatomic) int factScore;
@property (nonatomic) int gameTime;
@property (nonatomic) int level;
@property (strong,nonatomic) NSString *date;


- (NSString *)getStandard;
- (NSString *)getExplosive;
- (NSString *)getEndurance;
@end
