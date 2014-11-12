//
//  ParameterSetViewController.m
//  Skea
//
//  Created by yuyang on 14/10/30.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "ParameterSetViewController.h"

@interface ParameterSetViewController ()

@end

@implementation ParameterSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:@"Skea参数设置"];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"back-cross.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:[self createTitleViewWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50) title:NSLocalizedString(@"压力敏感度", nil)]];
    [self.view addSubview:[self createSlidreWithFrame:CGRectMake(0, 114, self.view.frame.size.width, 80) liftTitle:NSLocalizedString(@"不敏感", nil) rightTitle:NSLocalizedString(@"敏感", nil)]];
    
    [self.view addSubview:[self createTitleViewWithFrame:CGRectMake(0, 194, self.view.frame.size.width, 50) title:NSLocalizedString(@"反馈震动强度", nil)]];
    [self.view addSubview:[self createSlidreWithFrame:CGRectMake(0, 244, self.view.frame.size.width, 80) liftTitle:NSLocalizedString(@"弱", nil) rightTitle:NSLocalizedString(@"强", nil)]];
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

-(UIView *)createSlidreWithFrame:(CGRect)rect liftTitle:(NSString *)lift rightTitle:(NSString *)right
{
    UIView * view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImage *thumbImage = [UIImage imageNamed:@"scroll-bar-selection.png"];
    
    UISlider *slider=[[UISlider alloc]initWithFrame:CGRectMake(20, 10, view.frame.size.width - 40, 30)];
    slider.backgroundColor = [UIColor clearColor];
    
    [slider setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [slider setThumbImage:thumbImage forState:UIControlStateNormal];
    
//    [slider addTarget:self action:@selector(sliderDragUp:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:slider];
    
    [view addSubview:[self createLabelWithFrame:CGRectMake(20, 40, 80, 40) title:lift textAlignment:NSTextAlignmentLeft]];
    [view addSubview:[self createLabelWithFrame:CGRectMake(view.frame.size.width - 20 - 80, 40, 80, 40) title:right textAlignment:NSTextAlignmentRight]];
    
    return view;
}

-(UILabel *)createLabelWithFrame:(CGRect)rect title:(NSString *)title textAlignment:(NSTextAlignment)textAlignment
{
    UILabel * label = [[UILabel alloc] init];
    label.frame  = rect;
    label.backgroundColor = [UIColor clearColor];
    label.text = title.length?title:@"";
    label.textAlignment = textAlignment;
    label.textColor = [UIColor grayColor];
    return label;
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
