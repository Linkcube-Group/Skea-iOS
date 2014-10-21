//
//  ViewController.m
//  Skea
//
//  Created by mosn on 9/30/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "ViewController.h"
#import "InfoViewController.h"
#import "GameViewController.h"
#import "LoginViewController.h"
#import "PersonViewController.h"
#import "RecordViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:@"Day 1"];
    self.navigationItem.rightBarButtonItem = [[Theam currentTheam] navigationBarRightButtonItemWithImage:IMG(@"bluetooth-disconnected.png") Title:nil Target:self Selector:@selector(connectAction:)];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Action
- (void)connectAction:(id)sender
{
    
}

#pragma mark - info按钮

- (IBAction)infoAction:(id)sender
{
    InfoViewController *ivc = [[InfoViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ivc];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - 游戏按钮

- (IBAction)gameAction:(id)sender
{
    GameViewController *gvc = [[GameViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:gvc];
    [self presentViewController:nav animated:YES completion:nil];

}

#pragma mark - record按钮

- (IBAction)recordAction:(id)sender
{
    RecordViewController *rvc = [[RecordViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rvc];
    [self presentViewController:nav animated:YES completion:nil];

}

#pragma mark - 设置按钮

- (IBAction)settingAction:(id)sender
{
    LoginViewController *lvc = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lvc];
    [self presentViewController:nav animated:YES completion:nil];

}

@end
