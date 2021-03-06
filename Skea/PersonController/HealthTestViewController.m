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
    _sugArray = @[NSLocalizedString(@"恭喜您，您的盆底肌面临的健康防线较低。不过，多做凯格尔运动仍然能进一步增强您的盆底健康！", nil),NSLocalizedString(@"您的盆底肌面临的健康风险一般，经常做凯格尔运动，会增强您的盆底健康。",nil),NSLocalizedString(@"您的盆底肌健康面临着很大风险，需要多多做凯格尔运动，能有效增进盆底健康哦，坚持每天锻炼吧！",nil),NSLocalizedString(@"您的盆底肌健康面临着很大风险，建议每天进行30分钟的凯格尔锻炼来增强盆底健康。建议咨询医生以获得更多的专业建议。",nil)];
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
    btn.frame=CGRectMake(16, 32, 20, 20);
    
    /*  really don't understand!!!!!!!!!
    //让图片在最右侧对齐
    
    CGSize imagesize=IMG(@"back-cross.png").size;
    imagesize.width=imagesize.width/2;
    imagesize.height=imagesize.height/2;
    CGSize btnsize=btn.size;
    
    //iOS7下面导航按钮会默认有10px间距
    UIEdgeInsets insets=UIEdgeInsetsMake((btnsize.height-imagesize.height)/2, btnsize.width-imagesize.width, (btnsize.height-imagesize.height)/2, 0);
    [btn setImageEdgeInsets:insets];
    btn.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    */
     
     
    if (DeviceSystemSmallerThan(7.0)) {
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
    [navigationView addSubview:btn];
    
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:NSLocalizedString(@"测试结果", nil)];
//    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"menu_action_back_white.png") Title:nil Target:self Selector:@selector(back)];
    self.view.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 415 - 20 - 40 - 10) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    
    _tableView.backgroundColor = [UIColor colorWithRed:59/255.f green:60/255.f blue:65/255.f alpha:1.f];
    
    _tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    UIButton * AgainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    AgainButton.frame = CGRectMake(10,self.view.frame.size.height - 64 - 20,self.view.frame.size.width - 20,44);
    //    AgainButton.layer.borderWidth = 0.5f;
    //    AgainButton.layer.borderColor = [UIColor blackColor].CGColor;
    [AgainButton setBackgroundImage:[UIImage imageNamed:@"button-cyan.png"] forState:UIControlStateNormal];
    [AgainButton setBackgroundImage:[UIImage imageNamed:@"loginButtonBg.png"] forState:UIControlStateHighlighted];

    AgainButton.layer.cornerRadius = 20.f;
    [AgainButton setTitle:NSLocalizedString(@"重新测试", nil) forState:UIControlStateNormal];
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
        return 85.f;
    return 100.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [NSString stringWithFormat:@"cell_%ld",(long)indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell || 1)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        //[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
        cell.contentView.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if(indexPath.row == 0)
    {
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(20, 50, 150, 40);
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14.f];
        label.text = NSLocalizedString(@"盆底肌健康风险", nil);
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 2;
        cell.contentView.backgroundColor = [UIColor colorWithRed:59/255.f green:60/255.f blue:65/255.f alpha:1.f];
        [cell.contentView addSubview:label];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
//        UILabel * label1 = [[UILabel alloc] init];
//        label1.frame = CGRectMake(20, label.frame.origin.y + label.frame.size.height, 150, 20);
//        label1.backgroundColor = [UIColor clearColor];
//        label1.font = [UIFont systemFontOfSize:14.f];
//        label1.text = @"Risk Factor";
//        label1.textColor = [UIColor whiteColor];
//        label1.textAlignment = NSTextAlignmentCenter;
//        label1.numberOfLines = 2;
//        cell.contentView.backgroundColor = [UIColor colorWithRed:59/255.f green:60/255.f blue:65/255.f alpha:1.f];
//        cell.backgroundColor = [UIColor colorWithRed:59/255.f green:60/255.f blue:65/255.f alpha:1.f];
//        [cell.contentView addSubview:label1];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(self.view.frame.size.width - 80 - 10 - 30, 20, 100, 100);
        [cell.contentView addSubview:_imageView];
        
        if([SkeaUser defaultUser].level != 0)
        {
            _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"level%ld",[SkeaUser defaultUser].level]];
        }
        else
        {
            _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"level%d",1]];
        }
        
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
        NSInteger tempLevel = [SkeaUser defaultUser].selectLevel ? [SkeaUser defaultUser].selectLevel : [SkeaUser defaultUser].level;
        switch (tempLevel) {
            case 1:
                cell.textLabel.text = NSLocalizedString(@" 简单",nil);
                break;
            case 2:
                cell.textLabel.text = NSLocalizedString(@" 普通",nil);
                break;
            case 3:
                cell.textLabel.text = NSLocalizedString(@" 困难",nil);
                break;
            case 4:
                cell.textLabel.text = NSLocalizedString(@" 超难",nil);
                break;
            default:
                cell.textLabel.text = NSLocalizedString(@" 简单",nil);
                break;
        }
        //cell.textLabel.text = _S(@"%@%@",NSLocalizedString(@"等级", nil),[NSString stringWithFormat:@" %ld",[SkeaUser defaultUser].selectLevel?[SkeaUser defaultUser].selectLevel:[SkeaUser defaultUser].level]);
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if(indexPath.row == 2)
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(20, 0, self.view.frame.size.width - 20 - 20, 85);
//        label.text = @"UILabel * textlabel = [[UILabel allocinitWithFrame:CGRectMake(0, 0, 80, 80)];textlabel.backgroundColor = [UIColor clearColor];textlabel.text = ;textlabel.textColor = [UIColor blueColor];textlabel.textAlignment = NSTextAlignmentCenter;textlabel.font = [UIFont boldSystemFontOfSize:28.f];[view addSubview:textlabel];";
        label.text = [SkeaUser defaultUser].level>0?[_sugArray objectAtIndex:[SkeaUser defaultUser].level - 1]:[_sugArray firstObject];
        label.font = [UIFont systemFontOfSize:12.f];
        label.numberOfLines = 10;
        [cell.contentView addSubview:label];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
