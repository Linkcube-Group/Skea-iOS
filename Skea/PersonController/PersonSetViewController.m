//
//  PersonSetViewController.m
//  Skea
//
//  Created by yuyang on 14/10/30.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "PersonSetViewController.h"
#import "LanguageViewController.h"

@interface PersonSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PersonSetViewController
{
    UIImageView * photoImageView;
    NSArray * dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.f];
    dataArray = [NSArray arrayWithObjects:@"",NSLocalizedString(@"语言", nil),@"",NSLocalizedString(@"版本", nil),NSLocalizedString(@"反馈", nil),NSLocalizedString(@"关于我们", nil), nil];
    
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:NSLocalizedString(@"设置", nil)];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"menu_action_back_white.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
//    self.view.backgroundColor = [UIColor whiteColor];
    photoImageView = [[UIImageView alloc] init];
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height - 300 - 50) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorColor  = [UIColor clearColor];
    tableView.scrollEnabled = NO;
    [self.view addSubview:tableView];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 20;
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
    cell.textLabel.text = [NSString stringWithFormat:@"    %@",[dataArray objectAtIndex:indexPath.row]];
    if(indexPath.row == 0 || indexPath.row == 2)
    {
        cell.contentView.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.f];
        cell.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.f];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    UIView * line = [[UIView alloc] init];
    line.frame = CGRectMake(40, indexPath.row?39.5:19.5, ScreenWidth - 40, 0.5);
    line.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.f];
    [cell.contentView addSubview:line];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 1)
    {
        LanguageViewController * lvc = [[LanguageViewController alloc] init];
        UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:lvc];
        [self presentViewController:nvc animated:YES completion:nil];
    }
    if(indexPath.row == 3)
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"已是最新版本" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
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
