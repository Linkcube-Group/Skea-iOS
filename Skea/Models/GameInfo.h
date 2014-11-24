//
//  GameInfo.h
//  Skea
//
//  Created by mosn on 10/23/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "ModelBase.h"
#import "ModelList.h"

@interface GameHalfList : ModelList
//@property (strong,nonatomic) NSString *nobTime;
@end

@interface GameInfo : ModelBase

@property (nonatomic) int beginPoint; //90
@property (nonatomic) int progressTime;// 7
@property (nonatomic,strong) GameHalfList *halfScroes; //[23,23,23,34]

@property (nonatomic) float scoreRate;

@property (nonatomic) BOOL isCaled;//是否被计算过

- (id)initGameInfo:(int)point WithProgress:(int)length;
@end


@interface GameInfoList : ModelList

@end