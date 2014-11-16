//
//  PersonViewController.m
//  Skea
//  个人界面
//  Created by mosn on 10/7/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "PersonViewController.h"
#import "TestingViewController.h"

@interface PersonViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation PersonViewController
{
    UITextField * _nickNameTextField;
    UIImageView * photoImageView;
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
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:NSLocalizedString(@"填写资料", nil)];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"back-cross.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height) style:UITableViewStylePlain];
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
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 240.f;
    if(indexPath.row == 1)
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
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
        cell.contentView.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    }
    if(indexPath.row == 0)
    {
        UIView * lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(0, 20, self.view.frame.size.width, 3);
        lineView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.f];
        [cell.contentView addSubview:lineView];
        
        UILabel * roundLabel = [[UILabel alloc] init];
        roundLabel.frame = CGRectMake(40, -7.5, 15, 15);
        roundLabel.backgroundColor = [UIColor colorWithRed:103/255.f green:201/255.f blue:224/255.f alpha:1.f];
        roundLabel.text = @"1";
        roundLabel.font = [UIFont systemFontOfSize:13];
        roundLabel.layer.cornerRadius = 7.5;
        roundLabel.layer.masksToBounds = YES;
        roundLabel.textColor = [UIColor whiteColor];
        roundLabel.textAlignment = NSTextAlignmentCenter;
        [lineView addSubview:roundLabel];
        
        UILabel * roundLabel2 = [[UILabel alloc] init];
        roundLabel2.frame = CGRectMake(self.view.frame.size.width - 43, -7.5, 15, 15);
        roundLabel2.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.f];
        roundLabel2.text = @"2";
        roundLabel2.font = [UIFont systemFontOfSize:13];
        roundLabel2.layer.cornerRadius = 7.5;
        roundLabel2.layer.masksToBounds = YES;
        roundLabel2.textColor = [UIColor whiteColor];
        roundLabel2.textAlignment = NSTextAlignmentCenter;
        [lineView addSubview:roundLabel2];
        
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(30, lineView.frame.origin.y + lineView.frame.size.height + 8, 60, 20);
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:103/255.f green:201/255.f blue:224/255.f alpha:1.f];
        label.font = [UIFont systemFontOfSize:13];
        label.text = NSLocalizedString(@"填写资料", nil);
        [cell.contentView addSubview:label];
        
        UILabel * noticeLabel = [[UILabel alloc] init];
        noticeLabel.frame = CGRectMake(0, label.frame.origin.y + label.frame.size.height + 10, self.view.frame.size.width, 30);
        noticeLabel.text = NSLocalizedString(@"恭喜你注册成功!请填写资料", nil);
        noticeLabel.font = [UIFont systemFontOfSize:13];
        noticeLabel.backgroundColor = [UIColor clearColor];
        noticeLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:noticeLabel];
        
        photoImageView = [[UIImageView alloc] init];
        photoImageView.frame = CGRectMake(80 + 40, noticeLabel.frame.origin.y + noticeLabel.frame.size.height + 8, 80, 80);
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
        notiLabel.frame = CGRectMake(photoImageView.frame.origin.x, photoImageView.frame.origin.y + photoImageView.frame.size.height + 8, photoImageView.frame.size.width - 20, 20);
        notiLabel.font = [UIFont systemFontOfSize:13.f];
        notiLabel.text = NSLocalizedString(@"上传头像", nil);
        [cell.contentView addSubview:notiLabel];
        
    }
    else if (indexPath.row == 1)
    {
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(40, 5, 50, 30);
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"昵称", nil);
        [cell.contentView addSubview:label];
        
        _nickNameTextField = [[UITextField alloc] init];
        _nickNameTextField.frame = CGRectMake(label.frame.size.width + label.frame.origin.x, 5, self.view.frame.size.width - label.frame.origin.x - label.frame.size.width, 30);
        _nickNameTextField.delegate = self;
        _nickNameTextField.placeholder = NSLocalizedString(@"请输入昵称", nil);
        _nickNameTextField.returnKeyType = UIReturnKeyDone;
        [cell.contentView addSubview:_nickNameTextField];
    }
    else
    {
        UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(40, 100, 40, 30);
        [leftButton setTitle:NSLocalizedString(@"退出", nil) forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:leftButton];
        
        UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(self.view.frame.size.width - 40 - 40, 100, 40, 30);
        [rightButton setTitle:NSLocalizedString(@"提交", nil) forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:rightButton];
        
        
    }
    return cell;
}

-(void)back
{
    [self btBack_DisModal:nil];
}

-(void)submit
{
    TestingViewController * tvc = [[TestingViewController alloc] init];
    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:tvc];
    [self presentViewController:nvc animated:YES completion:nil];
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
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_nickNameTextField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
