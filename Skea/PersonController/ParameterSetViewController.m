//
//  ParameterSetViewController.m
//  Skea
//
//  Created by yuyang on 14/10/30.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "ParameterSetViewController.h"

@interface ParameterSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ParameterSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:@"Skea参数设置"];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"back-cross.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 224) style:UITableViewStylePlain];
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
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        cell.textLabel.text = NSLocalizedString(@"压力敏感度", nil);
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    }
    else if(indexPath.row == 2)
    {
        cell.textLabel.text = NSLocalizedString(@"反馈震动强度", nil);
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    }
    else
    {
        UISlider * slider = [[UISlider alloc] init];
        slider.frame = CGRectMake(20, 5, self.view.frame.size.width - 40, 30);
        [cell.contentView addSubview:slider];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
