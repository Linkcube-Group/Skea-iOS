//
//  SKRefreshTableFooterView.h
//  tempSKTableViewController
//
//  Created by yuyang on 14/10/25.
//  Copyright (c) 2014年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SKPullRefreshStatePulling = 0,
    SKPullRefreshStateNormal,
    SKPullRefreshStateLoading,
} SKPullRefreshState;

typedef enum {
    SKPullRefreshStyleBlack = 0,
    SKPullRefreshStyleWhite
} SKPullRefreshStyle;

@protocol SKRefreshTableFooterDelegate;

@interface SKRefreshTableFooterView : UIView

@property (nonatomic, assign) id <SKRefreshTableFooterDelegate> delegate;
@property (nonatomic, assign) SKPullRefreshStyle style;
@property (nonatomic, assign) SKPullRefreshState state;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

- (void)skRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)skRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)skRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end

@protocol SKRefreshTableFooterDelegate <NSObject>

- (void)skRefreshTableFooterDidTriggerRefresh:(SKRefreshTableFooterView *)view;
- (BOOL)skRefreshTableFooterDataSourceIsLoading:(SKRefreshTableFooterView *)view;

@end
