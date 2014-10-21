//
//  SkeaUser.m
//  Skea
//
//  Created by yuyang on 14/10/21.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "SkeaUser.h"

@implementation SkeaUser

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
    [aCoder encodeObject:_email                        forKey:@"email"];
    [aCoder encodeObject:_password                     forKey:@"password"];
    [aCoder encodeObject:_userId                       forKey:@"userid"];
    [aCoder encodeObject:[NSNumber numberWithBool:_isLogin] forKey:@"islogin"];
}

@end
