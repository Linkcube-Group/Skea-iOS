//
//  TestingViewController.m
//  Skea
//   盆底肌健康测试
//  Created by mosn on 10/7/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "TestingViewController.h"
#import "PersonLoginedViewController.h"

@interface TestingViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation TestingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:nil];
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
    return 9;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 60.f;
    if(indexPath.row == 1)
        return 60.f;
    if(indexPath.row == 2 || indexPath.row == 6)
        return 40.f;
    if(indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5)
        return 40.f;
    if(indexPath.row == 7)
        return 100.f;
    return 60.f;
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
    if(indexPath.row == 0)
    {
        UIView * lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(0, 20, self.view.frame.size.width, 3);
        lineView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.f];
        [cell.contentView addSubview:lineView];
        
        UILabel * roundLabel = [[UILabel alloc] init];
        roundLabel.frame = CGRectMake(40, -7.5, 15, 15);
        roundLabel.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.f];
        roundLabel.text = @"1";
        roundLabel.font = [UIFont systemFontOfSize:13];
        roundLabel.layer.cornerRadius = 7.5;
        roundLabel.layer.masksToBounds = YES;
        roundLabel.textColor = [UIColor whiteColor];
        roundLabel.textAlignment = NSTextAlignmentCenter;
        [lineView addSubview:roundLabel];
        
        UILabel * roundLabel2 = [[UILabel alloc] init];
        roundLabel2.frame = CGRectMake(self.view.frame.size.width - 43, -7.5, 15, 15);
        roundLabel2.backgroundColor = [UIColor blueColor];
        roundLabel2.text = @"2";
        roundLabel2.font = [UIFont systemFontOfSize:13];
        roundLabel2.layer.cornerRadius = 7.5;
        roundLabel2.layer.masksToBounds = YES;
        roundLabel2.textColor = [UIColor whiteColor];
        roundLabel2.textAlignment = NSTextAlignmentCenter;
        [lineView addSubview:roundLabel2];
        
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(self.view.frame.size.width - 80, lineView.frame.origin.y + lineView.frame.size.height + 8, 70, 20);
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blueColor];
        label.font = [UIFont systemFontOfSize:13];
        label.text = NSLocalizedString(@"盆底肌测试", nil);
        [cell.contentView addSubview:label];

    }
    else if (indexPath.row == 1)
    {
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(20, 0, self.view.frame.size.width - 40, 60.f);
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"请填写如下信息，有助于我们帮主您评估盆底肌健康状况", nil);
        label.textColor = [UIColor blueColor];
        label.numberOfLines = 2;
        label.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:label];
    }
    else if (indexPath.row == 2)
    {
        [cell.contentView addSubview:[self getTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40) title:@"基础数据"]];
    }
    else if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5)
    {
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(20, 5, 60, 30);
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14.f];
        
        UITextField * textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(80, 5, self.view.frame.size.width - 80 - 20, 30);
        textField.font = [UIFont systemFontOfSize:14.f];
        textField.textAlignment=NSTextAlignmentRight;
        textField.delegate = self;
        textField.returnKeyType = UIReturnKeyDone;
        
        if(indexPath.row == 3)
        {
            label.text = NSLocalizedString(@"出生日期", nil);
            textField.text = NSLocalizedString(@"1980年1月1日", nil);
        }
        else if (indexPath.row == 4)
        {
            label.text = NSLocalizedString(@"身高", nil);
            textField.text = NSLocalizedString(@"155cm", nil);
        }
        else if (indexPath.row == 5)
        {
            label.text = NSLocalizedString(@"体重", nil);
            textField.text = NSLocalizedString(@"55kg", nil);
        }
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:textField];
    }
    else if (indexPath.row == 6)
    {
        [cell.contentView addSubview:[self getTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40) title:@"私密信息部分"]];
    }
    else if (indexPath.row ==7)
    {
        [cell.contentView addSubview:[self getSelectViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100) title:NSLocalizedString(@"生育经历", nil) titleArray:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@">5", nil] tag:indexPath.row]];
    }
    else
    {
        UIButton * submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        submitButton.frame = CGRectMake(50,10,self.view.frame.size.width - 100,40);
        submitButton.layer.borderWidth = 0.5f;
        submitButton.layer.borderColor = [UIColor blackColor].CGColor;
        submitButton.layer.cornerRadius = 20.f;
        [submitButton setTitle:NSLocalizedString(@"提交", nil) forState:UIControlStateNormal];
        [submitButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:submitButton];
    }
    return cell;
}

-(void)submit
{
//    [self btBack_DisModal:nil];
    PersonLoginedViewController * pvc = [[PersonLoginedViewController alloc] init];
    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:pvc];
    [self presentViewController:nvc animated:YES completion:nil];
}

-(UIView *)getTitleViewWithFrame:(CGRect)frame title:(NSString *)title
{
    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    view.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.f];
    UIView * line = [[UIView alloc] init];
    line.frame = CGRectMake(0, 0, 6, frame.size.height);
    line.backgroundColor = [UIColor blueColor];
    [view addSubview:line];
    UILabel * label = [[UILabel alloc]init];
    label.frame = CGRectMake(20, 0, view.frame.size.width - 20, frame.size.height);
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blueColor];
    label.text = title.length?title:@"";
    [view addSubview:label];
    return view;
}

-(UIView *)getSelectViewWithFrame:(CGRect)frame title:(NSString *)title titleArray:(NSArray *)titleArray tag:(NSInteger)tag
{
    UIView * view = [[UIView alloc] init];
    view.frame = frame;
    view.backgroundColor = [UIColor whiteColor];
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(20, 5, 60, 30);
    titleLabel.font = [UIFont systemFontOfSize:14.f];
    titleLabel.text = title.length?title:@"";
    [view addSubview:titleLabel];
    NSInteger count = titleArray.count;
    if(count)
    {
        UIView * lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(20, 60, view.frame.size.width - 40, 0.5f);
        lineView.backgroundColor = [UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.f];
        [view addSubview:lineView];
        
        CGFloat x = lineView.frame.size.width/(count-1);
        for(int i=0;i<count;i++)
        {
            UIImageView * imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(x*i, -4.75, 10, 10);
            imageView.image = [UIImage imageNamed:@"selection-unchecked.png"];
            [lineView addSubview:imageView];
            if(i == 0)
                imageView.image = [UIImage imageNamed:@"scroll-bar-selection.png"];
            
            UILabel * label = [[UILabel alloc] init];
            label.frame = CGRectMake(imageView.frame.origin.x , imageView.frame.origin.y + imageView.frame.size.height + 8, x, 20);
            label.font = [UIFont systemFontOfSize:12.f];
            label.backgroundColor = [UIColor clearColor];
            label.text = [titleArray objectAtIndex:i];
            [lineView addSubview:label];
        }
    }
    return view;
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

@end
