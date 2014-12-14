//
//  ParameterSetViewController.m
//  Skea
//
//  Created by yuyang on 14/10/30.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "ParameterSetViewController.h"
#import "SCGIFImageView.h"
#import "ProtolManager.h"

@interface SKAlertView : UIView

-(id)initWithFrame:(CGRect)rect content:(NSString *)content gifImageName:(NSString *)gifImageName;

@end

@implementation SKAlertView

-(id)initWithFrame:(CGRect)rect content:(NSString *)content gifImageName:(NSString *)gifImageName
{
    if(self = [super init])
    {
        self.frame = rect;
        self.layer.cornerRadius = 10.f;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
//        self.layer.shadowOffset = CGSizeMake(0, 2);
//        self.layer.shadowOpacity = 0.80;
        self.layer.borderWidth = 0.6;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        
        NSString* filePath = [[NSBundle mainBundle] pathForResource:gifImageName ofType:nil];
        SCGIFImageView* gifImageView = [[SCGIFImageView alloc] initWithGIFFile:filePath];
        gifImageView.backgroundColor = [UIColor clearColor];
        gifImageView.frame = CGRectMake((self.frame.size.width - 200)/2.f, 0 , 200, 200);
        [self addSubview:gifImageView];
        
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 200, self.frame.size.width - 20, 60);
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 10;
        label.text = content;
        label.font = [UIFont systemFontOfSize:12.f];
        [self addSubview:label];
        
        UIView * line = [[UIView alloc] init];
        line.frame = CGRectMake(0, 259.5, self.frame.size.width, 0.5);
        line.backgroundColor = [UIColor colorWithWhite:0.32 alpha:1.f];
        [self addSubview:line];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 260, [UIScreen mainScreen].bounds.size.width - 60, 40);
        [button setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1.f] forState:UIControlStateHighlighted];
        button.layer.cornerRadius = 10.f;
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}

-(void)dismiss
{
    [self removeFromSuperview];
}

@end

@interface ParameterSetViewController ()

@end

@implementation ParameterSetViewController
{
    UISlider * _slider0;
    UISlider * _slider1;
    SKAlertView * alertView0;
    SKAlertView * alertView1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:@"Skea参数调节"];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"menu_action_back_white.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
//    self.navigationItem.rightBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:nil Title:@"保存" Target:self Selector:@selector(save)];
    
    self.view.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    
    [self.view addSubview:[self createTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50) title:NSLocalizedString(@"压力敏感度", nil)]];
    [self.view addSubview:[self createSlidre0WithFrame:CGRectMake(0, 50, self.view.frame.size.width, 80) liftTitle:NSLocalizedString(@"不敏感", nil) rightTitle:NSLocalizedString(@"敏感", nil) selector:@selector(up)]];
    
    [self.view addSubview:[self createTitleViewWithFrame:CGRectMake(0, 130, self.view.frame.size.width, 50) title:NSLocalizedString(@"反馈震动强度", nil)]];
    [self.view addSubview:[self createSlidre1WithFrame:CGRectMake(0, 180, self.view.frame.size.width, 80) liftTitle:NSLocalizedString(@"弱", nil) rightTitle:NSLocalizedString(@"强", nil) selector:@selector(down)]];
}

-(void)save
{
    [[NSUserDefaults standardUserDefaults] setInteger:_slider0.value forKey:@"compressLevel"];
    [[NSUserDefaults standardUserDefaults] setInteger:_slider1.value forKey:@"rotateLevel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
//    [self btBack_DisModal:nil];
}

-(void)up
{
    
    alertView0  = [[SKAlertView alloc] initWithFrame:CGRectMake(30, 50, [UIScreen mainScreen].bounds.size.width - 60, 300) content:@"把Skea放入体内,用力积压,Skea会有反馈震动哦,如果觉得反馈震动太强,请降低震动强度,如果觉得用力太弱,请增加震动强度" gifImageName:@"1.gif"];
    [self.view addSubview:alertView0];
    [self save];
}

-(void)down
{
    alertView1  = [[SKAlertView alloc] initWithFrame:CGRectMake(30, 50, [UIScreen mainScreen].bounds.size.width - 60, 300) content:@"把Skea放入体内,用力积压,Skea会有反馈震动哦,如果觉得反馈震动太强,请降低震动强度,如果觉得用力太弱,请增加震动强度" gifImageName:@"1.gif"];
    [self.view addSubview:alertView1];
    [self save];
}

-(UIImageView *)createTitleViewWithFrame:(CGRect)rect title:(NSString *)title
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = [UIImage imageNamed:@"title-background.png"];
    UILabel * label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.frame = CGRectMake(20, 0, imageView.frame.size.width - 20, imageView.frame.size.height);
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:17];
    label.text = title.length?title:@"";
    [imageView addSubview:label];
    return imageView;
}

