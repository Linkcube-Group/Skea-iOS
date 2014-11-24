//
//  SkeaUser.h
//  Skea
//
//  Created by yuyang on 14/10/21.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SkeaUser : NSObject<NSCoding>

@property(nonatomic,strong) NSString * email;            //邮箱
@property(nonatomic,strong) NSString * password;         //密码
@property(nonatomic,strong) NSString * userId;           //id
@property(nonatomic)        BOOL       isLogin;          //是否登录状态

+(SkeaUser *)defaultUser;

@end
