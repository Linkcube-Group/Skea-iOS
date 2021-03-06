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
#import "SevenSwitch.h"

///电机变速
#define AppGearbox @"2504ff0a00000032"

/*
@interface SKAlertView : UIView


-(id)initWithFrame:(NSString *)content gifImageName:(NSString *)gifImageName;
//UIView *viewFloat;

@end

@implementation SKAlertView

-(id)initWithFrame:(NSString *)content gifImageName:(NSString *)gifImageName
{
    if(self = [super init])
    {
//        if (isIOS7) {
  //          self.edgesForExtendedLayout = UIRectEdgeNone;
    //    }
        UIView *blackBackground;
        
        blackBackground = [[UIView alloc] initWithFrame:theApp.window.bounds];
        blackBackground.backgroundColor = [UIColor blackColor];
        blackBackground.alpha = 0;
        blackBackground.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            blackBackground.alpha = 0.8;
        }];
        [self addSubview:blackBackground];
        
        UIView *roundrectAlert = [[UIView alloc] initWithFrame:CGRectMake(30, 50, [UIScreen mainScreen].bounds.size.width - 60, 320)];
        roundrectAlert.layer.cornerRadius = 10.f;
        roundrectAlert.userInteractionEnabled = YES;
        roundrectAlert.backgroundColor = [UIColor whiteColor];
        [self addSubview:roundrectAlert];
        //roundrectAlert.layer.shadowOffset = CGSizeMake(0, 2);
        //roundrectAlert.layer.shadowOpacity = 0.80;
        //roundrectAlert.layer.borderWidth = 0.6;
        //roundrectAlert.layer.borderColor = [UIColor grayColor].CGColor;
        
        NSString* filePath = [[NSBundle mainBundle] pathForResource:gifImageName ofType:nil];
        SCGIFImageView* gifImageView = [[SCGIFImageView alloc] initWithGIFFile:filePath];
        gifImageView.backgroundColor = [UIColor clearColor];
        gifImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 200)/2.f, 50 , 200, 200);
        [self addSubview:gifImageView];
        
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(40, 250,[UIScreen mainScreen].bounds.size.width - 80, 80);
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 10;
        label.text = content;
        label.font = [UIFont systemFontOfSize:11.f];
        label.textColor = [UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1.f];
        [self addSubview:label];
        
        UIView * line = [[UIView alloc] init];
        line.frame = CGRectMake(30, 329.5,[UIScreen mainScreen].bounds.size.width - 60, 0.5);
        line.backgroundColor = [UIColor grayColor];
        [self addSubview:line];
        
        UIButton * dissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dissButton.frame = CGRectMake(30, 330, [UIScreen mainScreen].bounds.size.width - 60, 40);
        [dissButton setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        dissButton.backgroundColor = [UIColor blueColor];
        [dissButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [dissButton setTitleColor:[UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1.f] forState:UIControlStateHighlighted];
        dissButton.layer.cornerRadius = 10.f;
        [dissButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:dissButton];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAlert)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

-(void)dismiss
{
    [self removeFromSuperview];
}

-(void)closeAlert
{
    self.hidden = YES;
    
}


@end
 
*/
 

@interface ParameterSetViewController ()


@end

