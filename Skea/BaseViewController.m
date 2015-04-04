//
//  BaseViewController.m
//  BossZP
//
//  Created by mosn on 4/9/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "BaseViewController.h"
#import "SDImageCache.h"

@interface BaseViewController ()
@property (nonatomic,strong)NSString * strBool;
@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.opHandlers = [[NSMutableArray alloc] initWithCapacity:3];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
    
}
- (void)cacelAllRequest
{
    if (self.opHandlers) {
        for (MKNetworkOperation *op in self.opHandlers) {
            DLog(@"baseEngine release = %@",op.url);
            [[BaseEngine sharedEngine] cancelOperation:op];
        }
    }
    [self.opHandlers removeAllObjects];
}

- (void)dealloc
{
    //DLog(@"Controller dealloc = %@",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self cacelAllRequest];
    showIndicator(NO, nil);
}


@end
