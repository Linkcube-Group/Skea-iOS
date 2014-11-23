//
//  ELUtils.m
//  ELBooks
//
//  Created by Eric on 12-8-25.
//  Copyright 2012 zhaopin. All rights reserved.
//

#import "ELUtils.h"
#import "CustomAlertView.h"
#import <sys/sysctl.h>
#import "BaseViewController.h"
#import "sys/utsname.h"

NSUInteger DeviceSystemMajorVersion() {
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion]
                                       componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    
    return _deviceSystemMajorVersion;
}
NSString*  DeviceDetailInfo() {
    static NSString * _deviceDetailInfo = @"";
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString * systemVersion = [[UIDevice currentDevice] systemVersion];
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        NSString * os = @"iOS";
        NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:deviceString,@"model",os,@"os",systemVersion,@"version", nil];
        
       _deviceDetailInfo = [dict JSONString];
        
    });
    return _deviceDetailInfo;
}
void showAlertMessage(NSString *message)
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
    [alert show];
}


void showCustomAlertMessage(NSString *message)
{
    if (message==nil || [message length]<1) {
        return;
    }
    CustomAlertView *customAlartView = (CustomAlertView *)[theApp.window viewWithTag:980153];
    if (customAlartView) {
        [customAlartView removeFromSuperview];
        customAlartView = nil;
    }
//    161 78
    customAlartView = [[CustomAlertView alloc] initWithFrame:CGRectMake(80, 460 / 2, 160, 50)] ;
    customAlartView.titleLabel.text = message;
    customAlartView.tag = 980153;
    
    [theApp.window addSubview: customAlartView];
}

void showFullScreen(BOOL flag)
{
    theApp.window.userInteractionEnabled = !flag;
}
void showFullView(BOOL flag,BaseViewController * bvc)
{
    bvc.view.userInteractionEnabled = !flag;
}
void showIndicator(BOOL flag,NSString * title)
{
    UIView *activityView = (UIView *)[theApp.window viewWithTag:70021];
    if (flag) {
        if (activityView==nil) {
            activityView = [[UIView alloc] initWithFrame:CGRectMake(110, 120, 100, 100)];
            activityView.tag = 70021;
            activityView.backgroundColor = [UIColor clearColor];
            UIView * v = [[UIView alloc]initWithFrame:activityView.bounds];
            v.backgroundColor = [UIColor blackColor];
            v.alpha = .7;
            v.layer.cornerRadius = 5;
            v.layer.masksToBounds = YES;
            [activityView addSubview:v];
            [activityView.layer setContents:(id)[[UIImage imageNamed:@"incativy.png"] CGImage]];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(3, 65, 95, 32)];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = title;
            label.numberOfLines = 0;
            label.font = [UIFont CustomFontGBKSize:12];
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor clearColor];
            [activityView addSubview:label];
            
            UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            activityIndicator.frame = CGRectMake(9, 3, 20, 20); //26 = 32-3x2
            [activityView addSubview:activityIndicator];
            activityIndicator.tag = 794232;
            
            activityIndicator.center = CGPointMake(50,40);
            [activityIndicator startAnimating];
            
            
            activityView.center = theApp.window.center;
            [theApp.window addSubview:activityView];
            
        }
        
    }
    else{
        if (activityView && [activityView superview]) {
            UIImageView *activityIndicator = (UIImageView *)[activityView viewWithTag:794232];
            if (activityIndicator) {
                [activityIndicator stopAnimating];
            }
            [activityView removeFromSuperview];
        }
    }
    
}



