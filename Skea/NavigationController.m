//
//  NavigationController.m
//  BossZP
//
//  Created by mosn on 5/13/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property(nonatomic,weak) UIViewController* currentShowVC;
@end

@implementation NavigationController

-(id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        // Custom initialization
		[self setup];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
	self=[super initWithCoder:aDecoder];
	if (self) {
		[self setup];
	}
	return self;
}
-(void)setup
{
	if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
		self.interactivePopGestureRecognizer.delegate=self;
	}
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak NavigationController *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark NavDelegate
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    @synchronized(self){
        if (viewController==nil) {
            return;
        }
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
            self.interactivePopGestureRecognizer.enabled = NO;
        
        [super pushViewController:viewController animated:animated];
    }
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    @synchronized(self){
        if (self.viewControllers.count>0) {
            return [super popViewControllerAnimated:animated];
        }
        return nil;
    }
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    // Enable the gesture again once the new controller is shown
    @synchronized(self){
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
            self.interactivePopGestureRecognizer.enabled = YES;
        
        if (navigationController.viewControllers.count == 1)
            self.currentShowVC = nil;
        else
            self.currentShowVC = viewController;
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        
        return (self.currentShowVC == self.topViewController);
    }
    return YES;
}

@end
