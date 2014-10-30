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

@interface PersonLoginedViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation PersonLoginedViewController
{
    UIImageView * photoImageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:nil];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"back-cross.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    self.view.backgroundColor = [UIColor whiteColor];
    photoImageView = [[UIImageView alloc] init];
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
    return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 150.f;
    if(indexPath.row == 6)
        return 200.f;
    return 40.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [NSString stringWithFormat:@"cell_%ld",(long)indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    if(indexPath.row == 0)
    {
        photoImageView.frame = CGRectMake(80 + 40, 20, 80, 80);
        photoImageView.layer.cornerRadius = 40.f;
        photoImageView.layer.masksToBounds = YES;
        photoImageView.image = [UIImage imageNamed:@"icon-info.png"];
        photoImageView.userInteractionEnabled = YES;
        [cell.contentView addSubview:photoImageView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 80, 80);
        btn.layer.cornerRadius = 40.f;
        [btn addTarget:self action:@selector(photoSelect) forControlEvents:UIControlEventTouchUpInside];
        [photoImageView addSubview:btn];
        
        UILabel * notiLabel = [[UILabel alloc] init];
        notiLabel.backgroundColor = [UIColor clearColor];
        notiLabel.frame = CGRectMake(photoImageView.frame.origin.x, photoImageView.frame.origin.y + photoImageView.frame.size.height + 8, photoImageView.frame.size.width, 20);
        notiLabel.font = [UIFont systemFontOfSize:13.f];
        notiLabel.text = NSLocalizedString(@"MarryMe", nil);
        notiLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:notiLabel];
    }
    if(indexPath.row == 1)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = [UIImage imageNamed:@"settings-settings.png"];
        cell.textLabel.text = NSLocalizedString(@"盆底肌健康测试", nil);
    }
    else if (indexPath.row == 2)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = [UIImage imageNamed:@"settings-settings.png"];
        cell.textLabel.text = NSLocalizedString(@"Skea参数设置", nil);
    }
    else if (indexPath.row == 3)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = [UIImage imageNamed:@"settings-settings.png"];
        cell.textLabel.text = NSLocalizedString(@"购买Skea产品", nil);
    }
    else if (indexPath.row == 4)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.imageView.image = nil;
        cell.textLabel.text = @"";
    }
    else if (indexPath.row == 5)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = [UIImage imageNamed:@"settings-settings.png"];
        cell.textLabel.text = NSLocalizedString(@"设置", nil);
    }
    else if (indexPath.row == 6)
    {
        UIButton * LogoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        LogoutButton.frame = CGRectMake(50,150,self.view.frame.size.width - 100,40);
        LogoutButton.layer.borderWidth = 0.5f;
        LogoutButton.layer.borderColor = [UIColor blackColor].CGColor;
        LogoutButton.layer.cornerRadius = 20.f;
        [LogoutButton setTitle:NSLocalizedString(@"退出登录", nil) forState:UIControlStateNormal];
        [LogoutButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [LogoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:LogoutButton];
    }
    return cell;
}

-(void)logout
{
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
    if(indexPath.row == 1)
    {
        HealthTestViewController * hvc = [[HealthTestViewController alloc] init];
        UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:hvc];
        [self presentViewController:nvc animated:YES completion:nil];
    }
    if(indexPath.row == 0)
    {
        PersonSetViewController * hvc = [[PersonSetViewController alloc] init];
        UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:hvc];
        [self presentViewController:nvc animated:YES completion:nil];
    }
    if(indexPath.row == 5)
    {
        ParameterSetViewController * hvc = [[ParameterSetViewController alloc] init];
        UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:hvc];
        [self presentViewController:nvc animated:YES completion:nil];
    }
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
