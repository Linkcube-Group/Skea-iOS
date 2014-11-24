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
        self.email = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
        self.password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
        self.userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        self.isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
    }
    return self;
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

-(void)setIsLogin:(BOOL)isLogin
{
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)isLogin
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
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
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.email                             forKey:@"email"];
    [aCoder encodeObject:self.password                          forKey:@"password"];
    [aCoder encodeObject:self.userId                            forKey:@"userid"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.isLogin] forKey:@"islogin"];
}

@end
