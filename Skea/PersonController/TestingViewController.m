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
{
    UIImageView * _bluePoint1;
    UIImageView * _bluePoint2;
    UIImageView * _bluePoint3;
    UIImageView * _bluePoint4;
}
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
    _bluePoint1 = [[UIImageView alloc] init];
    _bluePoint2 = [[UIImageView alloc] init];
    _bluePoint3 = [[UIImageView alloc] init];
    _bluePoint4 = [[UIImageView alloc] init];
    _bluePoint1.image = [UIImage imageNamed:@"scroll-bar-selection.png"];
    _bluePoint2.image = [UIImage imageNamed:@"scroll-bar-selection.png"];
    _bluePoint3.image = [UIImage imageNamed:@"scroll-bar-selection.png"];
    _bluePoint4.image = [UIImage imageNamed:@"scroll-bar-selection.png"];
    // Do any additional setup after loading the view from its nib.
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
        return 40.f;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    cell.contentView.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    if(indexPath.row == 0)
    {
        cell.textLabel.text = @"Please fill in the questionnaire in order that we can evaluate the health risk of your pelvic floor muscle.";
        [cell.textLabel setTextColor:[UIColor colorWithRed:139/255.f green:220/255.f blue:222/255.f alpha:1.f]];
        cell.textLabel.numberOfLines = 4;
        cell.textLabel.font = [UIFont systemFontOfSize:12.f];
    }
    if(indexPath.row == 1)
    {
        [cell.contentView addSubview:[self createTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.f) title:@"Basic information"]];
    }
    if(indexPath.row == 2)
    {
        cell.textLabel.text = @"Birthday";
        UITextField * field = [[UITextField alloc] init];
        field.frame = CGRectMake(100, 0, self.view.frame.size.width - 110, 40.f);
        field.text = @"1980-01-01";
        field.delegate = self;
        field.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:field];
    }
    if(indexPath.row == 3)
    {
        cell.textLabel.text = @"Height";
        UITextField * field = [[UITextField alloc] init];
        field.frame = CGRectMake(100, 0, self.view.frame.size.width - 110, 40.f);
        field.text = @"5'9\"";
        field.delegate = self;
        field.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:field];
    }
    if(indexPath.row == 4)
    {
        cell.textLabel.text = @"Weight";
        UITextField * field = [[UITextField alloc] init];
        field.frame = CGRectMake(100, 0, self.view.frame.size.width - 110, 40.f);
        field.text = @"134lb";
        field.delegate = self;
        field.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:field];
    }
    if(indexPath.row == 5)
    {
        [cell.contentView addSubview:[self createTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.f) title:@"Health information"]];
    }
    if(indexPath.row == 6)
    {
        [cell.contentView addSubview:[self createDTViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70.f) title:@"Reproductive History" titleArray:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@">3", nil] tag:indexPath.row]];
        [self setBluePointAtIndexPath:indexPath inView:cell.contentView];
    }
    if(indexPath.row == 7)
    {
        [cell.contentView addSubview:[self createDTViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70.f) title:@"Sexual Activity" titleArray:[NSArray arrayWithObjects:@"Almost Never",@"Rare (>4 yearly)",@"Ocassional (>1 monthly)",@"Active (>1 weekly)",@"Pretty Active (>3 weekly)", nil] tag:indexPath.row]];
        [self setBluePointAtIndexPath:indexPath inView:cell.contentView];
        [cell.contentView addSubview:[self createContentViewWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 40) content:@"Sexual activity is a key variable related to the risk factor of pelvic floor muscle dysfunction."]];
    }
    if(indexPath.row == 8)
    {
        [cell.contentView addSubview:[self createDTViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70.f) title:@"Urinary Incontinence" titleArray:[NSArray arrayWithObjects:@"Never",@"Rare (>4 yearly)",@"Ocassional (>1 monthly)",@"Often (>1 weekly)",@"Pretty Often (>3 weekly)", nil] tag:indexPath.row]];
        [self setBluePointAtIndexPath:indexPath inView:cell.contentView];
        [cell.contentView addSubview:[self createContentViewWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 40) content:@"Urinary incontinence is the measure of a risk factor of pelvic floor muscle dysfunction."]];
    }
    if(indexPath.row == 9)
    {
        [cell.contentView addSubview:[self createDTViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70.f) title:@"Mental Status" titleArray:[NSArray arrayWithObjects:@"Very Restful",@"Restful",@"Normal",@"Stressful",@"Very Stressful", nil] tag:indexPath.row]];
        [self setBluePointAtIndexPath:indexPath inView:cell.contentView];
    }
    if(indexPath.row == 10)
    {
        UIButton * submitButtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitButtn.frame = CGRectMake(10, 5, self.view.frame.size.width - 20, 30);
        submitButtn.backgroundColor = [UIColor colorWithRed:220/255.f green:239/255.f blue:244/255.f alpha:1.f];
        [submitButtn setBackgroundImage:[UIImage imageNamed:@"button-cyan.png"] forState:UIControlStateNormal];
        submitButtn.layer.cornerRadius = 15.f;
        [submitButtn setTitle:NSLocalizedString(@"Submit", nil) forState:UIControlStateNormal];
        [submitButtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [submitButtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:submitButtn];
    }
    return cell;
}

