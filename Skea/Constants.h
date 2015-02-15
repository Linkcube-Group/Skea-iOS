//
//  Constants.h
//  huizon
//
//  Created by Yang on 13-11-8.
//  Copyright (c) 2013年 zhaopin. All rights reserved.
//

/*
  在project,targe修改 project Name "new name", 单击target的名称后，可以修改
 */
#ifndef zhaopin_Constants_h
#define zhaopin_Constants_h

///打印日志，发布时关闭
//TODO: app store delete
//#define DEBUG_REVEL 1


///宏提速NSCoding
#define OBJC_STRINGIFY(x) @#x
#define encodeObject(x) [aCoder encodeObject:x forKey:OBJC_STRINGIFY(x)]
#define decodeObject(x) x = [aDecoder decodeObjectForKey:OBJC_STRINGIFY(x)]

#define THEME_COLOR [UIColor colorWithRed:83/255.0 green:202/255.0 blue:196/255.0 alpha:1]

///判断是否是ios7
#define isIOS7 (DeviceSystemMajorVersion()< 7 ? NO:YES)


#define theApp ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width


#define KeyWindow       [[UIApplication sharedApplication] keyWindow]

#define MainWindow      [[[UIApplication sharedApplication] delegate] window]



/// 友盟配置
static NSString * const kUmengAppKey = @"54e03a57fd98c5b2790007e6";
/**
 *  微信
 */
static NSString * const kWeiXinAppKey = @"wx9e569a13d211567d";
///新浪微博
static NSString * const kSinaRedirectURL = @"http://www.bosszhipim";
static NSString * const kSinaAppKey  = @"1054079396";
static NSString * const kSinaAppSecret = @"c894fa362e62dbd4cf7063951830adf9";

///服务器地址-测试环境
static NSString * const kServerDomain = @"112.124.22.252:8002";

static int const tabHeight = 49;


///收到蓝牙的通知
static NSString * const kNotificationBlueTooth = @"kNotificationBlueTooth";

///连接蓝牙成功
static NSString * const kNotificationConnected = @"kNotificationConnected";
//断开
static NSString * const kNotificationDisConnected = @"kNotificationDisConnected";


static const int chatHeight = 200;

#endif