//
//  GameViewController.m
//  Skea
//
//  Created by mosn on 10/7/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "GameViewController.h"
#import "RecordViewController.h"
#import "SCGIFImageView.h"


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
    
    UIView *pauseBackground;
    UIView *roundrectAlert;

}

@property (nonatomic) BOOL isFinish;

@property (nonatomic) int playTime;

@property (nonatomic) int twoNum;
@property (nonatomic) int sevenNum;
@property (nonatomic) int twelfthNum;

//@property (strong, nonatomic) IBOutlet UIImageView *pauseBackgroud;
@property (strong,nonatomic) NSTimer *timerGame;

@property (strong,nonatomic) IBOutlet UILabel *lbTime;
@property (strong,nonatomic) IBOutlet UILabel *lbScore;
@property (strong,nonatomic) IBOutlet UIImageView *imgStatus;
@property (strong,nonatomic) IBOutlet UIImageView *imgLine;

@property (strong,nonatomic) IBOutlet UIView *viewBottom;
@property (strong,nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong,nonatomic) IBOutlet UIScrollView *scrollBg;

@property (strong,nonatomic) IBOutlet UIImageView *imgLevel;

@property (strong,nonatomic) GameInfoList *aryGame;

@property (strong,nonatomic) GameDetail *gameDetail;
@end


#define TwoHeight 80
#define SevenHeight 280
#define TwelfthHeight 480
#define SepHeight 40


#define TwelfthTotal 479.24
#define SevenTotal 224.44
#define TwoTotal 78.14

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
    self.imgLevel.image = IMG(_S(@"gamelevel%d",level));
    
    [self creatRoundRectAlert:NSLocalizedString(@"Skea使用小贴士:\n    请将Skea如上图恰当的放入体内，并收缩盆底肌，进行挤压锻炼动作，累计正确挤压1秒钟后，将自动启动游戏!", nil) gifImageName:@"1.gif"];
    
    pauseBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    pauseBackground.backgroundColor = [UIColor colorWithRed:59/255.f green:60/255.f blue:65/255.f alpha:1.f];
    pauseBackground.alpha = 0.0;
    
    [self.navigationController.view addSubview:pauseBackground];
    [self.navigationController.view addSubview:roundrectAlert];
    
    pauseBackground.hidden = YES;
    roundrectAlert.hidden = YES;
    

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
    
    
    //[self.navigationController.view addSubview:self.pauseBackgroud];

    //    self.navigationItem.rightBarButtonItem = [[Theam currentTheam] navigationBarRightButtonItemWithImage:IMG(@"button-pause.png") Title:nil Target:self Selector:@selector(pauseActoin)];
    // Do any additional setup after loading the view from its nib.
    [self.view.layer setContents:(id)[IMG(@"game-background.png") CGImage]];
    nCBUpdataShowStringBuffer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDisConnectBL:) name:kNotificationDisConnected object:nil];
    
    [self setupGameView];
/*
    self.imgStatus.image = nil;
    IMP_BLOCK_SELF(GameViewController)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        block_self.scrollView.hidden = NO;
    });
 */
    [self firstBeginGame];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.isFinish) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)pauseGameForPractice
{
  
    
    [self stopGame];
    
    pauseBackground.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        pauseBackground.alpha = 0.8;
    }];
    
    roundrectAlert.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        roundrectAlert.alpha = 1.0;
    }];
    

    if (passTime == 5){
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(stopPractice)
                                                     name:@"CBUpdataShowStringBuffer" object:nil];
    }
    
}

- (void)stopPractice
{
    if (halfResponse ==40) //stop practice when receive 50 BT framework
    {
        
        [UIView animateWithDuration:0.3 animations:^{
            pauseBackground.alpha = 0.0;
        }];
        [UIView animateWithDuration:0.3 animations:^{
            roundrectAlert.alpha = 0.0;
        }];
        //[pauseBackground removeFromSuperview];
        //[roundrectAlert removeFromSuperview];

        [self beginGame];
    }
}

- (void)dismissPauseState
{
    [UIView animateWithDuration:0.5 animations:^{
        pauseBackground.alpha = 0.0;
    }];
    [UIView animateWithDuration:0.5 animations:^{
        roundrectAlert.alpha = 0.0;
    }];
    [pauseBackground removeFromSuperview];
    [roundrectAlert removeFromSuperview];
    
    [self beginGame];
}



