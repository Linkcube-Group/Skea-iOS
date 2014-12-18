//
//  AboutViewController.m
//  Skea
//
//  Created by yuyang on 14/12/18.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:NSLocalizedString(@"关于我们", nil)];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"menu_action_back_white.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    self.view.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    
    UIImageView * imageView1 = [[UIImageView alloc] init];
    imageView1.frame = CGRectMake(60, 60, self.view.frame.size.width - 120, 80);
    imageView1.image = [UIImage imageNamed:@"logo1.png"];
    [self.view addSubview:imageView1];
    
    UIImageView * imageView2 = [[UIImageView alloc] init];
    imageView2.frame = CGRectMake(130, 180, self.view.frame.size.width - 260, 40);
    imageView2.image = [UIImage imageNamed:@"logo2.png"];
    [self.view addSubview:imageView2];
    
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 220, self.view.frame.size.width, 30);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:16.f];
    label.textAlignment = NSTextAlignmentCenter;
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString* versionNum =[infoDict objectForKey:@"CFBundleVersion"];
    label.text = [NSString stringWithFormat:@"Ver %@",versionNum];
    [self.view addSubview:label];
    
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
