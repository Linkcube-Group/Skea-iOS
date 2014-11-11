//
//  LoginViewController.m
//  Skea
//
//  Created by mosn on 10/7/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "LoginViewController.h"
#import "SignViewController.h"

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
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:IMG(@"back-cross.png") forState:UIControlStateNormal];
    btn.tag = 200;
    [btn addTarget:self action:@selector(btBack_DisModal:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font=[Theam currentTheam].navigationBarItemFont;
    [btn setTitleColor:[Theam currentTheam].navigationBarItemTitleColor forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    btn.frame=CGRectMake(10, 34, 30, 30);
    
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
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
        return 126.f;
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
    }
    if(indexPath.row == 0)
    {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake((self.view.frame.size.width - 258/2)/2.f, 63 - 30, 258/2, 126/2);
        imageView.image = [UIImage imageNamed:@"logo.png"];
        [cell.contentView addSubview:imageView];
    }
    else if (indexPath.row == 1)
    {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(40, 5, 30, 30);
        imageView.image = [UIImage imageNamed:@"icon-email.png"];
        [cell.contentView addSubview:imageView];
        
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, 5, 50, 30);
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"邮箱", nil);
        [cell.contentView addSubview:label];
        
        _emailTextField.frame = CGRectMake(label.frame.origin.x + label.frame.size.width, 5, self.view.frame.size.width - label.frame.origin.x - label.frame.size.width, 30);
        _emailTextField.placeholder = NSLocalizedString(@"请输入邮箱", nil);
        _emailTextField.returnKeyType = UIReturnKeyDone;
        _emailTextField.delegate = self;
        [cell.contentView addSubview:_emailTextField];
    }
    else if (indexPath.row == 2)
    {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(40, 5, 30, 30);
        imageView.image = [UIImage imageNamed:@"icon-password.png"];
        [cell.contentView addSubview:imageView];
        
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, 5, 50, 30);
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"密码", nil);
        [cell.contentView addSubview:label];
        
        _passwordTextField.frame = CGRectMake(label.frame.origin.x + label.frame.size.width, 5, self.view.frame.size.width - label.frame.origin.x - label.frame.size.width, 30);
        _passwordTextField.placeholder = NSLocalizedString(@"请输入密码", nil);
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.returnKeyType = UIReturnKeyDone;
        _passwordTextField.delegate = self;
        [cell.contentView addSubview:_passwordTextField];
    }
    else
    {
        CGFloat buttonWidth = 100.f;
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.view.frame.size.width - buttonWidth, 5, buttonWidth, 30);
        [button setTitle:NSLocalizedString(@"忘记密码?", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [cell.contentView addSubview:button];
        
        UIButton * loginButtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loginButtn.frame = CGRectMake(40, 50, self.view.frame.size.width - 80, 30);
        loginButtn.backgroundColor = [UIColor colorWithRed:220/255.f green:239/255.f blue:244/255.f alpha:1.f];
//        [loginButtn setImage:[UIImage imageNamed:@"button-cyan.png"] forState:UIControlStateNormal];
        loginButtn.layer.borderWidth = 0.5;
        loginButtn.layer.borderColor = [UIColor colorWithRed:103/255.f green:201/255 blue:224/255.f alpha:1.f].CGColor;
        loginButtn.layer.cornerRadius = 15.f;
        [loginButtn setTitle:NSLocalizedString(@"登陆", nil) forState:UIControlStateNormal];
        [loginButtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [loginButtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:loginButtn];
        
        UIButton * regButton = [UIButton buttonWithType:UIButtonTypeCustom];
        regButton.frame = CGRectMake(loginButtn.frame.origin.x, loginButtn.frame.origin.y + loginButtn.frame.size.height + 10, loginButtn.frame.size.width, loginButtn.frame.size.height);
        regButton.layer.borderWidth = 0.5f;
        regButton.layer.borderColor = [UIColor blackColor].CGColor;
        regButton.layer.cornerRadius = 15.f;
        [regButton setTitle:NSLocalizedString(@"注册", nil) forState:UIControlStateNormal];
        [regButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [regButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:regButton];
        
    }
    return cell;
}

-(void)login
{
    NSLog(@"登陆");
    [self btBack_DisModal:nil];
}

-(void)registerButtonClick
{
    NSLog(@"注册");
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
    NSLog(@"忘记密码");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
