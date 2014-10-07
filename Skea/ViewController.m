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
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)infoAction:(id)sender
{
    InfoViewController *ivc = [[InfoViewController alloc] init];
    [self.navigationController pushViewController:ivc animated:YES];
}

- (IBAction)gameAction:(id)sender
{
    GameViewController *gvc = [[GameViewController alloc] init];
    [self.navigationController pushViewController:gvc animated:YES];
}

- (IBAction)recordAction:(id)sender
{
    RecordViewController *rvc = [[RecordViewController alloc] init];
    [self.navigationController pushViewController:rvc animated:YES];
}

- (IBAction)settingAction:(id)sender
{
    LoginViewController *lvc = [[LoginViewController alloc] init];
    [self presentViewController:lvc animated:YES completion:nil];
}

@end
