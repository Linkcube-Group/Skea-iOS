//
//  ParameterSetViewController.m
//  Skea
//
//  Created by yuyang on 14/10/30.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "ParameterSetViewController.h"
#import "SCGIFImageView.h"

@interface SKAlertView : UIView

@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSString * content;
@property (nonatomic,strong) NSString * gifImageName;


@end

@implementation SKAlertView

-(id)init
{
    if(self = [super init])
    {
        self.frame = CGRectMake(30, 100, [UIScreen mainScreen].bounds.size.width - 60, 200);
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        NSString* filePath = [[NSBundle mainBundle] pathForResource:self.gifImageName ofType:nil];
        SCGIFImageView* gifImageView = [[SCGIFImageView alloc] initWithGIFFile:filePath];
        gifImageView.frame = CGRectMake(0, 0, self.frame.size.width, gifImageView.image.size.height);
        gifImageView.center = self.center;
        [self addSubview:gifImageView];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 160, [UIScreen mainScreen].bounds.size.width - 60, 40);
        [button setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        [self addSubview:button];
    }
    return self;
}

@end

@interface ParameterSetViewController ()

@end

@implementation ParameterSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:@"Skea参数调节"];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"menu_action_back_white.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    self.view.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    
    [self.view addSubview:[self createTitleViewWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50) title:NSLocalizedString(@"压力敏感度", nil)]];
    [self.view addSubview:[self createSlidreWithFrame:CGRectMake(0, 114, self.view.frame.size.width, 80) liftTitle:NSLocalizedString(@"不敏感", nil) rightTitle:NSLocalizedString(@"敏感", nil) selector:@selector(up)]];
    
    [self.view addSubview:[self createTitleViewWithFrame:CGRectMake(0, 194, self.view.frame.size.width, 50) title:NSLocalizedString(@"反馈震动强度", nil)]];
    [self.view addSubview:[self createSlidreWithFrame:CGRectMake(0, 244, self.view.frame.size.width, 80) liftTitle:NSLocalizedString(@"弱", nil) rightTitle:NSLocalizedString(@"强", nil) selector:@selector(down)]];
}

-(void)up
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)down
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"" otherButtonTitles:nil, nil];
    [alert show];
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

-(UIView *)createSlidreWithFrame:(CGRect)rect liftTitle:(NSString *)lift rightTitle:(NSString *)right selector:(SEL)selector
{
    UIView * view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    
    UIImage *thumbImage = [UIImage imageNamed:@"scroll-bar-selection.png"];
    
    UISlider *slider=[[UISlider alloc]initWithFrame:CGRectMake(20, 10, view.frame.size.width - 40, 30)];
    slider.backgroundColor = [UIColor clearColor];
    
    [slider setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [slider setThumbImage:thumbImage forState:UIControlStateNormal];
    
    [slider addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
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
