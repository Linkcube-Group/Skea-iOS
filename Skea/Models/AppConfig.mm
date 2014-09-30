//
//  AppConfig.m
//  BossZP
//
//  Created by mosn on 4/9/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "AppConfig.h"

@implementation AppConfig
+ (NSString *)getSinaAccessToken
{
    NSString *kName = @"SinaKeyToken";
    return [[NSUserDefaults standardUserDefaults] objectForKey:kName];
}

+ (void)setSinaAccessToken:(NSString *)token
{
    NSString *kName =@"SinaKeyToken";
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
