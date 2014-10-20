//
//  GameViewController.m
//  Skea
//
//  Created by mosn on 10/7/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
{
    int totalLength;
}

@property (nonatomic) int twoNum;
@property (nonatomic) int fiveNum;
@property (nonatomic) int twelfthNum;

@property (strong,nonatomic) NSTimer *timerGame;

@property (strong,nonatomic) IBOutlet UILabel *lbTime;
@property (strong,nonatomic) IBOutlet UILabel *lbScore;
@property (strong,nonatomic) IBOutlet UIImageView *imgStatus;
@property (strong,nonatomic) IBOutlet UIImageView *imgLine;
@property (strong,nonatomic) IBOutlet UIView *viewBottom;
@property (strong,nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation GameViewController

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
    
    totalLength = 0;
    
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:@"Skea Help"];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"back-cross.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    self.navigationItem.rightBarButtonItem = [[Theam currentTheam] navigationBarRightButtonItemWithImage:IMG(@"button-pause.png") Title:nil Target:self Selector:@selector(pauseActoin:)];
    // Do any additional setup after loading the view from its nib.
    [self.view.layer setContents:(id)[IMG(@"game-background.png") CGImage]];
    
    
    int count = self.twoNum+self.fiveNum+self.twelfthNum;
    int contentY = count*75;
    contentY += self.twoNum*115;
    contentY += self.fiveNum*315;
    contentY += self.twelfthNum*515;
    
    self.scrollView.contentSize = CGSizeMake(80, contentY);
    
}

- (void)setupGameInfo
{
    if (self.timerGame && [self.timerGame isValid]) {
        [self.timerGame invalidate];
    }
    
    self.timerGame = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(gameUpdate:) userInfo:nil repeats:YES];
}

- (void)stopGame
{
    if (self.timerGame && [self.timerGame isValid]) {
        [self.timerGame invalidate];
    }
}

- (void)gameUpdate:(NSTimer *)timer
{
    self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentOffset.y-10);
}

- (int)getGameSecond
{
    int i = arc4random() % 2;
    if (i==0) {
        if (self.twoNum>0) {
            self.twoNum--;
            return 2;
        }
        i++;
    }
    if (i==1) {
        if (self.fiveNum>0) {
            self.fiveNum--;
            return 5;
        }
        i++;
    }
    if (i==2) {
        if (self.twelfthNum>0) {
            self.twelfthNum--;
            return 12;
        }
    }
    
    return 0;///over
}

- (int)imageLength:(int)second
{
    if (second==2) {
        return 115;
    }
    else if (second==5){
        return 315;
    }
    else if (second==12){
        return 515;
    }
    return 0;
}

#pragma mark -
#pragma mark Action
- (void)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)pauseActoin:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
