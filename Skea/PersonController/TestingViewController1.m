//
//  TestingViewController1.m
//  Skea
//
//  Created by yuyang on 14/11/15.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "TestingViewController1.h"
#import "SkeaSliderButtonView.h"

@interface TestingViewController1 ()<UITableViewDelegate,UITableViewDataSource,SkeaSliderButtonViewDelegate>

@end

@implementation TestingViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:@"Risk Evaluation"];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"back-cross.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    
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
    return 11;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 60.f;
    if(indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5)
        return 60.f;
    if(indexPath.row == 6 || indexPath.row == 9)
        return 70.f;
    if(indexPath.row == 7 || indexPath.row == 8)
        return 110;
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
        cell.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
        cell.contentView.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    }
    if(indexPath.row == 0)
    {
        SkeaSliderButtonView * sview = [[SkeaSliderButtonView alloc] init];
        sview.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
        sview.tager = indexPath.row;
        sview.title = @"title";
        sview.selectedStringsArray = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
        sview.selectedIndex = 1;
        sview.delegate = self;
        [cell.contentView addSubview:sview];
    }
    if(indexPath.row == 1)
    {
        SkeaSliderButtonView * sview = [[SkeaSliderButtonView alloc] init];
        sview.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
        sview.tager = indexPath.row;
        sview.title = @"title";
        sview.selectedStringsArray = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
        sview.selectedIndex = 1;
        sview.delegate = self;
        [cell.contentView addSubview:sview];
    }
    return cell;
}

-(void)sliderClickWithTag:(NSInteger)tag index:(NSInteger)index
{
    NSLog(@"第%ld行，第%ld个按钮",tag,index);
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
