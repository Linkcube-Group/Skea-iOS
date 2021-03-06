//
//  LoginViewController.m
//  Skea
//
//  Created by mosn on 10/7/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "LoginViewController.h"
#import "SignViewController.h"
#import "SkeaUser.h"
#import "ForgetPasswordViewController.h"

@interface LoginViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation LoginViewController
{
    UITextField * _emailTextField;
    UITextField * _passwordTextField;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:nil];
//    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"back-cross.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    
//    NSLog(@"%@",[SkeaUser defaultUser].isLogin?@"登录了":@"未登录");
    
    self.view.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:IMG(@"back-cross.png") forState:UIControlStateNormal];
    btn.tag = 200;
    [btn addTarget:self action:@selector(btBack_DisModal:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font=[Theam currentTheam].navigationBarItemFont;
    [btn setTitleColor:[Theam currentTheam].navigationBarItemTitleColor forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    btn.frame=CGRectMake(16, 32, 20, 20);
    
    //让图片在最右侧对齐
    CGSize imagesize=IMG(@"back-cross.png").size;
    imagesize.width=imagesize.width/2;
    imagesize.height=imagesize.height/2;
    CGSize btnsize=btn.size;
    
    //iOS7下面导航按钮会默认有10px间距
    UIEdgeInsets insets=UIEdgeInsetsMake((btnsize.height-imagesize.height)/2, btnsize.width-imagesize.width, (btnsize.height-imagesize.height)/2, 0);
    [btn setImageEdgeInsets:insets];
    btn.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    if (DeviceSystemSmallerThan(7.0)) {
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
    [self.view addSubview:btn];
    
    _emailTextField  = [[UITextField alloc] init];
    _passwordTextField = [[UITextField alloc] init];
    
    self.view.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.scrollEnabled = NO;
    tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 80.f;
    if(indexPath.row == 1 || indexPath.row == 2)
        return 40.f;
    return 400.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [NSString stringWithFormat:@"cell_%ld",(long)indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
        cell.contentView.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    }
    if(indexPath.row == 0)
    {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake((self.view.frame.size.width - 258/2)/2.f, 0, 258/2, 63);
        imageView.image = [UIImage imageNamed:@"logo.png"];
        [cell.contentView addSubview:imageView];
        [cell.contentView addSubview:[self lineViewWithFrame:CGRectMake(0, 79.5, self.view.frame.size.width, 0.5)]];
    }
    else if (indexPath.row == 1)
    {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(25, 10, 20, 20);
        imageView.image = [UIImage imageNamed:@"icon-email.png"];
        [cell.contentView addSubview:imageView];
        
//        UILabel * label = [[UILabel alloc] init];
//        label.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, 5, 50, 30);
//        label.backgroundColor = [UIColor clearColor];
//        label.text = NSLocalizedString(@"邮箱", nil);
//        [cell.contentView addSubview:label];
        
        _emailTextField.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, 5, self.view.frame.size.width - imageView.frame.origin.x - imageView.frame.size.width, 30);
        _emailTextField.placeholder = NSLocalizedString(@"请输入邮箱", nil);
        _emailTextField.returnKeyType = UIReturnKeyDone;
        _emailTextField.delegate = self;
        _emailTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        if([SkeaUser defaultUser].saveUser)
        {
            _emailTextField.text = [SkeaUser defaultUser].email;
        }
        [cell.contentView addSubview:_emailTextField];
        [cell.contentView addSubview:[self lineViewWithFrame:CGRectMake(20, 39.5, self.view.frame.size.width - 20, 0.5)]];
    }
    else if (indexPath.row == 2)
    {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(25, 10, 20, 20);
        imageView.image = [UIImage imageNamed:@"icon-password.png"];
        [cell.contentView addSubview:imageView];
        
//        UILabel * label = [[UILabel alloc] init];
//        label.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, 5, 50, 30);
//        label.backgroundColor = [UIColor clearColor];
//        label.text = NSLocalizedString(@"密码", nil);
//        [cell.contentView addSubview:label];
        
        _passwordTextField.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, 5, self.view.frame.size.width - imageView.frame.origin.x - imageView.frame.size.width, 30);
        _passwordTextField.placeholder = NSLocalizedString(@"请输入密码", nil);
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.returnKeyType = UIReturnKeyDone;
        _passwordTextField.delegate = self;
        _passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        if([SkeaUser defaultUser].saveUser)
        {
            _passwordTextField.text = [SkeaUser defaultUser].password;
        }
        [cell.contentView addSubview:_passwordTextField];
        [cell.contentView addSubview:[self lineViewWithFrame:CGRectMake(0, 39.5, self.view.frame.size.width, 0.5)]];
    }
    else
    {
        NSString * str0 = NSLocalizedString(@"记住用户名和密码", nil);
        CGSize size0 = [str0 sizeWithFont:[UIFont systemFontOfSize:13.f]];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(25, 10, 20, 20);
        if(![SkeaUser defaultUser].saveUser)
        {
            [btn setImage:[UIImage imageNamed:@"selection-unchecked.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"selection-checked.png"] forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [cell.contentView addSubview:btn];
        
        UILabel * label0 =[[UILabel alloc] init];
        label0.frame = CGRectMake(55, 10, size0.width, 20);
        label0.backgroundColor = [UIColor clearColor];
        label0.textColor = [UIColor blackColor];
        label0.text = str0;
        label0.font = [UIFont systemFontOfSize:13.f];
        [cell.contentView addSubview:label0];
        
        
        
        
        CGFloat buttonWidth = 100.f;
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.view.frame.size.width - buttonWidth, 5, buttonWidth, 30);
        [button setTitle:NSLocalizedString(@"忘记密码?", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [cell.contentView addSubview:button];
        
        UIButton * loginButtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loginButtn.frame = CGRectMake(8, 50, self.view.frame.size.width - 16, 44);
//        loginButtn.backgroundColor = [UIColor colorWithRed:220/255.f green:239/255.f blue:244/255.f alpha:1.f];
//        [loginButtn setImage:[UIImage imageNamed:@"button-cyan.png"] forState:UIControlStateNormal];
        [loginButtn setBackgroundImage:[UIImage imageNamed:@"button-cyan.png"] forState:UIControlStateNormal];
        [loginButtn setBackgroundImage:[UIImage imageNamed:@"loginButtonBg.png"] forState:UIControlStateHighlighted];
//        loginButtn.layer.borderWidth = 0.5;
//        loginButtn.layer.borderColor = [UIColor colorWithRed:103/255.f green:201/255 blue:224/255.f alpha:1.f].CGColor;
        loginButtn.layer.cornerRadius = 15.f;
        [loginButtn setTitle:NSLocalizedString(@"登陆", nil) forState:UIControlStateNormal];
        [loginButtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [loginButtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:loginButtn];
        
        UIButton * regButton = [UIButton buttonWithType:UIButtonTypeCustom];
        regButton.frame = CGRectMake(loginButtn.frame.origin.x, self.view.frame.size.height - 64 - 44 - 20 - 160, loginButtn.frame.size.width, loginButtn.frame.size.height);
//        regButton.layer.borderWidth = 0.5f;
//        regButton.layer.borderColor = [UIColor blackColor].CGColor;
//        regButton.layer.cornerRadius = 22.f;
        [regButton setBackgroundImage:[UIImage imageNamed:@"button-gray.png"] forState:UIControlStateNormal];
        [regButton setBackgroundImage:[UIImage imageNamed:@"loginButtonBg.png"] forState:UIControlStateHighlighted];
        [regButton setTitle:NSLocalizedString(@"注册", nil) forState:UIControlStateNormal];
        [regButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [regButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:regButton];
        
    }
    return cell;
}

-(void)agree:(UIButton *)btn
{
    //selection-unchecked.png
    if([SkeaUser defaultUser].saveUser)
    {
        [btn setImage:[UIImage imageNamed:@"selection-unchecked.png"] forState:UIControlStateNormal];
    }
    else
    {
        [btn setImage:[UIImage imageNamed:@"selection-checked.png"] forState:UIControlStateNormal];
    }
    [SkeaUser defaultUser].saveUser = ![SkeaUser defaultUser].saveUser;
}

-(UIView *)lineViewWithFrame:(CGRect)rect
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:156/255.f green:157/255.f blue:159/255.f alpha:1.f];
    view.frame = rect;
    return view;
}

-(void)login
{
//    NSLog(@"登陆");
//    [self btBack_DisModal:nil];
    NSString *email = _emailTextField.text;
    if (StringIsNullOrEmpty(email)) {
        showAlertMessage(NSLocalizedString(@"邮箱不能为空", nil));
        return;
    }
    NSString *pwd = _passwordTextField.text;
    if (StringIsNullOrEmpty(pwd)) {
        showAlertMessage(NSLocalizedString(@"密码不能为空", nil));
        return;
    }
    
    IMP_BLOCK_SELF(LoginViewController) //作为一个self的弱引用,在block里面调用
    
    showIndicator(YES, NSLocalizedString(@"正在加载中", nil));  ///弹一个正在加载的菊花
    ///path 在URL.h里面找对就的宏
    ///[@{@"email":email,@"password":pwd} mutableCopy] 这是一个要post内容的可扩展字面
    [[BaseEngine sharedEngine] RunRequest:[@{@"email":email,@"password":pwd} mutableCopy] path:SK_LOGIN completionHandler:^(id responseObject) {
        ///请求成功
        [AppConfig setUserEmail:email];
        showCustomAlertMessage(NSLocalizedString(@"登陆成功", nil));
        [SkeaUser defaultUser].email = _emailTextField.text;
        [SkeaUser defaultUser].password = _passwordTextField.text;
        [SkeaUser defaultUser].isLogin = YES;
        [SkeaUser defaultUser].userId = @"";
        
        [[BaseEngine sharedEngine] RunRequest:[@{@"email":[SkeaUser defaultUser].email} mutableCopy] path:SK_GETINFO completionHandler:^(id responseObject) {
            
            responseObject = (NSDictionary *)responseObject;
            [SkeaUser defaultUser].birthday = [[responseObject objectForKey:@"info"] objectForKey:@"birthday"];
            [SkeaUser defaultUser].height = [[responseObject objectForKey:@"info"] objectForKey:@"height"];
            [SkeaUser defaultUser].weight = [[responseObject objectForKey:@"info"] objectForKey:@"weight"];
            [SkeaUser defaultUser].nickName = [[responseObject objectForKey:@"info"] objectForKey:@"nickname"];
            
            
        } errorHandler:^(NSError *error) {
        
        } finishHandler:^(id responseObject) {
            
        }];
        
        ///////////////////////////////////////////
        
        [[BaseEngine sharedEngine] RunRequest:[@{@"email":email} mutableCopy] path:SK_LAST_QUS completionHandler:^(id responseObject) {
            [SkeaUser defaultUser].score = [[[responseObject objectForKey:@"info"] objectForKey:@"score"] integerValue];
            if([SkeaUser defaultUser].score <= 60)
                [SkeaUser defaultUser].level = 1;
            else if ([SkeaUser defaultUser].score <= 90)
                [SkeaUser defaultUser].level = 2;
            else if ([SkeaUser defaultUser].score <= 120)
                [SkeaUser defaultUser].level = 3;
            else
                [SkeaUser defaultUser].level = 4;
        } errorHandler:^(NSError *error) {
        } finishHandler:^(id responseObject) {
        }];
        ///////////////////////////////////////////
        
        showIndicator(NO, nil);
        [block_self btBack_DisModal:nil];
        
    } errorHandler:^(NSError *error) {
        ///网络失败
        showCustomAlertMessage(NSLocalizedString(@"无法连接网络", nil));
        showIndicator(NO, nil);
    } finishHandler:^(id responseObject) {
        ///请求结束，如果请求返回的status不为100，判断如下
        showIndicator(NO, nil);
        if (responseObject!=nil) {
            int statusCode = [[responseObject objectForKey:@"status"] intValue];
            if (statusCode>100) {
                NSString *errMsg = NSLocalizedString(@"服务器错误", nil);
                switch (statusCode) {
                    case 101:
                        errMsg = NSLocalizedString(@"参数错误", nil);
                        break;
                    case 102:
                        errMsg = NSLocalizedString(@"该用户名已被注册", nil);
                        break;
                    case 103:
                        errMsg = NSLocalizedString(@"用户名或密码错误", nil);
                        break;
                    case 104:
                        errMsg = NSLocalizedString(@"结果未找到", nil);
                        break;
                    default:
                        break;
                }
                showCustomAlertMessage(errMsg);
            }
        }
     
    }];
}

-(void)registerButtonClick
{
 //   NSLog(@"注册");
    SignViewController * svc = [[SignViewController alloc] init];
//    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:svc];
    [self presentViewController:svc animated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_emailTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    return YES;
}

-(void)forgetPassword
{
//    NSLog(@"忘记密码");
    ForgetPasswordViewController * svc = [[ForgetPasswordViewController alloc] init];
    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:svc];
    [self presentViewController:nvc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
