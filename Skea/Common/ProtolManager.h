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

@end
