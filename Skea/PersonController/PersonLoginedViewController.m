//
//  PersonLoginedViewController.m
//  Skea
//
//  Created by yuyang on 14/10/30.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "PersonLoginedViewController.h"
#import "PersonSetViewController.h"
#import "HealthTestViewController.h"
#import "ParameterSetViewController.h"
#import "BuyViewController.h"
#import "InputViewController.h"
#import "SkeaUser.h"

@interface PersonLoginedViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,inputDelegate>

@end

@implementation PersonLoginedViewController
{
    UIImageView * photoImageView;
    NSString * nickname;
    UITableView * _mainTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    nickname = [SkeaUser defaultUser].nickName.length?[SkeaUser defaultUser].nickName:@"Skea";
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:NSLocalizedString(@"个人", nil)];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"menu_action_back_white.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    self.view.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.f];
    photoImageView = [[UIImageView alloc] init];
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 299) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.scrollEnabled = NO;
//    tableView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_mainTableView];
    
    UIButton * LogoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    LogoutButton.frame = CGRectMake(10,self.view.frame.size.height - 80 - 64,self.view.frame.size.width - 20,44);
    LogoutButton.backgroundColor = [UIColor whiteColor];
//    LogoutButton.layer.borderWidth = 0.5f;
//    LogoutButton.layer.borderColor = [UIColor blackColor].CGColor;
    LogoutButton.layer.cornerRadius = 20.f;
    [LogoutButton setTitle:NSLocalizedString(@"退出登录", nil) forState:UIControlStateNormal];
    [LogoutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [LogoutButton setBackgroundImage:[UIImage imageNamed:@"button-cyan.png"] forState:UIControlStateNormal];
    [LogoutButton setBackgroundImage:[UIImage imageNamed:@"loginButtonBg.png"] forState:UIControlStateHighlighted];
    [LogoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LogoutButton];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mainTableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 2)
        return 2;
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 4)
        return 0.f;
    return 25.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.f];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0 && indexPath.section == 0)
        return 40.f;
    if(indexPath.section == 4)
        return 150.f;
    return 40.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [NSString stringWithFormat:@"cell_%ld",(long)indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = [UIColor whiteColor];
//    cell.accessoryType = UITableViewCellAccessoryNone;
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        cell.imageView.image = [UIImage imageNamed:@"icon_me_small.png"];
        cell.textLabel.text = [SkeaUser defaultUser].nickName.length?[SkeaUser defaultUser].nickName:@"Skea";
    }
    if(indexPath.section == 1)
    {
        cell.imageView.image = [UIImage imageNamed:@"settings-evaluate-risk.png"];
        cell.textLabel.text = NSLocalizedString(@"盆底肌健康测试", nil);
    }
    if(indexPath.section == 2)
    {
        if(indexPath.row == 0)
        {
            cell.imageView.image = [UIImage imageNamed:@"settings-configure-skea.png"];
            cell.textLabel.text = NSLocalizedString(@"Skea参数调节", nil);
        }
        if(indexPath.row == 1)
        {
            cell.imageView.image = [UIImage imageNamed:@"settings-buy-skea.png"];
            cell.textLabel.text = NSLocalizedString(@"购买Skea产品", nil);
        }
    }
    if(indexPath.section == 3)
    {
        cell.imageView.image = [UIImage imageNamed:@"settings-settings.png"];
        cell.textLabel.text = NSLocalizedString(@"设置", nil);
    }
    return cell;
}

-(void)logout
{
    [SkeaUser defaultUser].isLogin = NO;
    [SkeaUser defaultUser].birthday = @"";
    [SkeaUser defaultUser].height = @"0";
    [SkeaUser defaultUser].weight = @"0";
    [SkeaUser defaultUser].nickName = @"";
    [SkeaUser defaultUser].score = 0;
    [SkeaUser defaultUser].level = 0;
    [SkeaUser defaultUser].selectLevel = 0;
    
    [self btBack_DisModal:nil];
}

-(void)photoSelect
{
    NSLog(@"选择投降");
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [imagePicker setAllowsEditing:YES];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo
{
    
    CGSize size = img.size;
    CGFloat ratio = 1;
    if (size.width>440) {
        ratio = 440/size.width;
    }
    int ratwid = ratio*size.width;
    int rathig = ratio*size.height;
    if (ratwid<1) {
        ratwid = 1;
    }
    if (rathig<1) {
        rathig = 1;
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, ratwid, rathig);
    UIGraphicsBeginImageContext(rect.size);
    [img drawInRect:rect];
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    photoImageView.image = img;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 1)
    {
        HealthTestViewController * hvc = [[HealthTestViewController alloc] init];
//        UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:hvc];
        [self presentViewController:hvc animated:YES completion:nil];
    }
    if(indexPath.row == 0 && indexPath.section == 0)
    {
//        [self photoSelect];
        InputViewController * ivc = [[InputViewController alloc] init];
        UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:ivc];
        ivc.delegate = self;
        ivc.nickName = [SkeaUser defaultUser].nickName;
        [self presentViewController:nvc animated:YES completion:nil];
    }
    if(indexPath.section == 2)
    {
        if(indexPath.row == 0)
        {
            ParameterSetViewController * hvc = [[ParameterSetViewController alloc] init];
            UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:hvc];
            [self presentViewController:nvc animated:YES completion:nil];
        }
        if(indexPath.row == 1)
        {
            BuyViewController * hvc = [[BuyViewController alloc] init];
            UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:hvc];
            [self presentViewController:nvc animated:YES completion:nil];
        }
    }
    if(indexPath.section == 3)
    {
        PersonSetViewController * hvc = [[PersonSetViewController alloc] init];
        UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:hvc];
        [self presentViewController:nvc animated:YES completion:nil];
    }
}

-(void)inputText:(NSString *)text
{
    if(text.length)
    {
        nickname = text;
    }
    [_mainTableView reloadData];
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
