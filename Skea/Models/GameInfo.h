//
//  GameInfo.h
//  Skea
//
//  Created by mosn on 10/23/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "ModelBase.h"

@interface GameInfo : ModelBase

@property (nonatomic) int beginPoint; //90
@property (nonatomic) int progress;// 7
@property (nonatomic,strong) NSMutableArray *halfScroes; //[23,23,23,34]

- (id)initGameInfo:(int)point WithProgress:(int)length;
@end