- (void)pauseActoin
{
    [self stopGame];
    IMP_BLOCK_SELF(GameViewController)
    CTAlertView *alert = [[CTAlertView alloc] initWithTitle:NSLocalizedString(@"是否继续游戏？",nil) message:nil DelegateBlock:^(UIAlertView *alert, int index) {
        if (index==0) {
            [block_self btBack_DisModal:nil];
        }
        else{
            [block_self beginGame];
        }
    } cancelButtonTitle:NSLocalizedString(@"退出游戏",nil) otherButtonTitles:NSLocalizedString(@"确定", nil)];
    
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

- (void)firstBeginGame
{
    
    self.imgStatus.image = nil;
    IMP_BLOCK_SELF(GameViewController)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        block_self.scrollView.hidden = NO;
    });
    
    if (self.timerGame && [self.timerGame isValid]) {
        [self.timerGame invalidate];
    }
    self.timerGame = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(gameUpdate:) userInfo:nil repeats:YES];
    
}

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
        halfResponse = 0;
        [self stopGame];
        //if (currentIndex==self.aryGame.count && [[self.aryGame objectAtIndex:currentIndex] isCaled]==NO){
        if (currentIndex+1==self.aryGame.count ){
            self.gameDetail.factScore = score;
            [[self.aryGame objectAtIndex:currentIndex] setIsCaled:YES];
            self.lbScore.text = _S(@"%d",score);
            //NSLog(@"the last label score = %@",self.lbScore.text);
        }
        
        self.gameDetail.aryGameInfo = self.aryGame;

        self.gameDetail.dateInterval = [[NSDate date] stringDateWithFormat:@"yyyy-MM-dd"];
        self.gameDetail.explosive = [self.gameDetail getExplosiveScore];
        self.gameDetail.endurance = [self.gameDetail getEnduranceScore];
        [AppConfig saveGameDetail:self.gameDetail];
        [AppConfig setGameRecordDate:[[NSDate date] stringDateWithFormat:@"yyyy-MM-dd"]];
        
        
        ///上传游戏记录
        [[ProtolManager shareProtolManager] sendGameData:self.gameDetail];
        
        IMP_BLOCK_SELF(GameViewController)
        CTAlertView *alert = [[CTAlertView alloc] initWithTitle:NSLocalizedString(@"本次锻炼结束, 查看锻炼结果?",nil) message:nil DelegateBlock:^(UIAlertView *alert, int index) {
            if (index==0) {
                [block_self backAction:nil];
            }
            else{
                block_self.isFinish = YES;
                RecordViewController *rvc = [[RecordViewController alloc] init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rvc];
                [block_self presentViewController:nav animated:YES completion:nil];
            }
            
            
        } cancelButtonTitle:NSLocalizedString(@"取消",nil) otherButtonTitles:NSLocalizedString(@"确定",nil)];
        [alert show];
        return;
    }
    
    passTime++;
    
    if (passTime == 5) { //留下充足时间加载游戏，再进入practice状态
        [self pauseGameForPractice];
    }
    
    if (passTime == 7) { //释放两个提示视图
        [pauseBackground removeFromSuperview];
        [roundrectAlert removeFromSuperview];
    }
    
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
        
    }
    else if(self.playTime==2){
         [self sendBeginToBL:[[self.aryGame objectAtIndex:currentIndex] progressTime]];
    }
    oldResponse = halfResponse;
    //DLog(@"----%d,%d",halfResponse,currentIndex); //把收到的蓝牙数据打印出来

    if (halfResponse>1) {
        [self showAnimationStar];
        self.imgLine.image = IMG(@"laser-active.png");
    }
    else{
        self.imgLine.image = IMG(@"laser-inactive.png");
    }
    
    
    if (currentIndex>=0 && currentIndex<self.aryGame.count)
    {
        self.playTime +=1;
        if (self.playTime/10<=[[self.aryGame objectAtIndex:currentIndex] progressTime])
        {
            if (self.playTime%5==0) {
                ///info.ary add object
                if (currentIndex>=0) {
                    [[[self.aryGame objectAtIndex:currentIndex] halfScroes] addObject:_S(@"%d",halfResponse)];
                    //NSLog(@"----playTime:%d------halfResponse:%d",self.playTime,halfResponse);
                }
                halfResponse = 0;
            } else if (self.playTime<9 && !getHighed) {
                ///high
                if (halfResponse>1) {
                    
                    if (self.playTime<7 && self.playTime >4) {
                        score += 50;
                        [[self.aryGame objectAtIndex:currentIndex] setBonusPoint:50];
                        getHighed = YES;
                        self.imgStatus.image = IMG(@"text-perfect.png");
                    }
                    else{
                        getHighed = YES;
                        score += 20;
                        [[self.aryGame objectAtIndex:currentIndex] setBonusPoint:20];
                        self.imgStatus.image = IMG(@"text-cool.png");
                    }
                    
                    self.imgStatus.alpha = 1;
                    IMP_BLOCK_SELF(GameViewController)
                    [UIView animateWithDuration:2 animations:^{
                        block_self.imgStatus.alpha =0;
                    }];
                    
                    self.lbScore.text = _S(@"%d",score);
                    //NSLog(@"bonus score = %@",self.lbScore.text);
                }
            }else if (self.playTime >= 9 && self.playTime<10&& !getHighed){
                self.imgStatus.image = IMG(@"text-miss.png");
                self.imgStatus.alpha = 1;
                IMP_BLOCK_SELF(GameViewController)
                [UIView animateWithDuration:2 animations:^{
                    block_self.imgStatus.alpha =0;
                }];
            }
        }
        //else if (currentIndex>1 && [[self.aryGame objectAtIndex:currentIndex-1] isCaled]==NO){
        else if (currentIndex>=0 && [[self.aryGame objectAtIndex:currentIndex] isCaled]==NO){
    
            int tempScore = [self getGameScore:currentIndex];
            score += tempScore;
            [[self.aryGame objectAtIndex:currentIndex] setScoreRate:[self getGameScoreRate:currentIndex WithScore:tempScore]];
            self.lbScore.text = _S(@"%d",score);
            //GameInfo *infotesttest = [self.aryGame objectAtIndex:currentIndex];
            //NSLog(@"--currentIndex%d--the former%ds--labelscor=%d--Bonus=%d--ScoreRate=%f",currentIndex,infotesttest.progressTime, tempScore,infotesttest.bonusPoint,[self getGameScoreRate:currentIndex WithScore:tempScore]);

            [[self.aryGame objectAtIndex:currentIndex] setIsCaled:YES];
            
            
            if (self.playTime%5==0) {
                halfResponse = 0;
            }
        }
    }
    else{
        halfResponse = 0;

    }
    
    if(self.playTime%5==0){
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
        
        int tempValue = 8;  ///修改这个值
        ///add to ary
        GameInfo *info = [[GameInfo alloc] initGameInfo:img.originY+img.height-BlankBottom+tempValue WithProgress:gsecond];
        //DLog(@"--beging:%d",info.beginPoint);
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
- (int)getGameScore:(int)index
{
    int tempScore = 0.00;
    GameInfo *info = [self.aryGame objectAtIndex:index];
    float serial = 0.00;
    for (int i=1; i<info.halfScroes.count; i++) {
        if ([[info.halfScroes objectAtIndex:i] intValue]>=15) {
            serial += 0.50;
        }
        else{
            if (serial>0.00) {
                tempScore += 2.17*serial*serial+9.73*serial;
            }
            serial = 0.00;
        }
    }
    if (serial>0.00) {
        tempScore += 2.17*serial*serial+9.73*serial;
    }
    
    tempScore += info.bonusPoint;
    
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
    NSString *crc = [self ten2six:([self six2ten:@"25"]+[self six2ten:@"02"]+length+[AppConfig getGameRotate])];
    NSString *cmd = _S(@"2502%@%@000000%@",[self ten2six:length],[self ten2six:[AppConfig getGameRotate]],crc);
    
    [[bleCentralManager shareManager] sendCommand:cmd];
    
}

- (NSString *)ten2six:(int)num
{
    return [NSString stringWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%02x",num]];
}
- (int)six2ten:(NSString *)six
{
    return (int)strtoul([six UTF8String],0,16);
}


- (void)didDisConnectBL:(NSNotification *)notify
{
    [self stopGame];
    IMP_BLOCK_SELF(GameViewController)
    CTAlertView *alert = [[CTAlertView alloc] initWithTitle:NSLocalizedString(@"Skea断开连接,请确认蓝牙已正确连接",nil) message:nil DelegateBlock:^(UIAlertView *alert, int index) {
        
        [block_self btBack_DisModal:nil];
        
    } cancelButtonTitle:NSLocalizedString(@"退出游戏",nil) otherButtonTitles:nil];
    
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
        //NSLog(@"--In CBU, halfResponse:%d",halfResponse);

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




-(void)creatRoundRectAlert:(NSString *)content gifImageName:(NSString *)gifImageName {
    
    roundrectAlert = [[UIView alloc] initWithFrame:CGRectMake(30, 114, [UIScreen mainScreen].bounds.size.width - 60, 320)];
    roundrectAlert.layer.cornerRadius = 10.f;
    roundrectAlert.userInteractionEnabled = YES;
    roundrectAlert.backgroundColor = [UIColor whiteColor];
    roundrectAlert.alpha = 0.0;
    [self.view addSubview:roundrectAlert];
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:gifImageName ofType:nil];
    SCGIFImageView* gifImageView = [[SCGIFImageView alloc] initWithGIFFile:filePath];
    gifImageView.backgroundColor = [UIColor clearColor];
    gifImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 260)/2.f, 0 , 200, 200);
    [roundrectAlert addSubview:gifImageView];
    
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, 180,[UIScreen mainScreen].bounds.size.width - 90, 110);
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 10;
    label.text = content;
    label.font = [UIFont systemFontOfSize:11.f];
    label.textColor = [UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1.f];
    [roundrectAlert addSubview:label];
    
    UIView * line = [[UIView alloc] init];
    line.frame = CGRectMake(0, 279.5,[UIScreen mainScreen].bounds.size.width - 60, 0.5);
    line.backgroundColor = [UIColor grayColor];
    [roundrectAlert addSubview:line];
   
    UIButton * dissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dissButton.frame = CGRectMake(00, 280, [UIScreen mainScreen].bounds.size.width - 60, 40);
    [dissButton setTitle:NSLocalizedString(@"跳过锻炼环节", nil) forState:UIControlStateNormal];
    dissButton.backgroundColor = [UIColor clearColor];
    [dissButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [dissButton setTitleColor:[UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1.f] forState:UIControlStateHighlighted];
    dissButton.layer.cornerRadius = 10.f;
    [dissButton addTarget:self action:@selector(dismissPauseState) forControlEvents:UIControlEventTouchUpInside];
    [roundrectAlert addSubview:dissButton];
    
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
