//
//  ProtolManager.h
//  BossZP
//
//  Created by mosn on 4/28/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProtolManager : NSObject



+ (ProtolManager *)shareProtolManager;

///发送游戏数据到服务器
- (void)sendGameData:(GameDetail *)gdetail;
///同步游戏数据
- (void)updateGameData;

///电机敏感度设置值对应16档次
- (void)sendToolCompressLevel:(int)level;
///电机转动速度对应32个档次
- (void)sendToolRotateLevel:(int)level;

@end
