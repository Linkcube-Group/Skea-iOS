//
//  InfoViewController.m
//  Skea
//
//  Created by mosn on 10/7/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@property (strong,nonatomic) IBOutlet UIScrollView  *scrollView;
@property (strong,nonatomic) IBOutlet UIImageView *imgView;
@end

@implementation InfoViewController

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
    
    self.navigationItem.titleView = [[Theam currentTheam] navigationTitleViewWithTitle:@"Skea Help"];
    self.navigationItem.leftBarButtonItem = [[Theam currentTheam] navigationBarLeftButtonItemWithImage:IMG(@"menu_action_back_white.png") Title:nil Target:self Selector:@selector(btBack_DisModal:)];
    
    self.scrollView.height -= 45;
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, 2320);
    self.imgView.height = 2419;
    self.imgView.originY = -70;
    self.imgView.image = IMG(NSLocalizedString(@"info_ch.png", nil));
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
