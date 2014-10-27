//
//  SignViewController.m
//  Skea
//
//  Created by mosn on 10/7/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "SignViewController.h"
#import "PersonViewController.h"

@interface SignViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation SignViewController
{
    UITextField * _emailTextField;
    UITextField * _passwordTextField;
    UITextField * _rePasswordTextField;
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
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:nil];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"back-cross.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    
    _emailTextField  = [[UITextField alloc] init];
    _passwordTextField = [[UITextField alloc] init];
    _rePasswordTextField = [[UITextField alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 126.f;
    if(indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3)
        return 40.f;
    return 400.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [NSString stringWithFormat:@"cell_%ld",(long)indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
        label.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, 5, 80, 30);
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
        label.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, 5, 80, 30);
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
    else if (indexPath.row == 3)
    {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(40, 5, 30, 30);
        imageView.image = [UIImage imageNamed:@"icon-password.png"];
        [cell.contentView addSubview:imageView];
        
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, 5, 80, 30);
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"确认密码", nil);
        [cell.contentView addSubview:label];
        
        _rePasswordTextField.frame = CGRectMake(label.frame.origin.x + label.frame.size.width, 5, self.view.frame.size.width - label.frame.origin.x - label.frame.size.width, 30);
        _rePasswordTextField.placeholder = NSLocalizedString(@"再次输入密码", nil);
        _rePasswordTextField.secureTextEntry = YES;
        _rePasswordTextField.returnKeyType = UIReturnKeyDone;
        _rePasswordTextField.delegate = self;
        [cell.contentView addSubview:_rePasswordTextField];
    }
    else
    {
        CGFloat buttonWidth = 100.f;
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(40, 5, buttonWidth, 30);
        [button setTitle:NSLocalizedString(@"Skea用户协议", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [cell.contentView addSubview:button];
        
        UIButton * regButton = [UIButton buttonWithType:UIButtonTypeCustom];
        regButton.frame = CGRectMake(40, 50, self.view.frame.size.width - 80, 30);
        //        [loginButtn setImage:[UIImage imageNamed:@"button-cyan.png"] forState:UIControlStateNormal];
        regButton.layer.borderWidth = 0.5;
        regButton.layer.borderColor = [UIColor blackColor].CGColor;
        regButton.layer.cornerRadius = 15.f;
        [regButton setTitle:NSLocalizedString(@"注册", nil) forState:UIControlStateNormal];
        [regButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [regButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:regButton];
        
        UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        loginButton.frame = CGRectMake(regButton.frame.origin.x, regButton.frame.origin.y + regButton.frame.size.height + 10, regButton.frame.size.width, regButton.frame.size.height);
        loginButton.layer.borderWidth = 0.5f;
        loginButton.layer.borderColor = [UIColor blackColor].CGColor;
        loginButton.layer.cornerRadius = 15.f;
        [loginButton setTitle:NSLocalizedString(@"登陆", nil) forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:loginButton];
        
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
//    [self btBack_DisModal:nil];
    PersonViewController * pvc = [[PersonViewController alloc] init];
    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:pvc];
    [self presentViewController:nvc animated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_emailTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_rePasswordTextField resignFirstResponder];
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
