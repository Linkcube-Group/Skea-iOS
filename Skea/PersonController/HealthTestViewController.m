//
//  HealthTestViewController.m
//  Skea
//
//  Created by yuyang on 14/10/30.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "HealthTestViewController.h"

@interface HealthTestViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation HealthTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:nil];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"back-cross.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 424) style:UITableViewStylePlain];
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
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 100;
    if(indexPath.row == 1)
        return 80.f;
    if(indexPath.row == 2 || indexPath.row == 3)
        return 40.f;
    return 100.f;
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
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(20, 30, 150, 60);
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14.f];
        label.text = @"Pelvic floor muscle Risk Factor";
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 2;
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.f];
        [cell.contentView addSubview:label];
        
        UIView * view = [[UIView alloc] init];
        view.frame = CGRectMake(self.view.frame.size.width - 80 - 10, 10, 80, 80);
        view.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.f];;
        view.layer.cornerRadius = 40.f;
        view.layer.borderColor = [UIColor whiteColor].CGColor;
        view.layer.borderWidth = 0.5f;
        [cell.contentView addSubview:view];
        
        UILabel * textlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        textlabel.backgroundColor = [UIColor clearColor];
        textlabel.text = @"Low";
        textlabel.textColor = [UIColor blueColor];
        textlabel.textAlignment = NSTextAlignmentCenter;
        textlabel.font = [UIFont boldSystemFontOfSize:28.f];
        [view addSubview:textlabel];
    }
    
    if(indexPath.row == 1)
    {
        UILabel * sugLabel = [[UILabel alloc] init];
        sugLabel.frame = CGRectMake(20, 0, 50, 30);
        sugLabel.text = @"Sug.";
        sugLabel.textColor = [UIColor blueColor];
        sugLabel.font = [UIFont boldSystemFontOfSize:20.f];
        [cell.contentView addSubview:sugLabel];
        
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(80, 0, self.view.frame.size.width - 80 - 20, 80);
        label.text = @"UILabel * textlabel = [[UILabel allocinitWithFrame:CGRectMake(0, 0, 80, 80)];textlabel.backgroundColor = [UIColor clearColor];textlabel.text = ;textlabel.textColor = [UIColor blueColor];textlabel.textAlignment = NSTextAlignmentCenter;textlabel.font = [UIFont boldSystemFontOfSize:28.f];[view addSubview:textlabel];";
        label.font = [UIFont systemFontOfSize:12.f];
        label.numberOfLines = 10;
        [cell.contentView addSubview:label];
        
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.f];
    }
    if(indexPath.row == 2)
    {
        UILabel * sportLabel = [[UILabel alloc] init];
        sportLabel.frame = CGRectMake(20, 0, 70, 30);
        sportLabel.text = @"Sport";
        sportLabel.textColor = [UIColor blueColor];
        sportLabel.font = [UIFont boldSystemFontOfSize:20.f];
        [cell.contentView addSubview:sportLabel];
        
        
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(100, 5, 120, 30);
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:12.f];
        
        UITextField * textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(220, 5, self.view.frame.size.width - 220 - 20 - 20, 30);
        textField.font = [UIFont systemFontOfSize:12.f];
        textField.textAlignment=NSTextAlignmentRight;
        textField.delegate = self;
        textField.returnKeyType = UIReturnKeyDone;
        
        label.text = NSLocalizedString(@"Recommended Exercise", nil);
        textField.text = @"Level 4";
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:textField];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    if(indexPath.row == 3)
    {
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(100, 5, 120, 30);
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:12.f];
        
        UITextField * textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(220, 5, self.view.frame.size.width - 220 - 20 - 20, 30);
        textField.font = [UIFont systemFontOfSize:12.f];
        textField.textAlignment=NSTextAlignmentRight;
        textField.delegate = self;
        textField.returnKeyType = UIReturnKeyDone;
        
        label.text = NSLocalizedString(@"Exercise Cycle", nil);
        textField.text = @"30 Days";
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:textField];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(indexPath.row == 4)
    {
        UIButton * AgainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        AgainButton.frame = CGRectMake(50,50,self.view.frame.size.width - 100,40);
        AgainButton.layer.borderWidth = 0.5f;
        AgainButton.layer.borderColor = [UIColor blackColor].CGColor;
        AgainButton.layer.cornerRadius = 20.f;
        [AgainButton setTitle:NSLocalizedString(@"Test Again", nil) forState:UIControlStateNormal];
        [AgainButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [AgainButton addTarget:self action:@selector(again) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:AgainButton];
    }
    return cell;
}

-(void)again
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"重新计算锻炼数据，还是把已有锻炼数据累加计算？", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"已有累加",nil) otherButtonTitles:NSLocalizedString(@"重新计算", nil), nil];
    [alert show];
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
