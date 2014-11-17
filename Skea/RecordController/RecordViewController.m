//
//  RecordViewController.m
//  Skea
//
//  Created by mosn on 10/7/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "RecordViewController.h"
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
@property (strong,nonatomic) IBOutlet UIImageView *imgChartBg;\
@property (strong,nonatomic) IBOutlet UIScrollView *scrollView;
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
    
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:@"Results"];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"back-cross.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    self.navigationItem.rightBarButtonItem = [[Theam currentTheam] navigationBarRightButtonItemWithImage:IMG(@"button-date.png") Title:nil Target:self Selector:@selector(dateActoin)];
    
    
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
    NSString *today = _S(@"%.0f",[[NSDate date] timeIntervalSince1970]/(24*60*60));
    
    self.gameDetail = [AppConfig getGameDetail:today];
    
    ////////////////////////////////////////////////////////////////////
    graph1=[[MPGraphView alloc] initWithFrame:CGRectMake(25, 5, 270, 207-15)];
    graph1.waitToUpdate=YES;

    
    graph1.curved=YES;
    
    graph1.graphColor=[UIColor orangeColor];
    graph1.detailBackgroundColor=[UIColor orangeColor];
    
    graph2=[MPPlot plotWithType:MPPlotTypeBars frame:graph1.frame];
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
    
    _sampleView= [[CalendarView alloc]initWithFrame:CGRectMake(0, (ScreenHeight-320)/2, 320, 300)];
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

- (void)animate{
    
    [graph1 animate];
    [graph2 animate];
    
}

- (NSString *)getGameTime:(int)length
{
    int minute = length/60;
    int second = length%60;
    return _S(@"%d:%d",minute,second);
}
- (void)dateActoin
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
        showCustomAlertMessage(@"当前日期没有训练记录");
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
    self.lbDate.text = _S(@"%@ %d",self.gameDetail.date,self.gameDetail.level);
    self.lbTotalStatus.text = [self.gameDetail getStandard];
    self.lbforceStatus.text = [self.gameDetail getExplosive];
    self.lbPersistStatus.text = [self.gameDetail getEndurance];
    self.lbScore.text = _S(@"%d",self.gameDetail.factScore);
    self.lbTime.text = [self getGameTime:self.gameDetail.gameTime];
    
    IMP_BLOCK_SELF(RecordViewController)
    
    [graph1 setAlgorithm:^CGFloat(CGFloat x) {
//        return rand()%100;
        return [[block_self.gameDetail.aryGameInfo objectAtIndex:x] scoreRate]*100;
        
    } numberOfPoints:self.gameDetail.aryGameInfo.count];
    [graph2 setAlgorithm:^CGFloat(CGFloat x) {
        //return rand()%100;
        return [[block_self.gameDetail.aryGameInfo objectAtIndex:x] progressTime]/15.0*100;
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
