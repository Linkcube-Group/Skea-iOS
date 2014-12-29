//
//  RecordViewController.m
//  Skea
//
//  Created by mosn on 10/7/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "RecordViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CalendarView.h"
#import "MPGraphView.h"
#import "MPPlot.h"
#import "MPBarsGraphView.h"

@interface RecordViewController ()<CalendarDelegate>
{
    CalendarView *_sampleView;
    
    MPGraphView *graph1;
    MPBarsGraphView *graph2;
    
    UIView *viewFloat;
   
}
@property (strong,nonatomic)  GameDetail *gameDetail;

@property (strong,nonatomic) IBOutlet UILabel *lbDate;
@property (strong,nonatomic) IBOutlet UILabel *lbTotalStatus;
@property (strong,nonatomic) IBOutlet UILabel *lbforceStatus;
@property (strong,nonatomic) IBOutlet UILabel *lbPersistStatus;
@property (strong,nonatomic) IBOutlet UILabel *lbScore;
@property (strong,nonatomic) IBOutlet UILabel *lbTime;
@property (strong,nonatomic) IBOutlet UIImageView *imgChartBg;
@property (strong,nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong,nonatomic) IBOutlet UIView *viewScoreBg;
@property (strong,nonatomic) IBOutlet UIView *viewDraw;
@property (strong,nonatomic) IBOutlet UILabel *lbRate;

@property (strong,nonatomic) IBOutlet UIView *viewHeader;

@property (strong,nonatomic) IBOutlet UILabel *lbLastMsg;
@property (strong,nonatomic) IBOutlet UILabel *lbDuration;
@property (strong,nonatomic) IBOutlet UILabel *lbSuccessRate;
@property (strong,nonatomic) IBOutlet UILabel *lbFenShu;
@property (strong,nonatomic) IBOutlet UILabel *lbShiChang;
@property (strong,nonatomic) IBOutlet UILabel *lbNumMessage;
@property (strong,nonatomic) IBOutlet UILabel *lbCorrectRate;
@property (strong,nonatomic) IBOutlet UILabel *lbTitle;
@property (strong,nonatomic) IBOutlet UILabel *lbForceTitle;
@property (strong,nonatomic) IBOutlet UILabel *lbPerTitle;
@end

@implementation RecordViewController

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
    
    if (isIOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationController.navigationBar.hidden = YES;
    self.lbForceTitle.text = NSLocalizedString(@"爆发力", nil);
    self.lbPerTitle.text = NSLocalizedString(@"持久力", nil);
    self.lbTitle.text = NSLocalizedString(@"成绩", nil);
    self.lbLastMsg.text = NSLocalizedString(@"请至少做一组测试", nil);
    self.lbDuration.text = NSLocalizedString(@"时长(s)", nil);
    self.lbSuccessRate.text = NSLocalizedString(@"成功率(%)", nil);
    self.lbFenShu.text = NSLocalizedString(@"分数:", nil);
    self.lbShiChang.text = NSLocalizedString(@"时长:", nil);
    self.lbNumMessage.text = NSLocalizedString(@"盆底肌收缩次数", nil);
    self.lbCorrectRate.text = NSLocalizedString(@"正确率", nil);
    self.viewScoreBg.layer.cornerRadius = 55;
    self.viewScoreBg.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.viewScoreBg.layer.borderWidth = 1;
    self.viewScoreBg.layer.masksToBounds = YES;
    

    self.scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight+100);

    self.gameDetail = [AppConfig getLastGameDetail];
    ////////////////////////////////////////////////////////////////////
    graph1=[[MPGraphView alloc] initWithFrame:CGRectMake(25, 6, 270, chatHeight)];
    graph1.waitToUpdate=YES;
    
    
    graph1.curved=NO;
    
    graph1.graphColor=[UIColor orangeColor];
    graph1.detailBackgroundColor=[UIColor orangeColor];
    
    CGRect rect = graph1.frame;
    rect.origin.y += 6;
    rect.origin.x += 1;
    rect.size.width -= 2;

    graph2=[MPPlot plotWithType:MPPlotTypeBars frame:rect];
    graph2.waitToUpdate=YES;
    graph2.detailView=(UIView <MPDetailView> *)[self customDetailView];
    graph2.graphColor=[UIColor colorWithRed:106/255.0 green:201/255.0 blue:223/255.0 alpha:1];
    [self.imgChartBg addSubview:graph2];
    
    [self.imgChartBg addSubview:graph1];
    
    
    viewFloat = [[UIView alloc] initWithFrame:theApp.window.bounds];
    viewFloat.backgroundColor = [UIColor blackColor];
    [self.view addSubview:viewFloat];
    viewFloat.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeCalendaer)];
    [viewFloat addGestureRecognizer:tap];
    
    _sampleView= [[CalendarView alloc]initWithFrame:CGRectMake(0, (ScreenHeight-320)/2, 320, 310)];
    _sampleView.delegate = self;
    [_sampleView setBackgroundColor:[UIColor whiteColor]];
    _sampleView.calendarDate = [NSDate date];
    [self.view addSubview:_sampleView];
    _sampleView.hidden = YES;
    
    
    [self updateDateView];

    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
