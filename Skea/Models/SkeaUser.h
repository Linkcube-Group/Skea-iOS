//
//  SkeaUser.h
//  Skea
//
//  Created by yuyang on 14/10/21.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SpeedTypeConstant = 0,     //恒速
    SpeedTypeChange = 1        //变速
}SpeedType;

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

@property(nonatomic)        NSInteger score;             //分数
@property(nonatomic)        NSInteger level;             //计算的等级
@property(nonatomic)        NSInteger selectLevel;       //自己选择的等级

@property(nonatomic)        SpeedType speedType;         //恒速变速

+(SkeaUser *)defaultUser;

@end
