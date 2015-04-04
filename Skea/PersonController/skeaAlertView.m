//
//  skeaAlertView.m
//  Skea
//
//  Created by volauvent on 15/4/2.
//  Copyright (c) 2015年 com.dlnu.*. All rights reserved.
//

#import "skeaAlertView.h"
#import <QuartzCore/QuartzCore.h>
#import "MPGraphView.h"
#import "MPPlot.h"
#import "MPBarsGraphView.h"
#import "SCGIFImageView.h"
#import "ProtolManager.h"
#import "SevenSwitch.h"

@interface skeaAlertView ()
{
    UIView *viewFloat;
}


@end



@implementation skeaAlertView


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
}

-(id)initWithFrame:(CGRect)rect content:(NSString *)content gifImageName:(NSString *)gifImageName
{
    if(self = [super init])
    {
        
        
        if (isIOS7) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        
        
        viewFloat = [[UIView alloc] initWithFrame:theApp.window.bounds];
        viewFloat.backgroundColor = [UIColor blackColor];
        [self.view addSubview:viewFloat];
        viewFloat.hidden = NO;
        

        viewFloat.alpha = 0;
        viewFloat.hidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            viewFloat.alpha = 0.8;
        }];
        
        UIView *roundrectAlert = [[UIView alloc] initWithFrame:rect];

        
        roundrectAlert.frame = rect;
        roundrectAlert.layer.cornerRadius = 10.f;
        roundrectAlert.userInteractionEnabled = YES;
        roundrectAlert.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:roundrectAlert];
        //        self.layer.shadowOffset = CGSizeMake(0, 2);
        //        self.layer.shadowOpacity = 0.80;
        //  self.layer.borderWidth = 0.6;
        //  self.layer.borderColor = [UIColor grayColor].CGColor;
        
        NSString* filePath = [[NSBundle mainBundle] pathForResource:gifImageName ofType:nil];
        SCGIFImageView* gifImageView = [[SCGIFImageView alloc] initWithGIFFile:filePath];
        gifImageView.backgroundColor = [UIColor clearColor];
        gifImageView.frame = CGRectMake((roundrectAlert.frame.size.width - 200)/2.f, 0 , 200, 200);
        [roundrectAlert addSubview:gifImageView];
        
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 200, roundrectAlert.frame.size.width - 20, 80);
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 10;
        label.text = content;
        label.font = [UIFont systemFontOfSize:11.f];
        label.textColor = [UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1.f];
        [roundrectAlert addSubview:label];
        
        UIView * line = [[UIView alloc] init];
        line.frame = CGRectMake(0, 279.5, roundrectAlert.frame.size.width, 0.5);
        line.backgroundColor = [UIColor grayColor];
        [roundrectAlert addSubview:line];
        
        UIButton * dissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dissButton.frame = CGRectMake(0, 280, [UIScreen mainScreen].bounds.size.width - 60, 40);
        [dissButton setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        dissButton.backgroundColor = [UIColor clearColor];
        [dissButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [dissButton setTitleColor:[UIColor colorWithRed:107/255.f green:201/255.f blue:222/255.f alpha:1.f] forState:UIControlStateHighlighted];
        dissButton.layer.cornerRadius = 10.f;
        [dissButton addTarget:self action:@selector(dismissAlert) forControlEvents:UIControlEventTouchUpInside];
        [roundrectAlert addSubview:dissButton];
        
        [self.view addSubview:roundrectAlert];
    }
    return self;
}

-(void)dismissAlert
{
    NSLog(@"-------------hahahahaahhahahahahahah");
    //viewFloat.hidden = YES;
    //[self removeFromSuperview];
    [self btBack_DisModal:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