@implementation ParameterSetViewController
{
    UISlider * _slider0;
    UISlider * _slider1;
    UISlider * _slider2;
   // UIView * alertView0;
   // UIView * alertView1;
    UILabel * _speedLabel;
    UIView *blackBackgroundAlert;
    UIView *roundrectAlert;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:NSLocalizedString(@"Skea参数调节", nil)];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"menu_action_back_white.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    //    self.navigationItem.rightBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:nil Title:@"保存" Target:self Selector:@selector(save)];
    
    self.view.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    
    [self.view addSubview:[self createTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50) title:NSLocalizedString(@"压力敏感度", nil)]];
    [self.view addSubview:[self createSlidre0WithFrame:CGRectMake(0, 50, self.view.frame.size.width, 80) liftTitle:NSLocalizedString(@"敏感", nil) rightTitle:NSLocalizedString(@"不敏感", nil) selector:@selector(up)]];
    
    UIView * sView1 = [self createTitleViewWithFrame:CGRectMake(0, 130, self.view.frame.size.width, 50) title:NSLocalizedString(@"反馈震动强度", nil)];
    sView1.userInteractionEnabled = YES;
    [self.view addSubview:sView1];
    [self.view addSubview:[self createSlidre1WithFrame:CGRectMake(0, 180, self.view.frame.size.width, 80) liftTitle:NSLocalizedString(@"弱", nil) rightTitle:NSLocalizedString(@"强", nil) selector:@selector(down)]];
    _speedLabel = [[UILabel alloc] init];
    _speedLabel.frame = CGRectMake(self.view.frame.size.width - 100 - 60, 10, 60, 30);
    _speedLabel.backgroundColor = [UIColor clearColor];
    _speedLabel.textAlignment = NSTextAlignmentRight;
    _speedLabel.font = [UIFont systemFontOfSize:14.f];
    _speedLabel.textColor = [UIColor grayColor];
    _speedLabel.text = [SkeaUser defaultUser].speedType == SpeedTypeConstant?NSLocalizedString(@"恒速", nil):NSLocalizedString(@"变速", nil);
    [sView1 addSubview:_speedLabel];
    SevenSwitch * speedSwitch = [[SevenSwitch alloc] init];
    speedSwitch.frame = CGRectMake(self.view.frame.size.width - 80, 10, 60, 30);
    speedSwitch.inactiveColor = [UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1];
    speedSwitch.onColor = [UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1];
    speedSwitch.borderColor = [UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1];
    speedSwitch.shadowColor = [UIColor clearColor];
    speedSwitch.on = [SkeaUser defaultUser].speedType == SpeedTypeConstant;
    [speedSwitch addTarget:self action:@selector(speedChange:) forControlEvents:UIControlEventValueChanged];
    [sView1 addSubview:speedSwitch];
    
    [self.view addSubview:[self createTitleViewWithFrame:CGRectMake(0, 260, self.view.frame.size.width, 50) title:NSLocalizedString(@"游戏自震动强度", nil)]];
    [self.view addSubview:[self createSlidre2WithFrame:CGRectMake(0, 310, self.view.frame.size.width, 80) liftTitle:NSLocalizedString(@"弱", nil) rightTitle:NSLocalizedString(@"强", nil) selector:nil]];
    
}



