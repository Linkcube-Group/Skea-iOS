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
@property(nonatomic)        BOOL       autoLogin;        //自动登录(未启用)
@property(nonatomic)        BOOL       saveUser;         //记住用户名和密码

@property(nonatomic,strong) NSString * birthday;         //生日
@property(nonatomic,strong) NSString * height;           //身高
@property(nonatomic,strong) NSString * weight;           //体重
@property(nonatomic,strong) NSString * nickName;         //昵称

+(SkeaUser *)defaultUser;

@end
