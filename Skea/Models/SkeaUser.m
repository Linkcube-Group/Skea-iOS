//
//  SkeaUser.m
//  Skea
//
//  Created by yuyang on 14/10/21.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "SkeaUser.h"

@implementation SkeaUser

static SkeaUser *DefaultManager = nil;

+(SkeaUser *)defaultUser
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        DefaultManager = [[self alloc] init];
    });
    return DefaultManager;
}

-(id)init
{
    if(self = [super init])
    {
        self.email        = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
        self.password     = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
        self.userId       = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        self.isLogin      = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
        self.autoLogin    = [[NSUserDefaults standardUserDefaults] boolForKey:@"autoLogin"];
        self.saveUser     = [[NSUserDefaults standardUserDefaults] boolForKey:@"saveUser"];
        self.birthday     = [[NSUserDefaults standardUserDefaults] objectForKey:@"birthday"];
        self.height       = [[NSUserDefaults standardUserDefaults] objectForKey:@"height"];
        self.weight       = [[NSUserDefaults standardUserDefaults] objectForKey:@"weight"];
        self.nickName     = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
        self.score        = [[NSUserDefaults standardUserDefaults] integerForKey:@"score"];
        self.level        = [[NSUserDefaults standardUserDefaults] integerForKey:@"level"];
        self.selectLevel  = [[NSUserDefaults standardUserDefaults] integerForKey:@"selectLevel"];
        self.speedType    = ((SpeedType)[[NSUserDefaults standardUserDefaults] integerForKey:@"speedType"]);
    }
    return self;
}

-(void)setSpeedType:(SpeedType)speedType
{
    [[NSUserDefaults standardUserDefaults] setInteger:speedType forKey:@"speedType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(SpeedType)speedType
{
    return ((SpeedType)[[NSUserDefaults standardUserDefaults] integerForKey:@"speedType"]);
}

-(void)setEmail:(NSString *)email
{
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)email
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
}

-(void)setPassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)password
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
}

-(void)setBirthday:(NSString *)birthday
{
    [[NSUserDefaults standardUserDefaults] setObject:birthday forKey:@"birthday"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)birthday
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"birthday"];
}

-(void)setHeight:(NSString *)height
{
    [[NSUserDefaults standardUserDefaults] setObject:height forKey:@"height"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)height
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"height"];
}

-(void)setWeight:(NSString *)weight
{
    [[NSUserDefaults standardUserDefaults] setObject:weight forKey:@"weight"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)weight
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"weight"];
}

-(void)setNickName:(NSString *)nickName
{
    [[NSUserDefaults standardUserDefaults] setObject:nickName forKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)nickName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
}

-(void)setIsLogin:(BOOL)isLogin
{
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)isLogin
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
}

-(void)setAutoLogin:(BOOL)autoLogin
{
    [[NSUserDefaults standardUserDefaults] setBool:autoLogin forKey:@"autoLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)autoLogin
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"autoLogin"];
}

-(void)setSaveUser:(BOOL)saveUser
{
    [[NSUserDefaults standardUserDefaults] setBool:saveUser forKey:@"saveUser"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)saveUser
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"saveUser"];
}

-(void)setUserId:(NSString *)userId
{
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)userId
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
}

-(void)setScore:(NSInteger)score
{
    [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"score"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSInteger)score
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"score"];
}

-(void)setLevel:(NSInteger)level
{
    [[NSUserDefaults standardUserDefaults] setInteger:level forKey:@"level"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSInteger)level
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"level"];
}

-(void)setSelectLevel:(NSInteger)selectLevel
{
    [[NSUserDefaults standardUserDefaults] setInteger:selectLevel forKey:@"selectLevel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSInteger)selectLevel
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"selectLevel"];
}

#pragma mark - NSCoding

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.email          = [aDecoder decodeObjectForKey:@"email"];
        self.password       = [aDecoder decodeObjectForKey:@"password"];
        self.userId         = [aDecoder decodeObjectForKey:@"userid"];
        self.isLogin        = [[aDecoder decodeObjectForKey:@"islogin"] boolValue];
        self.autoLogin      = [[aDecoder decodeObjectForKey:@"autoLogin"] boolValue];
        self.saveUser       = [[aDecoder decodeObjectForKey:@"saveUser"] boolValue];
        self.birthday       = [aDecoder decodeObjectForKey:@"birthday"];
        self.height         = [aDecoder decodeObjectForKey:@"height"];
        self.weight         = [aDecoder decodeObjectForKey:@"weight"];
        self.nickName       = [aDecoder decodeObjectForKey:@"nickName"];
        self.score          = [[aDecoder decodeObjectForKey:@"score"] integerValue];
        self.level          = [[aDecoder decodeObjectForKey:@"level"] integerValue];
        self.selectLevel    = [[aDecoder decodeObjectForKey:@"selectLevel"] integerValue];
        self.speedType      = ((SpeedType)[[aDecoder decodeObjectForKey:@"speedType"] integerValue]);
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.email                                       forKey:@"email"];
    [aCoder encodeObject:self.password                                    forKey:@"password"];
    [aCoder encodeObject:self.userId                                      forKey:@"userid"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.isLogin]           forKey:@"islogin"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.autoLogin]         forKey:@"autoLogin"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.saveUser]          forKey:@"saveUser"];
    [aCoder encodeObject:self.birthday                                    forKey:@"birthday"];
    [aCoder encodeObject:self.height                                      forKey:@"height"];
    [aCoder encodeObject:self.weight                                      forKey:@"weight"];
    [aCoder encodeObject:self.nickName                                    forKey:@"nickName"];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.score]          forKey:@"score"];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.level]          forKey:@"level"];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.selectLevel]    forKey:@"selectLevel"];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.speedType]      forKey:@"speedType"];
}

@end