-(UIView *)createDTViewWithFrame:(CGRect)rect title:(NSString *)title titleArray:(NSArray *)titleArray tag:(NSInteger)tag
{
    UIView * view = [[UIView alloc] init];
    view.frame = rect;
    view.backgroundColor = [UIColor whiteColor];
    //30
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 0, view.frame.size.width - 20, 30);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.text = title.length?title:@"";
    [view addSubview:label];
    //10
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(10, 30, view.frame.size.width - 20, 10);
    imageView.image = [UIImage imageNamed:@"scroll-bar.png"];
    [view addSubview:imageView];
    //30
    CGFloat width = imageView.frame.size.width;
    CGFloat width_4 = width/4.f;
    [view addSubview:[self createLabelWithFrame:CGRectMake(10 + width_4/2.f * 0, 40, width_4/2.f, 30) Title:[titleArray objectAtIndex:0] alignment:NSTextAlignmentLeft]];
    [view addSubview:[self createLabelWithFrame:CGRectMake(10 + width_4/2.f * 1, 40, width_4, 30) Title:[titleArray objectAtIndex:1] alignment:NSTextAlignmentCenter]];
    [view addSubview:[self createLabelWithFrame:CGRectMake(10 + width_4/2.f * 3, 40, width_4, 30) Title:[titleArray objectAtIndex:2] alignment:NSTextAlignmentCenter]];
    [view addSubview:[self createLabelWithFrame:CGRectMake(10 + width_4/2.f * 5, 40, width_4, 30) Title:[titleArray objectAtIndex:3] alignment:NSTextAlignmentCenter]];
    [view addSubview:[self createLabelWithFrame:CGRectMake(10 + width_4/2.f * 7, 40, width_4/2.f, 30) Title:[titleArray objectAtIndex:4] alignment:NSTextAlignmentRight]];
    //打点
    [view addSubview:[self createButtonWithFrame:CGRectMake(10 + width_4/2.f * 0, 30, width_4/2.f, 40) tag:tag * 10 + 0]];
    [view addSubview:[self createButtonWithFrame:CGRectMake(10 + width_4/2.f * 1, 30, width_4, 40) tag:tag * 10 + 1]];
    [view addSubview:[self createButtonWithFrame:CGRectMake(10 + width_4/2.f * 3, 30, width_4, 40) tag:tag * 10 + 2]];
    [view addSubview:[self createButtonWithFrame:CGRectMake(10 + width_4/2.f * 5, 30, width_4, 40) tag:tag * 10 + 3]];
    [view addSubview:[self createButtonWithFrame:CGRectMake(10 + width_4/2.f * 7, 30, width_4/2.f, 40) tag:tag * 10 + 4]];
    return view;
}

