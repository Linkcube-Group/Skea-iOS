//
//  LanguageViewController.m
//  Skea
//
//  Created by yuyang on 14/11/20.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "LanguageViewController.h"

@interface LanguageViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LanguageViewController
{
    BOOL _isEnglish;
    NSMutableArray * _selectArray;
    NSMutableArray * _nameArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if([SkeaLanguage defaultCenter].languageType == SkeaLanguageTypeEN)
        _selectArray = [NSMutableArray arrayWithObjects:@"0",@"1", nil];
    else
        _selectArray = [NSMutableArray arrayWithObjects:@"1",@"0", nil];
    _nameArray = [NSMutableArray arrayWithObjects:@"   简体中文",@"   English", nil];
    
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:NSLocalizedString(@"语言", nil)];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"menu_action_back_white.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
//    self.navigationItem.rightBarButtonItem = [[Theam currentTheam] navigationBarRightButtonItemWithImage:nil Title:NSLocalizedString(@"保存", nil) Target:nil Selector:@selector(Done)];
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:NSLocalizedString(@"保存", nil) forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(Done) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 0, 50, 55);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.navigationController.navigationBar addSubview:rightBtn];
    self.view.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, ScreenWidth, 80) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:tableView];
}

-(void)Done
{
    [SkeaLanguage defaultCenter].languageType = _isEnglish?SkeaLanguageTypeEN:SkeaLanguageTypeZH;
    AppDelegate *delegate=[[UIApplication sharedApplication] delegate];
    [delegate reloadApp];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [NSString stringWithFormat:@"cell_%ld",(long)indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if([[_selectArray objectAtIndex:indexPath.row] integerValue] == 1)
    {
        cell.imageView.image = [UIImage imageNamed:@"selection-checked-small.png"];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"selection-unchecked-small.png"];
    }
    cell.textLabel.text = [_nameArray objectAtIndex:indexPath.row];
    UIView * line = [[UIView alloc] init];
    line.frame = CGRectMake(40, 39.5, ScreenWidth - 40, 0.5);
    line.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.f];
    [cell.contentView addSubview:line];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 1)
    {
        _isEnglish = YES;
        _selectArray = [NSMutableArray arrayWithObjects:@"0",@"1", nil];
    }
    else
    {
        _isEnglish = NO;
        _selectArray = [NSMutableArray arrayWithObjects:@"1",@"0", nil];
    }
    [tableView reloadData];
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
