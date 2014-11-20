//
//  GameInfo.m
//  Skea
//
//  Created by mosn on 10/23/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "GameInfo.h"

@implementation GameInfo
- (id)initGameInfo:(int)point WithProgress:(int)length
{
    if (self=[super init]) {
        self.beginPoint = point;
        self.progressTime = length;
        self.halfScroes = [[NSMutableArray alloc] init];
        self.isCaled = NO;
        self.scoreRate = 0;
    }
    return self;
}
@end

@implementation GameInfoList

+(Class)elementClass
{
    return [GameInfo class];
}

@end