-(void)setBluePointAtIndexPath:(NSIndexPath *)indexPath inView:(UIView *)view
{
    if(indexPath.row == 6)
    {
        _bluePoint1.frame = CGRectMake(10 - 2, 30 - 2, 14, 14);
        [view insertSubview:_bluePoint1 atIndex:1];
    }
    if(indexPath.row == 7)
    {
        _bluePoint2.frame = CGRectMake(10 - 2, 30 - 2, 14, 14);
        [view insertSubview:_bluePoint2 atIndex:1];
    }
    if(indexPath.row == 8)
    {
        _bluePoint3.frame = CGRectMake(10 - 2, 30 - 2, 14, 14);
        [view insertSubview:_bluePoint3 atIndex:1];
    }
    if(indexPath.row == 9)
    {
        _bluePoint4.frame = CGRectMake(10 - 2, 30 - 2, 14, 14);
        [view insertSubview:_bluePoint4 atIndex:1];
    }
}

-(UIButton *)createButtonWithFrame:(CGRect)rect tag:(NSInteger)tag
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    btn.tag = tag;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

-(void)btnClick:(UIButton *)btn
{
    NSLog(@"btn%ld",btn.tag);
    if(btn.tag/10 == 6)
    {
        [UIView animateWithDuration:0.8 animations:^{
            _bluePoint1.frame = CGRectMake(10 - 2 - 2 * (btn.tag%10) + (self.view.frame.size.width - 20)/4.f * (btn.tag%10), 30 - 2, 14, 14);
        }];
    }
    if(btn.tag/10 == 7)
    {
        [UIView animateWithDuration:0.8 animations:^{
            _bluePoint2.frame = CGRectMake(10 - 2 - 2 * (btn.tag%10) + (self.view.frame.size.width - 20)/4.f * (btn.tag%10), 30 - 2, 14, 14);
        }];
    }
    if(btn.tag/10 == 8)
    {
        [UIView animateWithDuration:0.8 animations:^{
            _bluePoint3.frame = CGRectMake(10 - 2 - 2 * (btn.tag%10) + (self.view.frame.size.width - 20)/4.f * (btn.tag%10), 30 - 2, 14, 14);
        }];
    }
    if(btn.tag/10 == 9)
    {
        [UIView animateWithDuration:0.8 animations:^{
            _bluePoint4.frame = CGRectMake(10 - 2 - 2 * (btn.tag%10) + (self.view.frame.size.width - 20)/4.f * (btn.tag%10), 30 - 2, 14, 14);
        }];
    }
}

-(UILabel *)createLabelWithFrame:(CGRect)rect Title:(NSString *)title alignment:(NSTextAlignment)alignment
{
    UILabel * label = [[UILabel alloc] init];
    label.frame = rect;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:9.f];
    label.numberOfLines = 2;
    label.textAlignment = alignment;
    label.text = title;
    return label;
}

//40
-(UIView *)createContentViewWithFrame:(CGRect)rect content:(NSString *)content
{
    UIView * view = [[UIView alloc] init];
    view.frame = rect;
    view.backgroundColor = [UIColor whiteColor];
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(10, 5, 30, 30);
    imageView.image = [UIImage imageNamed:@"bookmark.png"];
    [view addSubview:imageView];
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(50, 5, view.frame.size.width - 50 - 10, 30);
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 2;
    label.text = content;
    label.textColor = [UIColor colorWithRed:138/255.f green:199/255.f blue:222/255.f alpha:1.f];
    label.font = [UIFont systemFontOfSize:12.f];
    [view addSubview:label];
    return view;
}

-(void)submit
{
//    [self btBack_DisModal:nil];
    PersonLoginedViewController * pvc = [[PersonLoginedViewController alloc] init];
    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:pvc];
    [self presentViewController:nvc animated:YES completion:nil];
}

-(UIImageView *)createTitleViewWithFrame:(CGRect)rect title:(NSString *)title
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = [UIImage imageNamed:@"title-background.png"];
    UILabel * label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.frame = CGRectMake(20, 0, imageView.frame.size.width - 20, imageView.frame.size.height);
    label.textColor = [UIColor blackColor];
    label.text = title.length?title:@"";
    [imageView addSubview:label];
    return imageView;
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
