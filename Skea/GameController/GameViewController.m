//
//  GameViewController.m
//  Skea
//
//  Created by mosn on 10/7/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "GameViewController.h"
#import "RecordViewController.h"

@interface GameViewController ()
{
    int totalLength;
    BOOL isPlaying;
    
    ///上一少内的挤压
    int oldResponse;
    ///当前秒内的挤压
    int halfResponse;
    
    int currentIndex;
    
    int lineTop;
    
    int score;//得分
    BOOL getHighed; //已经拿到最高分
    
    int  totalTime;
    int  passTime;
}

@property (nonatomic) BOOL isFinish;

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

@property (strong,nonatomic) GameInfoList *aryGame;

@property (strong,nonatomic) GameDetail *gameDetail;
@end


#define TwoHeight 80
#define SevenHeight 280
#define TwelfthHeight 480
#define SepHeight 40

#define TwelfthTotal 429.24
#define SevenTotal 174.44
#define TwoTotal 28.14

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
    self.gameDetail = [[GameDetail alloc] init];
    score = 0;
    oldResponse = 0;
    lineTop = self.imgLine.originY;
    currentIndex = -1;
    self.aryGame = [[GameInfoList alloc] init];
    int level = [AppConfig getGameLevel];
    
    ///mark
    self.gameDetail.level = level;
    
    
    
    self.playTime = 0;
    halfResponse = 0;
    self.twoNum = [self getLevelNum:level];
    self.sevenNum = [self getLevelNum:level];
    self.twelfthNum = [self getLevelNum:level];
    
    ///mark
    self.gameDetail.heighScore = self.twoNum*TwoTotal+self.sevenNum*SevenTotal+self.twelfthNum*TwelfthTotal;
    
    totalLength = 0;
    isPlaying = NO;
    
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:@"Game"];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"button-pause.png") Title:nil Target:self Selector:@selector(pauseActoin)];
    //    self.navigationItem.rightBarButtonItem = [[Theam currentTheam] navigationBarRightButtonItemWithImage:IMG(@"button-pause.png") Title:nil Target:self Selector:@selector(pauseActoin)];
    // Do any additional setup after loading the view from its nib.
    [self.view.layer setContents:(id)[IMG(@"game-background.png") CGImage]];
    nCBUpdataShowStringBuffer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDisConnectBL:) name:kNotificationDisConnected object:nil];
    [self setupGameView];
    self.imgStatus.image = nil;
    [self beginGame];
    
    IMP_BLOCK_SELF(GameViewController)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        block_self.scrollView.hidden = NO;
    });
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.isFinish) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
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
            
            int tempScore = [self getGameScore:currentIndex];
            score += tempScore;
            [[self.aryGame objectAtIndex:currentIndex] setScoreRate:[self getGameScoreRate:currentIndex WithScore:tempScore]];
            
            self.gameDetail.factScore = score;
            [[self.aryGame objectAtIndex:currentIndex] setIsCaled:YES];
            self.lbScore.text = _S(@"%d",score);
        }
        
        self.gameDetail.aryGameInfo = self.aryGame;
        self.gameDetail.dateInterval = _S(@"%.0f",[[NSDate date] timeIntervalSince1970]/(24*60*60));
        self.gameDetail.explosive = [self.gameDetail getExplosiveScore];
        self.gameDetail.endurance = [self.gameDetail getEnduranceScore];
        [AppConfig saveGameDetail:self.gameDetail];
        [AppConfig setGameRecordDate:[[NSDate date] timeIntervalSince1970]];
        
        
        ///上传游戏记录
        [[ProtolManager shareProtolManager] sendGameData:self.gameDetail];
        
        IMP_BLOCK_SELF(GameViewController)
        CTAlertView *alert = [[CTAlertView alloc] initWithTitle:@"本次锻炼结束，可查看锻炼结果" message:nil DelegateBlock:^(UIAlertView *alert, int index) {
            if (index==0) {
                [block_self backAction:nil];
            }
            else{
                block_self.isFinish = YES;
                RecordViewController *rvc = [[RecordViewController alloc] init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rvc];
                [block_self presentViewController:nav animated:YES completion:nil];
            }
            
            
        } cancelButtonTitle:@"取消" otherButtonTitles:@"确定"];
        [alert show];
        return;
    }
    
    passTime++;
    
    
    self.lbTime.text = [self getGameTime:totalTime-passTime/10];
    
    
    
    if ((int)[self.aryGame count]<=currentIndex) {
        return;
    }
    
    if (currentIndex+1<self.aryGame.count && abs([[self.aryGame objectAtIndex:currentIndex+1] beginPoint]-totalLength-lineTop-20)<2) {
        currentIndex = currentIndex +1;
        self.playTime = 0;
        if (oldResponse==0) {
            getHighed = NO;
        }
        
        [self sendBeginToBL:[[self.aryGame objectAtIndex:currentIndex] progressTime]];
        
    }
    oldResponse = halfResponse;
    DLog(@"----%d",halfResponse);

    if (halfResponse>0) {
        [self showAnimationStar];
        self.imgLine.image = IMG(@"laser-active.png");
    }
    else{
        self.imgLine.image = IMG(@"laser-inactive.png");
    }
    if (currentIndex>=0 && currentIndex<self.aryGame.count) {
        self.playTime +=1;
        if (self.playTime/10<=[[self.aryGame objectAtIndex:currentIndex] progressTime]) {
            if (self.playTime%5==0) {
                ///info.ary add object
                if (currentIndex>=0) {
                    [[[self.aryGame objectAtIndex:currentIndex] halfScroes] addObject:_S(@"%d",halfResponse)];
                    
                }
                halfResponse = 0;
            }
            else if (self.playTime<=5 && !getHighed) {
                ///high
                if (halfResponse>1) {
                    
                    if (self.playTime<2) {
                        score += 50;
                        getHighed = YES;
                        self.imgStatus.image = IMG(@"text-perfect.png");
                    }
                    else{
                        getHighed = YES;
                        score += 20;
                        self.imgStatus.image = IMG(@"text-cool.png");
                    }
                    
                    self.imgStatus.alpha = 1;
                    IMP_BLOCK_SELF(GameViewController)
                    [UIView animateWithDuration:2 animations:^{
                        block_self.imgStatus.alpha =0;
                    }];
                    
                    self.lbScore.text = _S(@"%d",score);
                }
                
            }
            
        }
        else if (currentIndex>1 && [[self.aryGame objectAtIndex:currentIndex-1] isCaled]==NO){
            
            int tempScore = [self getGameScore:currentIndex-1];
            score += tempScore;
            [[self.aryGame objectAtIndex:currentIndex-1] setScoreRate:[self getGameScoreRate:currentIndex-1 WithScore:tempScore]];
            
            
            self.lbScore.text = _S(@"%d",score);
            [[self.aryGame objectAtIndex:currentIndex-1] setIsCaled:YES];
        }
    }
    else{
        halfResponse = 0;
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
    
    ///add time
    self.gameDetail.exerciseTime = totalTime;
    
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
    self.scrollView.hidden = YES;
    
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
            return 1;//5;
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
- (int)getGameScore:(int)index
{
    int tempScore = 0;
    GameInfo *info = [self.aryGame objectAtIndex:index];
    float serial = 0.0;
    for (int i=0; i<info.halfScroes.count; i++) {
        if ([[info.halfScroes objectAtIndex:i] intValue]>=15) {
            serial += 0.5;
        }
        else{
            if (serial>0) {
                tempScore += 2.17*serial*serial+9.73*serial;
            }
            serial = 0.0;
        }
    }
    if (serial>0) {
        tempScore += 2.17*serial*serial+9.73*serial;
    }
    
    return tempScore;
}

- (float)getGameScoreRate:(int)index WithScore:(int)tempScore
{
    GameInfo *info = [self.aryGame objectAtIndex:index];
    
    if (info.progressTime==2) {
        return 1.0*tempScore/TwoTotal;
    }
    else if (info.progressTime==7){
        return 1.0*tempScore/SevenTotal;
    }
    else if(info.progressTime==12){
        return 1.0*tempScore/TwelfthTotal;
    }
    return 0;
}

- (NSString *)getGameTime:(int)length
{
    int minute = length/60;
    int second = length%60;
    if (second<0) {
        second = 0;
    }
    return _S(@"%02d:%02d",minute,second);
}



#pragma mark -
#pragma mark BL
- (void)sendBeginToBL:(int)length
{
    switch (length) {
        case 2:
            [[bleCentralManager shareManager] sendCommand:cAppCommandRate2];
            break;
        case 7:
            [[bleCentralManager shareManager] sendCommand:cAppCommandRate3];
            break;
        case 12:
            [[bleCentralManager shareManager] sendCommand:cAppCommandRate4];
            break;
        default:
            break;
    }
    
}

- (void)didDisConnectBL:(NSNotification *)notify
{
    [self stopGame];
    IMP_BLOCK_SELF(GameViewController)
    CTAlertView *alert = [[CTAlertView alloc] initWithTitle:@"蓝牙已断开,无法继续游戏" message:nil DelegateBlock:^(UIAlertView *alert, int index) {
        
        [block_self btBack_DisModal:nil];
        
    } cancelButtonTitle:@"退出游戏" otherButtonTitles:nil];
    
    [alert show];
}

-(void)CBUpdataShowStringBuffer:(NSNotification *)notify
{
    // 未在编辑模式下更新显示
    if (notify) {
        //        NSDictionary *dict = [notify userInfo];
        //        NSString *value = [dict objectForKey:@"data"];
        //        if (StringNotNullAndEmpty(value)) {
        halfResponse++;
        //        }
    }
}

- (void)showAnimationStar
{
    int left = 1;

        int x = arc4random()%60+self.viewBottom.originX;
        int y = arc4random()%20+20+self.viewBottom.originY;
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(x,y, 0, 0)];
        img.alpha = 1;
        img.image = IMG(@"star.png");
        
        [self.view addSubview:img];
        [UIView animateKeyframesWithDuration:1.5 delay:arc4random()%10/10.0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
            img.frame = CGRectMake(x-(40*left), y-30, 46, 48);
            img.alpha = 0.2;
        } completion:^(BOOL finished) {
            [img removeFromSuperview];
        }];
        
        left = -left;
    
}


- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
