//
//  HealthTestViewController.m
//  Skea
//
//  Created by yuyang on 14/10/30.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "HealthTestViewController.h"
#import "SelectLevelViewController.h"
#import "TestingViewController1.h"
#import "SkeaUser.h"

@interface HealthTestViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>

@end

@implementation HealthTestViewController
{
    UITableView * _tableView;
    UIImageView * _imageView;
    NSArray * _sugArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.view.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.f];
    _sugArray = @[@"您的盆底肌并无太大风险，请继续保持！",@"您的盆地肌基本健康，不过依然建议您多多锻炼。",@"您的盆底肌需要多多锻炼哦，建议您选择Level3锻炼等级，坚持锻炼哦！",@"您的盆底肌健康面临着很大风险，请遵医嘱进行盆底肌锻炼，每天至少30分钟。"];
    UIView * navigationView = [[UIView alloc] init];
    navigationView.frame = CGRectMake(0, 0, ScreenWidth, 64);
    navigationView.backgroundColor = [UIColor colorWithRed:59/255.f green:60/255.f blue:65/255.f alpha:1.f];
    [self.view addSubview:navigationView];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:IMG(@"menu_action_back_white.png") forState:UIControlStateNormal];
    btn.tag = 200;
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font=[Theam currentTheam].navigationBarItemFont;
    [btn setTitleColor:[Theam currentTheam].navigationBarItemTitleColor forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    btn.frame=CGRectMake(14, 38, 20, 20);
    
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
    [navigationView addSubview:btn];
    
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:NSLocalizedString(@"测试结果", nil)];
//    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"menu_action_back_white.png") Title:nil Target:self Selector:@selector(back)];
    self.view.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 400 - 20 - 40) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    UIButton * AgainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    AgainButton.frame = CGRectMake(10,self.view.frame.size.height - 64 - 20,self.view.frame.size.width - 20,44);
    //    AgainButton.layer.borderWidth = 0.5f;
    //    AgainButton.layer.borderColor = [UIColor blackColor].CGColor;
    [AgainButton setBackgroundImage:[UIImage imageNamed:@"button-cyan.png"] forState:UIControlStateNormal];
    AgainButton.layer.cornerRadius = 20.f;
    [AgainButton setTitle:NSLocalizedString(@"Re-evaluate", nil) forState:UIControlStateNormal];
    [AgainButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [AgainButton addTarget:self action:@selector(again) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:AgainButton];
    
}

-(void)back
{
    if(self.isRegister)
    {
        AppDelegate *delegate=[[UIApplication sharedApplication] delegate];
        [delegate reloadApp];
        return;
    }
    [self btBack_DisModal:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView reloadData];
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
        return 140;
    if(indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 4)
        return 40.f;
    if(indexPath.row == 2)
        return 80.f;
    return 100.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [NSString stringWithFormat:@"cell_%ld",(long)indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    cell.contentView.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    if(indexPath.row == 0)
    {
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(20, 50, 150, 20);
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14.f];
        label.text = @"Pelvic floor muscle";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 2;
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.f];
        [cell.contentView addSubview:label];
        
        UILabel * label1 = [[UILabel alloc] init];
        label1.frame = CGRectMake(20, label.frame.origin.y + label.frame.size.height, 150, 20);
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:14.f];
        label1.text = @"Risk Factor";
        label1.textColor = [UIColor whiteColor];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.numberOfLines = 2;
        cell.contentView.backgroundColor = [UIColor colorWithRed:59/255.f green:60/255.f blue:65/255.f alpha:1.f];
        cell.backgroundColor = [UIColor colorWithRed:59/255.f green:60/255.f blue:65/255.f alpha:1.f];
        [cell.contentView addSubview:label1];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(self.view.frame.size.width - 80 - 10 - 30, 20, 100, 100);
        [cell.contentView addSubview:_imageView];
        _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"level%ld",[SkeaUser defaultUser].level]];
        
    }
    
    if(indexPath.row == 1)
    {
        [cell.contentView addSubview:[self createTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.f) title:NSLocalizedString(@"建议", nil)]];
    }
    if(indexPath.row == 3)
    {
        [cell.contentView addSubview:[self createTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.f) title:NSLocalizedString(@"强度", nil)]];
    }
    if(indexPath.row == 4)
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.text = [NSString stringWithFormat:@"Level %ld",[SkeaUser defaultUser].selectLevel?[SkeaUser defaultUser].selectLevel:[SkeaUser defaultUser].level];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if(indexPath.row == 2)
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(20, 0, self.view.frame.size.width - 20 - 20, 80);
//        label.text = @"UILabel * textlabel = [[UILabel allocinitWithFrame:CGRectMake(0, 0, 80, 80)];textlabel.backgroundColor = [UIColor clearColor];textlabel.text = ;textlabel.textColor = [UIColor blueColor];textlabel.textAlignment = NSTextAlignmentCenter;textlabel.font = [UIFont boldSystemFontOfSize:28.f];[view addSubview:textlabel];";
        label.text = [SkeaUser defaultUser].level>0?[_sugArray objectAtIndex:[SkeaUser defaultUser].level - 1]:[_sugArray firstObject];
        label.font = [UIFont systemFontOfSize:12.f];
        label.numberOfLines = 10;
        [cell.contentView addSubview:label];
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

-(void)again
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"\n是否重新测试？您之前的评估结果将不会被保留！", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"取消",nil) otherButtonTitles:NSLocalizedString(@"确定", nil), nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        TestingViewController1 * tvc = [[TestingViewController1 alloc] init];
        tvc._isRegisterPush = NO;
        UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:tvc];
        [self presentViewController:nvc animated:YES completion:nil];
    }
}

-(UIImageView *)createTitleViewWithFrame:(CGRect)rect title:(NSString *)title
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = [UIImage imageNamed:@"title-background.png"];
    UILabel * label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.frame = CGRectMake(20, 0, imageView.frame.size.width - 20, imageView.frame.size.height);
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.text = title.length?title:@"";
    [imageView addSubview:label];
    return imageView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 4)
    {
        SelectLevelViewController * hvc = [[SelectLevelViewController alloc] init];
        UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:hvc];
        [self presentViewController:nvc animated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning
{
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
