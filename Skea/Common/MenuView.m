//
//  MenuView.m
//  Dasheng
//
//  Created by mosn on 9/28/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "MenuView.h"

#define MENU_TAG 9910

@implementation MenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        [self initMenuView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenu)];
        
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)initMenuView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, ScreenHeight)];
    
    view.backgroundColor = [UIColor lightGrayColor];
    
    [self addSubview:view];
    NSArray *titles = @[@"全部",@"美丽",@"大地",@"草原",@"渊源"];
    for (int i=0; i<titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(10, 100+50*i, 80, 40);
        btn.tag = MENU_TAG+i;
        [btn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    
}


- (void)selectAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    int tag = (int)btn.tag-MENU_TAG;
    [self showMenu:NO];
    BlockCallWithOneArg(self.menuHandler, @(tag))
}


#pragma mark -
#pragma mark Animation
- (void)showMenu:(BOOL)flag
{
    if (flag) {
         self.originX = -self.width;
        if ([self superview]==nil) {
            [theApp.window addSubview:self];
        }
       
        [UIView animateWithDuration:1 animations:^{
            self.originX = 0;
        }];
    }
    else{
        [UIView animateWithDuration:1 animations:^{
            self.originX = -self.width;
        } completion:^(BOOL finished) {
            if ([self superview]) {
                [self removeFromSuperview];
            }
        }];
        
    }
}

- (void)hideMenu
{
    [self showMenu:NO];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
