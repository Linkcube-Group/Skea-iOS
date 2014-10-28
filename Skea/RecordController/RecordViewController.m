//
//  RecordViewController.m
//  Skea
//
//  Created by mosn on 10/7/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "RecordViewController.h"
#import "CalendarView.h"

@interface RecordViewController ()<CalendarDelegate>
{
    CalendarView *_sampleView;
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
    
    // Do any additional setup after loading the view from its nib.
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
