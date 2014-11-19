//
//  BuyViewController.m
//  Skea
//
//  Created by yuyang on 14/11/13.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "BuyViewController.h"

@interface BuyViewController ()<UIWebViewDelegate>

@end

@implementation BuyViewController
{
    NSURL * _url;
}
-(id)initWithUrl:(NSURL *)url
{
    if(self = [super init])
    {
        _url = [[NSURL alloc] init];
        _url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:nil];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"menu_action_back_white.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    self.view.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.f];
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://search.jd.com/Search?keyword=%E8%BF%9E%E9%85%B7linkcube&enc=utf-8"]]];
    webView.delegate = self;
    [self.view addSubview:webView];
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
