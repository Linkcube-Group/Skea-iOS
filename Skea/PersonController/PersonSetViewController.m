//
//  PersonSetViewController.m
//  Skea
//
//  Created by yuyang on 14/10/30.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "PersonSetViewController.h"

@interface PersonSetViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>

@end

@implementation PersonSetViewController
{
    UIImageView * photoImageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:NSLocalizedString(@"设置", nil)];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"menu_action_back_white.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
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
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 100;
    if(indexPath.row == 1 || indexPath.row == 2)
        return 40.f;
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
    cell.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    cell.contentView.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    if(indexPath.row == 0)
    {
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(20, 35, self.view.frame.size.width - 20 - 90 - 10, 30);
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"头像",nil);
        [cell.contentView addSubview:label];
        
        photoImageView.frame = CGRectMake(self.view.frame.size.width - 90, 10, 80, 80);
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
    }
    if(indexPath.row == 2)
    {
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(20, 5, 60, 30);
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14.f];
        
        UITextField * textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(80, 5, self.view.frame.size.width - 80 - 20 - 20, 30);
        textField.font = [UIFont systemFontOfSize:14.f];
        textField.textAlignment=NSTextAlignmentRight;
        textField.delegate = self;
        textField.returnKeyType = UIReturnKeyDone;
        
        label.text = NSLocalizedString(@"昵称", nil);
        textField.text = @"MerryMe";
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:textField];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
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