//    [self performSelector:@selector(animate) withObject:nil afterDelay:0.3];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)animate{
    
    [graph1 animate];
    [graph2 animate];
    
}

- (NSString *)getGameTime:(int)length
{
    int minute = length/60;
    int second = length%60;
    return _S(@"%02d:%02d",minute,second);
}
- (IBAction)dateActoin:(id)sender
{
    viewFloat.alpha = 0;
    viewFloat.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        viewFloat.alpha = 0.8;
    }];
    _sampleView.hidden = NO;
}

-(void)tappedOnDate:(NSDate *)selectedDate
{
    NSLog(@"tappedOnDate %@(GMT)",selectedDate);
    NSString *day = _S(@"%.0f",[selectedDate timeIntervalSince1970]/(24*60*60));
    
    self.gameDetail = [AppConfig getGameDetail:day];
    if (self.gameDetail==nil) {
        showCustomAlertMessage(NSLocalizedString(@"当前日期没有训练记录",nil));
        return;
    }
    
    _sampleView.hidden = YES;
    
    [self updateDateView];
  
}

- (void)closeCalendaer
{
    viewFloat.hidden = YES;
     _sampleView.hidden = YES;
}


- (void)updateDateView
{
    
    if (self.gameDetail==nil) {
        self.viewHeader.hidden = NO;
        return;
    }
    self.viewHeader.hidden = YES;
    
    float rate = self.gameDetail.factScore*1.0/self.gameDetail.heighScore;
    
    int height = 110*rate;
    
    self.viewDraw.height = height;
    self.viewDraw.originY = 110-height;
    
    int rateInt = rate*100;
    
    NSString *rateStr = _S(@" %d%%",rateInt);
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:rateStr];
    
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange([rateStr length]-1,1)];
    self.lbRate.attributedText = attrStr;
    
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.viewDraw.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithHexString:@"#67C9D8"].CGColor,
                       (id)[UIColor clearColor].CGColor,nil];
    [self.viewDraw.layer insertSublayer:gradient atIndex:0];
    
    
//    NSDate *day = [NSDate dateWithTimeIntervalSince1970:[self.gameDetail.dateInterval intValue]*(24*60*60)];
    NSString *dayStr = @"Today";// [day stringDateWithFormat:@"MM/dd"];
    if (self.gameDetail.dateInterval!=nil && [self.gameDetail.dateInterval length]>5) {
        dayStr = [self.gameDetail.dateInterval substringFromIndex:[self.gameDetail.dateInterval length]-5];
        dayStr =[dayStr stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    }
    
    self.lbDate.text = _S(@"%@  Level %d",dayStr,self.gameDetail.level);
    self.lbTotalStatus.text = NSLocalizedString([self.gameDetail getStandard],nil);
    self.lbforceStatus.text = NSLocalizedString([self.gameDetail getExplosive],nil);
    self.lbPersistStatus.text = NSLocalizedString([self.gameDetail getEndurance],nil);
    self.lbScore.text = _S(@"%d",self.gameDetail.factScore);
    self.lbTime.text = [self getGameTime:self.gameDetail.exerciseTime];
    
    IMP_BLOCK_SELF(RecordViewController)
    
    [graph1 setAlgorithm:^CGFloat(CGFloat x) {
        return (1-[[block_self.gameDetail.aryGameInfo objectAtIndex:x] scoreRate]);
        
    } numberOfPoints:self.gameDetail.aryGameInfo.count];
    [graph2 setAlgorithm:^CGFloat(CGFloat x) {
        return [[block_self.gameDetail.aryGameInfo objectAtIndex:x] progressTime]/15.0;
    } numberOfPoints:self.gameDetail.aryGameInfo.count];
    
    [graph1 animate];
    [graph2 animate];
    
    
}

#pragma mark -
#pragma mark Chat
- (UIView *)customDetailView{
    
    UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor blueColor];
    label.backgroundColor=[UIColor whiteColor];
    label.layer.borderColor=label.textColor.CGColor;
    label.layer.borderWidth=.5;
    label.layer.cornerRadius=label.width*.5;
    label.adjustsFontSizeToFitWidth=YES;
    label.clipsToBounds=YES;
    
    return label;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
