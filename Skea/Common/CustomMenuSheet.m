//
//  CustomMenuSheet.m
//  BossZP
//
//  Created by mosn on 5/7/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "CustomMenuSheet.h"

#define MENUVIEW_TAG 80111
#define CELL_HEIGHT 50
#define TAG_CELL 1000

@interface CustomMenuSheet()
{
    UIView *bgView;
    BOOL isShare;
}
@end

@implementation CustomMenuSheet

- (id)initShareWithTitles:(NSArray *)titles images:(NSArray *)imageArray Handler:(EventHandler)handler sheetTitle:(NSString *)sheetTitle
{
    if ([theApp.window viewWithTag:MENUVIEW_TAG]) {
        return nil;
    }
    self = [super initWithFrame:theApp.window.bounds];
    self.menuHandler = handler;
    isShare = YES;
    if (self) {
        self.tag = MENUVIEW_TAG;
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        bgView = [[UIView alloc] initWithFrame:self.frame];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0;
        [self addSubview:bgView];
        
        UITapGestureRecognizer* singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeself)];
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [bgView addGestureRecognizer:singleRecognizer];
        
        
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, theApp.window.height - 224, 320, 224)];
        view.backgroundColor = RGBColor(245, 245, 245);
        [self addSubview:view];
        
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, 29, 113, .5)];
        line.backgroundColor = RGBColor(100, 100, 100);
        [view addSubview:line];
        UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(189, 29, 113, .5)];
        line1.backgroundColor = RGBColor(100, 100, 100);
        [view addSubview:line1];
        
        UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
        title.text = sheetTitle;
        title.backgroundColor = [UIColor clearColor];
        title.textColor = [UIColor darkGrayColor];
        [title SetCustomFontGBKSize:13];
        title.textAlignment = NSTextAlignmentCenter;
        title.center = CGPointMake(view.center.x, line.originY);
        [view addSubview:title];
        for (int i=0; i<[titles count]; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(80 * i + 15, 55, CELL_HEIGHT, CELL_HEIGHT);
            btn.tag = TAG_CELL+i;
            [btn addTarget:self action:@selector(sheetIndexClick:) forControlEvents:UIControlEventTouchUpInside];
 
            [btn setImage:IMG(imageArray[i]) forState:UIControlStateNormal];
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, CELL_HEIGHT, CELL_HEIGHT)];
            nameLabel.font = [UIFont CustomFontGBKSize:12];
            nameLabel.backgroundColor = [UIColor clearColor];
            nameLabel.text = [titles objectAtIndex:i];
            nameLabel.textColor = RGBColor(120, 120, 120);
            nameLabel.textAlignment = NSTextAlignmentCenter;
            [btn addSubview:nameLabel];
            [view addSubview:btn];
        
        }
        UIButton * btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        btnCancel.frame = CGRectMake(50, 156, 220, 40);
        [btnCancel setBackgroundImage:IMG(@"addbtn.png") forState:UIControlStateNormal];
        
        [btnCancel.titleLabel SetCustomFontGBKSize:16];
        [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        btnCancel.tag = TAG_CELL-1;
        [btnCancel addTarget:self  action:@selector(sheetIndexClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btnCancel];

    }
    return self;
}
- (id)initSeletWithTitles:(NSArray *)titles Handler:(EventHandler)handler sheetTitle:(NSString *)sheetTitle{


    if ([theApp.window viewWithTag:MENUVIEW_TAG]) {
        return nil;
    }
    self = [super initWithFrame:theApp.window.bounds];
    self.menuHandler = handler;
    isShare = NO;
    if (self) {
        self.tag = MENUVIEW_TAG;
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        bgView = [[UIView alloc] initWithFrame:self.frame];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0;
        [self addSubview:bgView];
        
        UITapGestureRecognizer* singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeself)];
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [bgView addGestureRecognizer:singleRecognizer];
        int top = theApp.window.height - titles.count * 48 - 30;
        
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, top, 320, titles.count * 48 + 30)];
        view.backgroundColor = RGBColor(245, 245, 245);
        [self addSubview:view];
        
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, 29, 104, .5)];
        line.backgroundColor = RGBColor(100, 100, 100);
        [view addSubview:line];
        UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(192, 29, 104, .5)];
        line1.backgroundColor = RGBColor(100, 100, 100);
        [view addSubview:line1];
        
        UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
        title.text = @"选择职位";
        title.textColor = [UIColor darkGrayColor];
        [title SetCustomFontGBKSize:13];
        title.textAlignment = NSTextAlignmentCenter;
        title.center = CGPointMake(view.center.x, line.originY);
        [view addSubview:title];
        
        top = 30;
        for (int i=0; i<[titles count]; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, top, 320, CELL_HEIGHT);
            top += CELL_HEIGHT;
            btn.tag = TAG_CELL+i;
            [btn addTarget:self action:@selector(sheetIndexClick:) forControlEvents:UIControlEventTouchUpInside];

            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, CELL_HEIGHT)];
            nameLabel.font = [UIFont CustomFontGBKSize:12];
            nameLabel.backgroundColor = [UIColor clearColor];
            nameLabel.text = [titles objectAtIndex:i];
            nameLabel.textColor = RGBColor(120, 120, 120);
            nameLabel.textAlignment = NSTextAlignmentLeft;
            [btn addSubview:nameLabel];
            UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, CELL_HEIGHT-.5, 300, .5)];
            line.backgroundColor = RGBColor(230, 230, 230);
            [btn addSubview:line];
            [view addSubview:btn];
            
        }

        
        
        
        
        
        
    }
    return self;
}
- (void)showMenuSheet
{
    
    self.originY = theApp.window.height;
    [theApp.window addSubview:self];
    bgView.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.originY = 0;
        
    } completion:^(BOOL finished) {
        bgView.hidden = NO;
        [UIView animateWithDuration:0.1 animations:^{
            bgView.alpha = 0.2;
        }];
        
    }];
}

- (void)sheetIndexClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    long idx = btn.tag - TAG_CELL;
    bgView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.originY = theApp.window.height;
    } completion:^(BOOL finished) {
        if ([self superview]) {
            [self removeFromSuperview];
        }
    } ];
    BlockCallWithOneArg(self.menuHandler, @(idx))
    
    
}

- (void)removeself
{
    bgView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.originY = theApp.window.height;
    } completion:^(BOOL finished) {
        if ([self superview]) {
            [self removeFromSuperview];
        }
    } ];
    BlockCallWithOneArg(self.menuHandler, @(-1))

}


@end