-(void)initWithFrame:(NSString *)content gifImageName:(NSString *)gifImageName {

    if (isIOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    blackBackgroundAlert = [[UIView alloc] initWithFrame:theApp.window.bounds];
    blackBackgroundAlert.backgroundColor = [UIColor blackColor];
    blackBackgroundAlert.alpha = 0;
    blackBackgroundAlert.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        blackBackgroundAlert.alpha = 0.8;
    }];
    [self.view addSubview:blackBackgroundAlert];
    
    roundrectAlert = [[UIView alloc] initWithFrame:CGRectMake(30, 50, [UIScreen mainScreen].bounds.size.width - 60, 320)];
    roundrectAlert.layer.cornerRadius = 10.f;
    roundrectAlert.userInteractionEnabled = YES;
    roundrectAlert.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:roundrectAlert];
    //roundrectAlert.layer.shadowOffset = CGSizeMake(0, 2);
    //roundrectAlert.layer.shadowOpacity = 0.80;
    //roundrectAlert.layer.borderWidth = 0.6;
    //roundrectAlert.layer.borderColor = [UIColor grayColor].CGColor;
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:gifImageName ofType:nil];
    SCGIFImageView* gifImageView = [[SCGIFImageView alloc] initWithGIFFile:filePath];
    gifImageView.backgroundColor = [UIColor clearColor];
    gifImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 260)/2.f, 0 , 200, 200);
    [roundrectAlert addSubview:gifImageView];
    
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, 200,[UIScreen mainScreen].bounds.size.width - 80, 80);
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 10;
    label.text = content;
    label.font = [UIFont systemFontOfSize:11.f];
    label.textColor = [UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1.f];
    [roundrectAlert addSubview:label];
    
    UIView * line = [[UIView alloc] init];
    line.frame = CGRectMake(0, 279.5,[UIScreen mainScreen].bounds.size.width - 60, 0.5);
    line.backgroundColor = [UIColor grayColor];
    [roundrectAlert addSubview:line];
    
    UIButton * dissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dissButton.frame = CGRectMake(00, 280, [UIScreen mainScreen].bounds.size.width - 60, 40);
    [dissButton setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
    dissButton.backgroundColor = [UIColor clearColor];
    [dissButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [dissButton setTitleColor:[UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1.f] forState:UIControlStateHighlighted];
    dissButton.layer.cornerRadius = 10.f;
    [dissButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [roundrectAlert addSubview:dissButton];
    
}

-(void)dismiss
{
    blackBackgroundAlert.hidden = YES;
    roundrectAlert.hidden = YES;
}


-(void)speedChange:(UISwitch *)speedSwitch
{
    NSLog(@"%d",speedSwitch.on);
    if(speedSwitch.on)
    {
        //恒速可调节
        [SkeaUser defaultUser].speedType = SpeedTypeConstant;
        [self enableSlider1];
        UIImage *thumbImage = [UIImage imageNamed:@"scroll-bar-selection.png"];
        [_slider1 setThumbImage:thumbImage forState:UIControlStateHighlighted];
        [_slider1 setThumbImage:thumbImage forState:UIControlStateNormal];
        [[ProtolManager shareProtolManager] sendToolRotateLevel:(int)_slider1.value];
    }
    else
    {
        //变速不可调节
        [SkeaUser defaultUser].speedType = SpeedTypeChange;
        [self disableSlider1];
        UIImage *thumbImage = [UIImage imageNamed:@"graycycle.png"];
        [_slider1 setThumbImage:thumbImage forState:UIControlStateHighlighted];
        [_slider1 setThumbImage:thumbImage forState:UIControlStateNormal];
        [[bleCentralManager shareManager] sendCommand:AppGearbox];
    }
    _speedLabel.text = [SkeaUser defaultUser].speedType == SpeedTypeConstant?NSLocalizedString(@"恒速", nil):NSLocalizedString(@"变速", nil);
}

-(void)enableSlider1
{
//    _slider1.enabled = YES;
    _slider1.userInteractionEnabled = YES;
    [_slider1 setMinimumTrackTintColor:[UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1]];
}

-(void)disableSlider1
{
//    _slider1.enabled = NO;
    _slider1.userInteractionEnabled = NO;
//    _slider1.value = 16;
    [_slider1 setMinimumTrackTintColor:[UIColor grayColor]];
    
}

-(void)save
{
    [[NSUserDefaults standardUserDefaults] setInteger:_slider0.value forKey:@"compressLevel"];
    [[NSUserDefaults standardUserDefaults] setInteger:_slider1.value forKey:@"rotateLevel"];
    [[NSUserDefaults standardUserDefaults] setInteger:_slider2.value forKey:@"selfLevel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //    [self btBack_DisModal:nil];
}

-(void)up
{
    [self initWithFrame:NSLocalizedString(@"Skea放入体内,用力挤压,Skea会有反馈震动哦。如果Skea始终无反馈，请增加压力敏感度，如用力较轻达不到锻炼目的，请降低压力敏感度。", nil) gifImageName:@"1.gif"];
    [self save];
}

-(void)down
{
    [self initWithFrame:NSLocalizedString(@"把Skea放入体内,用力挤压,Skea会有反馈震动哦。震动反馈可以调节。", nil) gifImageName:@"1.gif"];
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
    _slider0.minimumValue = 1;
    _slider0.maximumValue = 16;
    [_slider0 setMinimumTrackTintColor:[UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1]];
    _slider0.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"compressLevel"]>0?[[NSUserDefaults standardUserDefaults] integerForKey:@"compressLevel"]:3;
    
    [_slider0 setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [_slider0 setThumbImage:thumbImage forState:UIControlStateNormal];
    
    [_slider0 addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [_slider0 addTarget:self action:@selector(slider0Change) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    
    _slider1=[[UISlider alloc]initWithFrame:CGRectMake(20, 10, view.frame.size.width - 40, 30)];
    _slider1.backgroundColor = [UIColor clearColor];
    _slider1.backgroundColor = [UIColor clearColor];
    _slider1.minimumValue = 1;
    _slider1.maximumValue = 32;
    if([SkeaUser defaultUser].speedType == SpeedTypeChange)
    {
        [_slider1 setMinimumTrackTintColor:[UIColor grayColor]];
        UIImage *thumbImage = [UIImage imageNamed:@"graycycle.png"];
        [_slider1 setThumbImage:thumbImage forState:UIControlStateHighlighted];
        [_slider1 setThumbImage:thumbImage forState:UIControlStateNormal];
    }
    else
    {
        [_slider1 setMinimumTrackTintColor:[UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1]];
        UIImage *thumbImage = [UIImage imageNamed:@"scroll-bar-selection.png"];
        [_slider1 setThumbImage:thumbImage forState:UIControlStateHighlighted];
        [_slider1 setThumbImage:thumbImage forState:UIControlStateNormal];
    }
    _slider1.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"rotateLevel"]>0?[[NSUserDefaults standardUserDefaults] integerForKey:@"rotateLevel"]:16;
    
    
    [_slider1 addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [_slider1 addTarget:self action:@selector(slider1Change) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:_slider1];
    if([SkeaUser defaultUser].speedType == SpeedTypeChange)
        [self disableSlider1];
    else
        [self enableSlider1];
    [view addSubview:[self createLabelWithFrame:CGRectMake(20, 40, 80, 40) title:lift textAlignment:NSTextAlignmentLeft]];
    [view addSubview:[self createLabelWithFrame:CGRectMake(view.frame.size.width - 20 - 80, 40, 80, 40) title:right textAlignment:NSTextAlignmentRight]];
    
    return view;
}

-(void)slider1Change
{
    NSLog(@"%f",_slider1.value);
    [[ProtolManager shareProtolManager] sendToolRotateLevel:(int)_slider1.value];
}

-(UIView *)createSlidre2WithFrame:(CGRect)rect liftTitle:(NSString *)lift rightTitle:(NSString *)right selector:(SEL)selector
{
    UIView * view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    
    UIImage *thumbImage = [UIImage imageNamed:@"scroll-bar-selection.png"];
    
    _slider2=[[UISlider alloc]initWithFrame:CGRectMake(20, 10, view.frame.size.width - 40, 30)];
    _slider2.backgroundColor = [UIColor clearColor];
    _slider2.minimumValue = 1;
    _slider2.maximumValue = 32;
    [_slider2 setMinimumTrackTintColor:[UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1]];
    _slider2.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"selfLevel"]>0?[[NSUserDefaults standardUserDefaults] integerForKey:@"selfLevel"]:10;
    
    [_slider2 setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [_slider2 setThumbImage:thumbImage forState:UIControlStateNormal];
    
    [_slider2 addTarget:self action:@selector(slider2Change) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:_slider2];
    
    [view addSubview:[self createLabelWithFrame:CGRectMake(20, 40, 80, 40) title:lift textAlignment:NSTextAlignmentLeft]];
    [view addSubview:[self createLabelWithFrame:CGRectMake(view.frame.size.width - 20 - 80, 40, 80, 40) title:right textAlignment:NSTextAlignmentRight]];
    
    return view;
}

-(void)slider2Change
{
    [self save];
    [AppConfig setGameRotate:_slider2.value];
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

@end
