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
    BOOL isPlaying;
}

@property (nonatomic) int playTime;

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

@property (strong,nonatomic) IBOutlet UIScrollView *scrollBg;
@end


#define TwoHeight 116
#define FiveHeight 316
#define TwelfthHeight 516
#define SepHeight 58

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
    
    int level = 4;
    
    self.twoNum = [self getLevelNum:level];
    self.fiveNum = [self getLevelNum:level];
    self.twelfthNum = [self getLevelNum:level];
    
    totalLength = 0;
    isPlaying = NO;
    
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:@"Skea Help"];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"back-cross.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    self.navigationItem.rightBarButtonItem = [[Theam currentTheam] navigationBarRightButtonItemWithImage:IMG(@"button-pause.png") Title:nil Target:self Selector:@selector(pauseActoin)];
    // Do any additional setup after loading the view from its nib.
    [self.view.layer setContents:(id)[IMG(@"game-background.png") CGImage]];
    
    
    [self setupGameView];
    [self beginGame];
}

- (void)pauseActoin
{
    [self stopGame];
    IMP_BLOCK_SELF(GameViewController)
    CTAlertView *alert = [[CTAlertView alloc] initWithTitle:@"是否继续游戏？" message:nil DelegateBlock:^(UIAlertView *alert, int index) {
        if (index==0) {
            [block_self btBack_DisModal:nil];
        }
        else{
            [block_self beginGame];
        }
    } cancelButtonTitle:@"退出游戏" otherButtonTitles:@"回到游戏"];
    
    [alert show];
}

- (void)playActoin
{
    if (isPlaying) {
        [self stopGame];
    }
    else{
        [self beginGame];
    }
    
    isPlaying = !isPlaying;
}


#pragma mark -
#pragma mark Game Op
- (void)beginGame
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
{     if (self.scrollView.contentOffset.y<0) {
        [self stopGame];
        return;
    }
    [self.scrollView setContentOffset:CGPointMake(0.0, self.scrollView.contentOffset.y-58/10.0) animated:YES];
    [self.scrollBg setContentOffset:CGPointMake(0.0, self.scrollView.contentOffset.y-58/10.0) animated:YES];
}
#pragma mark -
#pragma mark Game Init
- (void)setupGameView
{
    int bottom = 50;
    int topleft = 400;
    
    int contentY = self.twoNum*(TwoHeight+SepHeight);
    contentY += self.fiveNum*(FiveHeight+2*SepHeight);
    contentY += self.twelfthNum*(TwelfthHeight+3*SepHeight);
    
    self.scrollView.contentSize = CGSizeMake(80, contentY+bottom+topleft);
    self.scrollBg.contentSize = CGSizeMake(80, contentY+bottom+topleft);
  
    
    int gsecond = [self getGameSecond];
    int top = topleft+contentY-[self imageLength:gsecond];
    while (gsecond>0) {
        int left = [self getSepLength:gsecond];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, top, 80, [self imageLength:gsecond])];
        img.image = IMG(_S(@"bar_%d.png",gsecond));
        [self.scrollView addSubview:img];
        
        UIImageView *imgh = [[UIImageView alloc] initWithFrame:CGRectMake(0, top, 80, [self imageLength:gsecond])];
        imgh.image = IMG(_S(@"bar_%ds.png",gsecond));
        [self.scrollBg addSubview:imgh];
        
        gsecond = [self getGameSecond];
        top = top-[self imageLength:gsecond]-left;
    }
    
    [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentSize.height)];
    [self.scrollBg setContentOffset:CGPointMake(0, self.scrollBg.contentSize.height)];
}

- (int)getGameSecond
{
    int i = arc4random() % 3;
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
        return TwoHeight;
    }
    else if (second==5){
        return FiveHeight;
    }
    else if (second==12){
        return TwelfthHeight;
    }
    return 0;
}

- (int)getSepLength:(int)second
{
    if (second==2) {
        return SepHeight;
    }
    else if (second==5){
        return 2*SepHeight;
    }
    else if (second==12){
        return 3*SepHeight;
    }
    return 0;
}

- (int)getLevelNum:(int)level
{
    switch (level) {
        case 1:
            return 15;
        case 2:
            return 20;
        case 3:
            return 30;
        case 4:
            return 40;
        default:
            break;
    }
    
    return 0;
}

#pragma mark -
#pragma mark Action
- (void)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
