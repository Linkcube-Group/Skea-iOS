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
    
    int lineTop;
    
    int score;//得分
    BOOL getHighed; //已经拿到最高分
    
    int  totalTime;
    int  passTime;
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
    score = 0;
    lineTop = self.imgLine.originY;
    currentIndex = -1;
    self.aryGame = [[NSMutableArray alloc] init];
    int level = 4;
    self.playTime = 0;
    halfResponse = 0;
    self.twoNum = [self getLevelNum:level];
    self.sevenNum = [self getLevelNum:level];
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
{
    if (totalTime-passTime/10<0) {
        self.lbTime.text = @"0";
        [self stopGame];
        if (currentIndex<self.aryGame.count && [[self.aryGame objectAtIndex:currentIndex] isCaled]==NO){
            score += [self getGameScore:currentIndex];
            [[self.aryGame objectAtIndex:currentIndex] setIsCaled:YES];
            self.lbScore.text = _S(@"%d",score);
        }
        return;
    }
    
    passTime++;
    
    
    self.lbTime.text = [self getGameTime:totalTime-passTime/10];
   
    self.imgStatus.image = nil;
    
    if ((int)[self.aryGame count]<=currentIndex) {
        return;
    }
    DLog(@"-%d===%d",totalLength+lineTop,currentIndex);
    
    if (currentIndex+1<self.aryGame.count && abs([[self.aryGame objectAtIndex:currentIndex+1] beginPoint]-totalLength-lineTop-20)<2) {
        currentIndex = currentIndex +1;
        self.playTime = 0;
        getHighed = NO;
        
    }
    
    if (currentIndex>=1 && currentIndex<self.aryGame.count) {
        self.playTime +=1;
        if (self.playTime/10<=[[self.aryGame objectAtIndex:currentIndex] progressTime]) {
            if (self.playTime%5==0) {
                ///info.ary add object
                if (currentIndex>=0) {
                    [[[self.aryGame objectAtIndex:currentIndex] halfScroes] addObject:@(halfResponse)];
                    
                }
                halfResponse = 0;
            }
            else if (self.playTime<5 && !getHighed) {
                ///high
                if (halfResponse>1) {
                    getHighed = YES;
                    self.imgStatus.image = IMG(@"text-perfect.png");
                    if (self.playTime<3) {
                        score += 50;
                    }
                    else{
                        score += 20;
                    }
                    
                    self.lbScore.text = _S(@"%d",score);
                }
                
            }

        }
        else if (currentIndex>1 && [[self.aryGame objectAtIndex:currentIndex-1] isCaled]==NO){
            score += [self getGameScore:currentIndex-1];
            self.lbScore.text = _S(@"%d",score);
            [[self.aryGame objectAtIndex:currentIndex-1] setIsCaled:YES];
        }
    }
    
    
   
   
    
    totalLength -= 4;
   
    
    
    
    [self.scrollView setContentOffset:CGPointMake(0.0, totalLength) animated:YES];
    [self.scrollBg setContentOffset:CGPointMake(0.0, totalLength) animated:YES];
    
}
#pragma mark -
#pragma mark Game Init
- (void)setupGameView
{
    int bottom = 40*3; //3s
    int topleft = ScreenHeight;
    

    
    int contentY = self.twoNum*(TwoHeight+SepHeight);
    contentY += self.sevenNum*(SevenHeight+2*SepHeight);
    contentY += self.twelfthNum*(TwelfthHeight+3*SepHeight);
    
   

    totalLength = contentY+bottom+topleft;
    totalLength = totalLength+(totalLength%4);
    
    totalTime = totalLength/40;
    passTime = 0;
    
    self.lbTime.text = [self getGameTime:totalTime];
    
    self.scrollView.contentSize = CGSizeMake(80, totalLength);
    self.scrollBg.contentSize = CGSizeMake(80, totalLength);
    

    totalLength -= bottom;
    int gsecond = [self getGameSecond];
    int top = totalLength-[self imageLength:gsecond];
    while (gsecond>0) {
        int left = [self getSepLength:gsecond];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, top, 80, [self imageLength:gsecond])];
        img.image = IMG(_S(@"bar_%d.png",gsecond));
        [self.scrollView addSubview:img];
        
        UIImageView *imgh = [[UIImageView alloc] initWithFrame:CGRectMake(0, top, 80, [self imageLength:gsecond])];
        imgh.image = IMG(_S(@"bar_%ds.png",gsecond));
        [self.scrollBg addSubview:imgh];
        
        ///add to ary
        GameInfo *info = [[GameInfo alloc] initGameInfo:img.originY+img.height-BlankBottom WithProgress:gsecond];
        DLog(@"--beging:%d",info.beginPoint);
        [self.aryGame addObject:info];
        
        gsecond = [self getGameSecond];
        top = top-[self imageLength:gsecond]-left;
    }
    
    [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentSize.height-bottom)];
    [self.scrollBg setContentOffset:CGPointMake(0, self.scrollBg.contentSize.height-bottom)];
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


- (int)getGameScore:(int)index
{
    GameInfo *info = [self.aryGame objectAtIndex:index];
    
    
    return 0;
}

- (NSString *)getGameTime:(int)length
{
    int minute = length/60;
    int second = length%60;
    return _S(@"%d:%d",minute,second);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