-(UIView *)createSlidre0WithFrame:(CGRect)rect liftTitle:(NSString *)lift rightTitle:(NSString *)right selector:(SEL)selector
{
    UIView * view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    
    UIImage *thumbImage = [UIImage imageNamed:@"scroll-bar-selection.png"];
    
    _slider0=[[UISlider alloc]initWithFrame:CGRectMake(20, 10, view.frame.size.width - 40, 30)];
    _slider0.backgroundColor = [UIColor clearColor];
    _slider0.minimumValue = 0;
    _slider0.maximumValue = 15;
    [_slider0 setMinimumTrackTintColor:[UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1]];
    _slider0.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"compressLevel"];
    
    [_slider0 setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [_slider0 setThumbImage:thumbImage forState:UIControlStateNormal];
    
    [_slider0 addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [_slider0 addTarget:self action:@selector(slider0Change) forControlEvents:UIControlEventValueChanged];
    
    [view addSubview:_slider0];
    
    [view addSubview:[self createLabelWithFrame:CGRectMake(20, 40, 80, 40) title:lift textAlignment:NSTextAlignmentLeft]];
    [view addSubview:[self createLabelWithFrame:CGRectMake(view.frame.size.width - 20 - 80, 40, 80, 40) title:right textAlignment:NSTextAlignmentRight]];
    
    return view;
}

-(void)slider0Change
{
    NSLog(@"%f",_slider0.value);
    [[ProtolManager shareProtolManager] sendToolCompressLevel:_slider0.value];
}

-(UIView *)createSlidre1WithFrame:(CGRect)rect liftTitle:(NSString *)lift rightTitle:(NSString *)right selector:(SEL)selector
{
    UIView * view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    
    UIImage *thumbImage = [UIImage imageNamed:@"scroll-bar-selection.png"];
    
    _slider1=[[UISlider alloc]initWithFrame:CGRectMake(20, 10, view.frame.size.width - 40, 30)];
    _slider1.backgroundColor = [UIColor clearColor];
    _slider1.backgroundColor = [UIColor clearColor];
    _slider1.minimumValue = 0;
    _slider1.maximumValue = 31;
    [_slider1 setMinimumTrackTintColor:[UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1]];
    _slider1.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"rotateLevel"];
    
    [_slider1 setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [_slider1 setThumbImage:thumbImage forState:UIControlStateNormal];
    
    [_slider1 addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [_slider1 addTarget:self action:@selector(slider1Change) forControlEvents:UIControlEventValueChanged];
    
    [view addSubview:_slider1];
    
    [view addSubview:[self createLabelWithFrame:CGRectMake(20, 40, 80, 40) title:lift textAlignment:NSTextAlignmentLeft]];
    [view addSubview:[self createLabelWithFrame:CGRectMake(view.frame.size.width - 20 - 80, 40, 80, 40) title:right textAlignment:NSTextAlignmentRight]];
    
    return view;
}

-(void)slider1Change
{
    NSLog(@"%f",_slider1.value);
    [[ProtolManager shareProtolManager] sendToolRotateLevel:(int)_slider1.value];
}

-(void)enableSlider1
{
    
}

-(void)disableSlider1
{
    
}

-(UILabel *)createLabelWithFrame:(CGRect)rect title:(NSString *)title textAlignment:(NSTextAlignment)textAlignment
{
    UILabel * label = [[UILabel alloc] init];
    label.frame  = rect;
    label.backgroundColor = [UIColor clearColor];
    label.text = title.length?title:@"";
    label.textAlignment = textAlignment;
    label.font = [UIFont systemFontOfSize:13];
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
