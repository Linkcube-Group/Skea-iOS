//
//  Theam.h
//  zhaopin
//
//  Created by wujin on 13-10-18.
//  Copyright (c) 2013年 zhaopin.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Theam : NSObject


/**
 配置全局的样式
 系统会自动调用此方法
 */
-(void)globalConfig;
/**
 返回当前默认主题
 */
+(Theam*)currentTheam;

/**
 导航条按钮字体
 */
-(UIFont*)navigationBarItemFont;


///标题字体
-(UIFont*)labelFontTitle1;
///2号标题字体
-(UIFont*)labelFontTitle2;
///内容部分字体
-(UIFont*)labelFontContent;

///聊天内容字体
-(UIFont *)labelFontChatText;

///系统消息字体
-(UIFont *)labelFontPromot;
///为了coretext 渲染时用的大字体
-(UIFont *)labelFontChatBig;
/**
 导航条字体颜色
 */
-(UIColor*)navigationBarItemTitleColor;


//-(UIColor*)table
/**
 获取能用的title
 @param title : 标题
 @return 返回标题视图
 */
-(UIView*)navigationTitleViewWithTitle:(NSString*)title;

/**
 返回程序能用的导航条按钮
 @param image : 图标
 @param title : 标题
 @param target : 点击按钮接受者
 @param sel : 点击事件
 @return 返回导航条按钮
 */
-(UIBarButtonItem*)navigationBarRightButtonItemWithImage:(UIImage*)image Title:(NSString*)title Target:(id)target Selector:(SEL)sel;

/**
 返回程序能用的导航条按钮
 @param image : 图标
 @param title : 标题
 @param target : 点击按钮接受者
 @param sel : 点击事件
 @return 返回导航条按钮
 */
-(UIBarButtonItem*)navigationBarLeftButtonItemWithImage:(UIImage*)image Title:(NSString*)title Target:(id)target Selector:(SEL)sel;
/**
 返回程序通用的返回按钮
 @param target : 事件接收者
 @param sel : 事件
 @return 返回程序能用的返回按钮
 */
-(UIBarButtonItem*)navigationBarButtonBackItemWithTarget:(id)target Selector:(SEL)sel;
@end

