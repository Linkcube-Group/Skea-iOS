//
//  SelectLevelViewController.m
//  Skea
//
//  Created by yuyang on 14/11/13.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "SelectLevelViewController.h"

@interface SelectLevelViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SelectLevelViewController
{
    NSMutableArray * _selectArray;
    NSMutableArray * _nameArray;
    NSMutableArray * _recommendArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _selectArray = [NSMutableArray arrayWithObjects:@"1",@"0",@"0",@"0", nil];
    _nameArray = [NSMutableArray arrayWithObjects:@"Level 1",@"Level 2",@"Level 3",@"Level 4", nil];
    _recommendArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];
    NSLog(@"%ld",[SkeaUser defaultUser].level);
    if([SkeaUser defaultUser].level > 0)
    {
        [_recommendArray replaceObjectAtIndex:([SkeaUser defaultUser].level - 1) withObject:@"1"];
        _selectArray = _recommendArray;
    }
    
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:@"Exercise Strength"];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"menu_action_back_white.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    self.view.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 260 - 64 - 40) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    [self.view addSubview:tableView];
    [tableView reloadData];
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
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    if([[_selectArray objectAtIndex:indexPath.row] integerValue] == 1)
    {
        cell.imageView.image = [UIImage imageNamed:@"selection-checked-small.png"];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"selection-unchecked-small.png"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",[_nameArray objectAtIndex:indexPath.row],[[_recommendArray objectAtIndex:indexPath.row]integerValue]?@"(Recommended)":@""];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0", nil];
    [_selectArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
    [SkeaUser defaultUser].selectLevel = indexPath.row + 1;
    [AppConfig setGameLevel:(int)indexPath.row + 1];
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
