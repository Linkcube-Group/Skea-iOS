//
//  InputViewController.m
//  Skea
//
//  Created by yuyang on 14/11/15.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "InputViewController.h"

@interface InputViewController ()

@end

@implementation InputViewController
{
    UITextField * field;
}
@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:NSLocalizedString(@"昵称", nil)];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"menu_action_back_white.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    self.navigationItem.rightBarButtonItem = [[Theam currentTheam] navigationBarRightButtonItemWithImage:nil Title:NSLocalizedString(@"保存", nil) Target:nil Selector:@selector(Done)];
    self.view.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    
    
    UIView * wView = [[UIView alloc] init];
    wView.frame = CGRectMake(0, 110, self.view.frame.size.width, 40);
    wView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:wView];
    
    field = [[UITextField alloc] init];
    field.backgroundColor = [UIColor clearColor];
    field.text = self.nickName;
    field.frame = CGRectMake(20, 110, self.view.frame.size.width - 40, 40);
    [self.view addSubview:field];
}

-(void)Done
{
    [[NSUserDefaults standardUserDefaults] setObject:field.text.length?field.text:@"" forKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_delegate inputText:field.text];
    [self dismissViewControllerAnimated:YES completion:nil];
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
