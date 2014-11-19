//
//  HealthTestViewController.m
//  Skea
//
//  Created by yuyang on 14/10/30.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "HealthTestViewController.h"
#import "SelectLevelViewController.h"

@interface HealthTestViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation HealthTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:NSLocalizedString(@"测试结果", nil)];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"menu_action_back_white.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    self.view.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 400) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    [self.view addSubview:tableView];
    
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
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.f];
        [cell.contentView addSubview:label1];
        
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(self.view.frame.size.width - 80 - 10 - 30, 20, 100, 100);
        imageView.image = [UIImage imageNamed:@"risk-factor-low.png"];
        [cell.contentView addSubview:imageView];
        
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
        cell.textLabel.text = NSLocalizedString(@"Level 4", nil);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if(indexPath.row == 2)
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(20, 0, self.view.frame.size.width - 20 - 20, 80);
        label.text = @"UILabel * textlabel = [[UILabel allocinitWithFrame:CGRectMake(0, 0, 80, 80)];textlabel.backgroundColor = [UIColor clearColor];textlabel.text = ;textlabel.textColor = [UIColor blueColor];textlabel.textAlignment = NSTextAlignmentCenter;textlabel.font = [UIFont boldSystemFontOfSize:28.f];[view addSubview:textlabel];";
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
#warning 点击确定到问卷界面
    [alert show];
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
