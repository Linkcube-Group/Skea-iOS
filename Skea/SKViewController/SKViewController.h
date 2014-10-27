//
//  SKViewController.h
//  tempSKTableViewController
//
//  Created by yuyang on 14/10/26.
//  Copyright (c) 2014年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

#warning 待完善

@interface SKViewController : UIViewController

///标记
@property (nonatomic)         NSUInteger       tag;
@property (nonatomic)         CGFloat          systemVersion;
///背景色
@property (nonatomic, strong) UIColor         *backgroundColor;

///父控制器
@property (nonatomic, weak) SKViewController *superViewController;
///tabBarController
//@property (nonatomic, weak) SKTabBarViewController *tabBarController;

///获取顶级控制器，优先级依次为tabBarController.navigationController、tabBarController、self.navigationController、self
@property (nonatomic, weak, readonly) UIViewController *topViewController;
///导航条
@property (nonatomic, strong) UINavigationBar *navigationBar;
///下拉菜单
//@property (nonatomic, strong) SFMenuDropDownView *menuDropDownView;

///是否显示导航栏控件
@property (nonatomic) BOOL showNavigationBar;
///是否显示导航栏返回按钮
@property (nonatomic) BOOL showBackBarButtonItem;
///是否显示导航栏编辑按钮
@property (nonatomic) BOOL showEditBarButtonItem;

///显示自定义展开菜单
@property (nonatomic) BOOL showMenuDropDownView;
///是否在页面消失时清除子视图
@property (nonatomic) BOOL shouldClearSubview;

///内容视图布局区域
@property (nonatomic, readonly) CGRect contentFrame;

- (id)initWithTag:(NSUInteger)tag;
///释放前的清除操作
- (void)willDealloc;
- (void)setupSubviews;
- (void)clearSubviews;
- (void)refreshSubviews;

///设置导航栏左侧按钮
- (void)setLeftBarButtonItems:(NSArray *)leftBarButtonItems;
///设置导航栏右侧按钮
- (void)setRightBarButtonItems:(NSArray *)rightBarButtonItems;

///*默认导航栏返回按钮*/
//- (SFBarButtonItem *)defaultBackBarButtonItem;
///*默认导航栏返回按钮*/
//- (SFBarButtonItem *)defaultBackBarButtonItemWithPush;
//- (SFBarButtonItem *)defaultBackBarButtonItem:(id)target action:(SEL)action;

///显示加载视图
- (void)showLoadingView;
///隐藏加载视图
- (void)hideLoadingView;

///弹出提示信息
- (void)postAlertWithMessage:(NSString *)message;
///弹出带图片的提示信息
- (void)postAlertWithMessage:(NSString *)message image:(UIImage *)image;

//子类选择重写 下拉菜单代理方法
//- (void)menuDropDownView:(SFMenuDropDownView *)menuDropDownView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