//限制字数
float getTextLength(NSString *text)
{
    
    float num = 0;
    for (int i =0; i<[text length]; i++) {
        
        NSRange  range = {i,1};
        
        NSString  *str = [text substringWithRange:range];
        
        if (![str isEqualToString:@""] || str != nil)
        {
            int  charLenth = (int)[str lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
            if (charLenth == 3) {
                num += 1;
            }
            if (charLenth == 1) {
                num += 0.5;
            }
        }
        else
        {
            num += 0.5;
        }
    }
    return num;
}


/*
 函数名:   IsValidEmail
 作者:     eric
 创建日期:  2012年8月10日
 描述:     用于判断主流邮箱的校验.若返回nil合法邮箱，否则不合法。
 */
NSString* IsValidEmail(NSString *pszEmail)
{
    if(pszEmail == nil || [pszEmail length]<1)
    {
        return @"请输入邮箱";
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:pszEmail]?nil:@"邮箱不合法";
    
}

/*
 函数名:   IsValidMobeilTel
 作者:     eric
 创建日期:  2012年8月10日
 描述:     用于判断目前中华人民共和国三大运营商的手机号码合法性校验，若返回0，1，2表示合法，否则不合法
 */
NSString* IsValidMobeilTel(const char* pszTel)
{
    NSString* tyle = @"-1";
    int len = (int)strlen(pszTel);
    
    if(pszTel == NULL || len<1)
    {
        return @"请填写手机号";
    }
    
    
    if(len != 11)
    {
        return @"手机号码的长度不合要求";
    }
    int i = 0;
    while (i < len)
    {
        if(!isdigit(pszTel[i]))
        {
            return @"手机号码中包含不合法的数字";
        }
        
        if(i == 0)
        {
            if(pszTel[i] != '1')
            {
                return @"手机号码格式不合要求";
            }
        }
        else if(i == 1)
        {
            if(pszTel[i] != '3' && pszTel[i] != '4' && pszTel[i] != '5' && pszTel[i] != '8')
            {
                return @"手机号码格式不合要求";
            }
        }
        else if(i == 2)
        {
            if(( pszTel[i-1] == '3' && (pszTel[i] == '0' || pszTel[i] == '1' || pszTel[i] == '2')) ||
               (pszTel[i-1] == '4' && pszTel[i] == '5') ||
               (pszTel[i-1] == '5' && (pszTel[i] == '5' || pszTel[i] == '6'))||
               (pszTel[i-1] == '8' && (pszTel[i] == '5' || pszTel[i] == '6')))
            {
                tyle = @"0";
            }
            else if((pszTel[i-1] == '3' && (pszTel[i] == '4' || pszTel[i] == '5' || pszTel[i] == '6' || pszTel[i] == '7' || pszTel[i] == '8' || pszTel[i] == '9')) ||
                    (pszTel[i-1] == '4' && pszTel[i] == '7') ||
                    (pszTel[i-1] == '5' && (pszTel[i] == '0' || pszTel[i] == '1' || pszTel[i] == '2' || pszTel[i] == '7' || pszTel[i] == '8' || pszTel[i] == '9'))||
                    (pszTel[i-1] == '8' && (pszTel[i] == '2' || pszTel[i] == '3' || pszTel[i] == '7' || pszTel[i] == '8')))
            {
                tyle = @"1";
            }
            else if((pszTel[i-1] == '3' && pszTel[i] == '3') ||
                    (pszTel[i-1] == '5' && pszTel[i] == '3') ||
                    (pszTel[i-1] == '8' && (pszTel[i] == '9' || pszTel[i] == '0')))
            {
                tyle = @"2";
            }
            else
            {
                return @"手机号码不存在该号段.";
            }
        }
        i++;
    }
    return tyle;
}
NSString* IsValidPWD(const char* passWord)
{
    if(passWord == NULL)
    {
        return @"请输入密码";
    }
    int i = 0;
    
    while(*(passWord + i) != '\0')
    {
        char ch = *(passWord + i);
        if(!isdigit(ch) && !isalnum(ch) && ch!='_')
        {
            return @"密码应为6-25位的字母、数字或下划线";
        }
        i++;
    }
    return nil;
}

NSMutableArray * addPhoneNumArr(NSString *text)
{
    //匹配电话号码
    NSString *regex_phonenum = @"\\d{3}-\\d{8}|\\d{3}-\\d{7}|\\d{4}-\\d{8}|\\d{4}-\\d{7}|1+\\d{10}|\\d{7,}";
    NSArray *array_phonenum = [text componentsMatchedByRegex:regex_phonenum];
    NSMutableArray *phoneNumArr = [NSMutableArray arrayWithArray:array_phonenum];
    return phoneNumArr;
}

NSMutableArray * addEmailArr(NSString *text)
{
    //匹配Email地址
    NSString *regex_email = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*.\\w+([-.]\\w+)*";
    NSArray *array_email = [text componentsMatchedByRegex:regex_email];
    NSMutableArray *emailArr = [NSMutableArray arrayWithArray:array_email];
    return emailArr;
}





NSString* mydeviceUniqueIdentifier()
{
    NSString *uniqueIdentifier = nil;
    if (isIOS7) {
        uniqueIdentifier = [UIDevice uniqueAdvertisingIdentifier];
    }
    else{
        uniqueIdentifier = [UIDevice uniqueGlobalDeviceIdentifier];
    }
    
    return uniqueIdentifier;
}

