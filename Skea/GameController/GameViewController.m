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
    
    int halfResponse;
    
    int currentIndex;
}

@property (nonatomic) int playTime;

@property (nonatomic) int twoNum;
@property (nonatomic) int sevenNum;
@property (nonatomic) int twelfthNum;

@property (strong,nonatomic) NSTimer *timerGame;

@property (strong,nonatomic) IBOutlet UILabel *lbTime;
@property (strong,nonatomic) IBOutlet UILabel *lbScore;
@property (strong,nonatomic) IBOutlet UIImageView *imgStatus;
@property (strong,nonatomic) IBOutlet UIImageView *imgLine;
@property (strong,nonatomic) IBOutlet UIView *viewBottom;
@property (strong,nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong,nonatomic) IBOutlet UIScrollView *scrollBg;

@property (strong,nonatomic) NSMutableArray *aryGame;
@end


#define TwoHeight 80
#define SevenHeight 280
#define TwelfthHeight 480
#define SepHeight 40

#define BlankTop 9
#define BlankBottom 26

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
    currentIndex = -1;
    self.aryGame = [[NSMutableArray alloc] init];
    int level = 4;
    self.playTime = 0;
    halfResponse = 0;
    self.twoNum = 1; [self getLevelNum:level];
    self.sevenNum = 1;[self getLevelNum:level];
    self.twelfthNum = 1;[self getLevelNum:level];
    
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
{
    if (self.scrollView.contentOffset.y<0) {
        [self stopGame];
        return;
    }
   
    self.playTime +=1;
    if (self.playTime%5==0) {
        ///info.ary add object
        if (currentIndex>=0) {
            [[[self.aryGame objectAtIndex:currentIndex] halfScroes] addObject:@(halfResponse)];
        }
        halfResponse = 0;
    }
    
    if (currentIndex+1<[self.aryGame count]) {
        if (self.playTime%10==0 && (self.scrollView.contentSize.height-self.playTime/10*4) == [[self.aryGame objectAtIndex:currentIndex+1] beginPoint]) {
            currentIndex = currentIndex +1;
        }
    }
    
    totalLength -= 4;
    
     DLog(@"-curent - index = %d,%d",self.playTime,totalLength);
    
    [self.scrollView setContentOffset:CGPointMake(0.0, totalLength) animated:YES];
    [self.scrollBg setContentOffset:CGPointMake(0.0, totalLength) animated:YES];
    
}
#pragma mark -
#pragma mark Game Init
- (void)setupGameView
{
    int bottom = 40; //3s
    int topleft = ScreenHeight;
    
    int contentY = self.twoNum*(TwoHeight+SepHeight);
    contentY += self.sevenNum*(SevenHeight+2*SepHeight);
    contentY += self.twelfthNum*(TwelfthHeight+3*SepHeight);
    
    self.scrollView.contentSize = CGSizeMake(80, contentY+bottom+topleft);
    self.scrollBg.contentSize = CGSizeMake(80, contentY+bottom+topleft);
    
    totalLength = contentY+bottom;
    int gsecond = [self getGameSecond];
    int top = self.scrollView.contentSize.height-[self imageLength:gsecond];
    while (gsecond>0) {
        int left = [self getSepLength:gsecond];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, top, 80, [self imageLength:gsecond])];
        img.image = IMG(_S(@"bar_%d.png",gsecond));
        [self.scrollView addSubview:img];
        
        UIImageView *imgh = [[UIImageView alloc] initWithFrame:CGRectMake(0, top, 80, [self imageLength:gsecond])];
        imgh.image = IMG(_S(@"bar_%ds.png",gsecond));
        [self.scrollBg addSubview:imgh];
        
        ///add to ary
        GameInfo *info = [[GameInfo alloc] initGameInfo:img.originY+img.height-(BlankBottom) WithProgress:gsecond];
        DLog(@"--beging:%d",info.beginPoint);
        [self.aryGame addObject:info];
        
        gsecond = [self getGameSecond];
        top = top-[self imageLength:gsecond]-left;
    }
    
    [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentSize.height-ScreenHeight)];
    [self.scrollBg setContentOffset:CGPointMake(0, self.scrollBg.contentSize.height-ScreenHeight)];
}

- (int)getGameSecond
{
    int i = arc4random() % 3;
    
    while (self.twoNum+self.sevenNum+self.twelfthNum>0) {
        if (i==0) {
            if (self.twoNum>0) {
                self.twoNum--;
                return 2;
            }
            i++;
        }
        if (i==1) {
            if (self.sevenNum>0) {
                self.sevenNum--;
                return 7;
            }
            i++;
        }
        if (i==2) {
            if (self.twelfthNum>0) {
                self.twelfthNum--;
                return 12;
            }
            i = 0;
        }
    }
    
    
    return 0;///over
}

- (int)imageLength:(int)second
{
    if (second==2) {
        return TwoHeight+BlankTop+BlankBottom;
    }
    else if (second==7){
        return SevenHeight+BlankTop+BlankBottom;
    }
    else if (second==12){
        return TwelfthHeight+BlankTop+BlankBottom;
    }
    return 0;
}

- (int)getSepLength:(int)second
{
    if (second==2) {
        return SepHeight-(BlankTop+BlankBottom);
    }
    else if (second==7){
        return 2*SepHeight-(BlankTop+BlankBottom);
    }
    else if (second==12){
        return 3*SepHeight-(BlankTop+BlankBottom);
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


#pragma mark -
#pragma mark BlueTooth
///从bl收到挤压事件进行+1
- (void)didReceiveSkea
{
    halfResponse++;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
