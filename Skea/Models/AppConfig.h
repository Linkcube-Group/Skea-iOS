//
//  AppConfig.h
//  BossZP
//
//  Created by mosn on 4/9/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfig : NSObject

+ (NSString *)getSinaAccessToken;
+ (void)setSinaAccessToken:(NSString *)token;


+ (void)saveGameDetail:(GameDetail *)detail;
+ (GameDetail *)getGameDetail:(NSString *)date;

+ (GameDetail *)getLastGameDetail;

+ (NSArray *)getGameRecodeDates;
+ (void)setGameRecordDate:(NSString*)timer;

+ (int)getGameLevel;
+ (void)setGameLevel:(int)level;

+ (void)setUserEmail:(NSString *)email;
+ (NSString *)getUserEmail;
@end
