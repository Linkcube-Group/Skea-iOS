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
}
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
    
    _sampleView= [[CalendarView alloc]initWithFrame:CGRectMake(0, (ScreenHeight-320), 320, 320)];
    _sampleView.delegate = self;
    [_sampleView setBackgroundColor:[UIColor whiteColor]];
    _sampleView.calendarDate = [NSDate date];
    [self.view addSubview:_sampleView];
    _sampleView.hidden = YES;
    
    ////////////////////////////////////////////////////////////////////
    graph1=[[MPGraphView alloc] initWithFrame:CGRectMake(0, 300, 320, 150)];
    graph1.waitToUpdate=YES;
    
    [graph1 setAlgorithm:^CGFloat(CGFloat x) {
        return rand() % 100;
    } numberOfPoints:20];
    
    graph1.curved=YES;
    
    graph1.graphColor=[UIColor colorWithRed:0.500 green:0.158 blue:1.000 alpha:1.000];
    graph1.detailBackgroundColor=[UIColor colorWithRed:0.444 green:0.842 blue:1.000 alpha:1.000];
    
    graph2=[MPPlot plotWithType:MPPlotTypeBars frame:graph1.frame];
    graph2.waitToUpdate=YES;
    graph2.detailView=(UIView <MPDetailView> *)[self customDetailView];
    [graph2 setAlgorithm:^CGFloat(CGFloat x) {
        return rand() % 100;
    } numberOfPoints:20];
    graph2.graphColor=[UIColor blueColor];
    [self.view addSubview:graph2];
    
    [self.view addSubview:graph1];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(animate) withObject:nil afterDelay:0.3];
    
}

- (void)animate{
    
    [graph1 animate];
    [graph2 animate];
    
}

- (void)dateActoin
{
    _sampleView.hidden = NO;
}

-(void)tappedOnDate:(NSDate *)selectedDate
{
    _sampleView.hidden = YES;
    NSLog(@"tappedOnDate %@(GMT)",selectedDate);
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
