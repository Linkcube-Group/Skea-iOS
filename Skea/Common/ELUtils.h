//
//  ELUtils.h
//  ELBooks
//
//  Created by Xie Wei on 11-3-25.
//  Copyright 2011 e-linkway.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
void showAlertByCode(int errorCode);

void showAlertMessage(NSString *message);

void showCustomAlertMessage(NSString *message);

void showIndicator(BOOL flag,NSString * title);
void showFullScreen(BOOL flag);
void showFullView(BOOL flag,BaseViewController * bvc);


NSString* IsValidPWD(const char* passWord);
NSString* IsValidEmail(NSString *pszEmail);
NSString* IsValidMobeilTel(const char* pszTel);
float getTextLength(NSString *text);

///匹配电话号码
NSMutableArray * addPhoneNumArr(NSString *text);
///匹配Email地址
NSMutableArray * addEmailArr(NSString *text);



NSUInteger DeviceSystemMajorVersion();
NSString* mydeviceUniqueIdentifier();
NSString* DeviceDetailInfo();