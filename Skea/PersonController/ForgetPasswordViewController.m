//
//  ForgetPasswordViewController.m
//  Skea
//
//  Created by yuyang on 14/12/18.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()<UITextFieldDelegate>

@end

@implementation ForgetPasswordViewController
{
    UITextField * _textField;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:NSLocalizedString(@"找回密码", nil)];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"menu_action_back_white.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    
    UIView * wView = [[UIView alloc] init];
    wView.frame = CGRectMake(0, 20, self.view.frame.size.width, 40);
    wView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:wView];
    
    _textField = [[UITextField alloc] init];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.frame = CGRectMake(20, 20, self.view.frame.size.width - 40, 40);
    _textField.placeholder = NSLocalizedString(@"请输入邮箱", nil);
    _textField.delegate = self;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.text = [SkeaUser defaultUser].email;
    [_textField becomeFirstResponder];
    [self.view addSubview:_textField];
    
    self.view.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(20, 70, self.view.frame.size.width - 40, 40);
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14.f];
    label.numberOfLines = 2;
    label.text = NSLocalizedString(@"点击“找回密码”按钮，系统将会把您的密码发送到您注册邮箱。", nil);
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    
    
    UIButton * findButton = [UIButton buttonWithType:UIButtonTypeCustom];
    findButton.frame = CGRectMake(8, 120, self.view.frame.size.width - 16, 44);
    [findButton setBackgroundImage:[UIImage imageNamed:@"button-cyan.png"] forState:UIControlStateNormal];
    [findButton setBackgroundImage:[UIImage imageNamed:@"loginButtonBg.png"] forState:UIControlStateHighlighted];
    findButton.layer.cornerRadius = 15.f;
    [findButton setTitle:NSLocalizedString(@"找回密码", nil) forState:UIControlStateNormal];
    [findButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [findButton addTarget:self action:@selector(find) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:findButton];
    
    
}

-(void)find
{
    NSString *email = _textField.text;
    if (StringIsNullOrEmpty(email)) {
        showAlertMessage(@"邮箱不能为空");
        return;
    }
    
    IMP_BLOCK_SELF(ForgetPasswordViewController) //作为一个self的弱引用,在block里面调用
    
    showIndicator(YES, @"正在加载中");  ///弹一个正在加载的菊花
    ///path 在URL.h里面找对就的宏
    ///[@{@"email":email,@"password":pwd} mutableCopy] 这是一个要post内容的可扩展字面
    [[BaseEngine sharedEngine] RunRequest:[@{@"email":email} mutableCopy] path:SK_FIND_PASSWORD completionHandler:^(id responseObject) {
        ///请求成功
        showCustomAlertMessage(@"已发送到您的邮箱");
        
        [block_self btBack_DisModal:nil];
        
        showIndicator(NO, nil);
        
    } errorHandler:^(NSError *error) {
        ///网络失败
        showAlertMessage(@"网络不给力");
        showIndicator(NO, nil);
    } finishHandler:^(id responseObject) {
        ///请求结束，如果请求返回的status不为100，判断如下
        showIndicator(NO, nil);
        if (responseObject!=nil) {
            int statusCode = [[responseObject objectForKey:@"status"] intValue];
            if (statusCode>100) {
                NSString *errMsg = @"服务器错误";
                switch (statusCode) {
                    case 101:
                        errMsg = @"参数错误";
                        break;
                    case 102:
                        errMsg = @"该用户已被注册";
                        break;
                    case 103:
                        errMsg = @"用户名或密码错误";
                        break;
                    case 104:
                        errMsg = @"结果未找到";
                        break;
                    default:
                        break;
                }
                showCustomAlertMessage(errMsg);
            }
        }
        
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
