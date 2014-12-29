//
//  Theam.m
//  zhaopin
//
//  Created by wujin on 13-10-18.
//  Copyright (c) 2013年 zhaopin.com. All rights reserved.
//

#import "Theam.h"
@interface NavigationTitleLabel:UIView
@end

@implementation NavigationTitleLabel

//-(CGSize)sizeThatFits:(CGSize)size
//{
//	return CGSizeMake(320-108, size.height);
//}

@end

@implementation Theam

- (id)init
{
    self = [super init];
    if (self) {
        [self globalConfig];
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+(Theam*)currentTheam
{
	static Theam *theam;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		theam=[[Theam alloc] init];
	});
	return theam;
}

-(void)globalConfig
{
	//导航条背景
 
    if (isIOS7) {
        [[UINavigationBar appearance] setBackgroundImage:IMG(@"bg_title2") forBarMetrics:UIBarMetricsDefault];   
    }else{
		[[UINavigationBar appearance] setBackgroundImage:IMG(@"bg_title") forBarMetrics:UIBarMetricsDefault];
    }
    
   

    
}

-(UIFont*)navigationBarItemFont
{
	return [UIFont CustomFontGBKSize:15];
}

-(UIColor*)navigationBarItemTitleColor
{
	return [UIColor whiteColor];
}


-(UIView*)navigationTitleViewWithTitle:(NSString *)title
{
    UIView *navView = [[NavigationTitleLabel alloc] initWithFrame:CGRectMake(0, 0, 320-148-32, 44)];
	UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320-148-32, 44)];
	label.backgroundColor=[UIColor clearColor];
	label.textColor=[UIColor lightGrayColor];
	label.text=title;
    label.adjustsFontSizeToFitWidth = YES;
    label.font=[UIFont CustomFontGBKSize:17];
    label.textAlignment=NSTextAlignmentCenter;
    [label SetCustomFontGBKSize:20];
    /* 多行换行的实现
     label.numberOfLines = 0;
     CGRect rect = [NSString heightForString:title Size:CGSizeMake(200, 44) Font:[UIFont boldSystemFontOfSize:18] Lines:2];
     if (rect.size.height>40) {
     label.width -= 20;
     label.originX = 10;
     label.font=[UIFont boldSystemFontOfSize:14];
     }
     */
    
    label.lineBreakMode = NSLineBreakByTruncatingMiddle;
    //	label.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    
    [navView addSubview:label];
	return navView;
}

-(UIBarButtonItem*)navigationBarRightButtonItemWithImage:(UIImage *)image Title:(NSString *)title Target:(id)target Selector:(SEL)sel
{
	UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
	[btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
	btn.titleLabel.font=[Theam currentTheam].navigationBarItemFont;
	[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[btn setTitle:title forState:UIControlStateNormal];
	[btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
	[btn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    if (image) {
        btn.frame=CGRectMake(0, 0, 24, 24);
    }else{
        if (title.length ==4) {
            btn.frame=CGRectMake(0, 0, 60, 44);
        }else{
            btn.frame=CGRectMake(0, 0, 40, 40);
        }
    }
	//让图片在最右侧对齐
	CGSize imagesize=image.size;
	imagesize.width=imagesize.width/2;
	imagesize.height=imagesize.height/2;
	CGSize btnsize=btn.size;
	
	//iOS7下面导航按钮会默认有10px间距
	UIEdgeInsets insets=UIEdgeInsetsMake((btnsize.height-imagesize.height)/2, btnsize.width-imagesize.width, (btnsize.height-imagesize.height)/2, 0);
	[btn setImageEdgeInsets:insets];
	btn.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithCustomView:btn];
	CGRect textFrame=[btn.titleLabel textRectForBounds:btn.bounds limitedToNumberOfLines:1];
	//iOS7上会有10px间距，所以将label的右边距+10
	if (DeviceSystemSmallerThan(7.0)) {
		[btn setTitleEdgeInsets:UIEdgeInsetsMake(0, btn.width-10-textFrame.size.width, 0, 10)];
	}
	return item;
}

-(UIBarButtonItem*)navigationBarLeftButtonItemWithImage:(UIImage *)image Title:(NSString *)title Target:(id)target Selector:(SEL)sel
{
	UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    btn.tag = 200;
	[btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
	btn.titleLabel.font=[Theam currentTheam].navigationBarItemFont;
	[btn setTitleColor:[Theam currentTheam].navigationBarItemTitleColor forState:UIControlStateNormal];
	[btn setTitle:title forState:UIControlStateNormal];
	[btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
	[btn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
	btn.frame=CGRectMake(0, 0, 44, 44);
    if (image) {
        btn.frame=CGRectMake(0, 0, 20, 20);
    }else{
        if (title.length ==4) {
            btn.frame=CGRectMake(0, 0, 60, 44);
        }else{
            btn.frame=CGRectMake(0, 0, 40, 40);
        }
    }

	//让图片在最右侧对齐
	CGSize imagesize=image.size;
	imagesize.width=imagesize.width/2;
	imagesize.height=imagesize.height/2;
	CGSize btnsize=btn.size;
	
	//iOS7下面导航按钮会默认有10px间距
	UIEdgeInsets insets=UIEdgeInsetsMake((btnsize.height-imagesize.height)/2, btnsize.width-imagesize.width, (btnsize.height-imagesize.height)/2, 0);
	[btn setImageEdgeInsets:insets];
	btn.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithCustomView:btn];
	
    
    //	CGRect textFrame=[btn.titleLabel textRectForBounds:btn.bounds limitedToNumberOfLines:1];
	//iOS7上会有10px间距，所以将label的右边距+10
	if (DeviceSystemSmallerThan(7.0)) {
		[btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
	}
	return item;
}

-(UIBarButtonItem*)navigationBarButtonBackItemWithTarget:(id)target Selector:(SEL)sel
{
	UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
	[btn setImage:IMG(@"icon_back_default") forState:UIControlStateNormal];
	[btn setImage:IMG(@"icon_back") forState:UIControlStateHighlighted];
	[btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
	[btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
	[btn setTitleColor:[Theam currentTheam].navigationBarItemTitleColor forState:UIControlStateNormal];
	btn.titleLabel.font=[Theam currentTheam].navigationBarItemFont;
	btn.frame=CGRectMake(0, 0, 60, 20);
	UILabel *lb=[[UILabel alloc] init];
    if (isIOS7) {
        lb.frame = CGRectMake(25, -1, 40, 22);
    }else{
        
        lb.frame = CGRectMake(15, -1, 40, 22);
    }
    
	if (!DeviceSystemSmallerThan(7.0)) {
		lb.originX-=10;
	}
    lb.text = @"返回";
	lb.font=[Theam currentTheam].navigationBarItemFont;
	lb.textColor=self.navigationBarItemTitleColor;
	lb.textAlignment=NSTextAlignmentLeft;
	lb.backgroundColor=[UIColor clearColor];
	lb.userInteractionEnabled=NO;
	[btn addSubview:lb];
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithCustomView:btn];
	return item;
}

-(UIFont*)labelFontTitle1
{
	return [UIFont CustomFontGBKSize:15];
}
-(UIFont*)labelFontTitle2
{
	return [UIFont CustomFontGBKSize:14];
}
-(UIFont*)labelFontContent
{
	return [UIFont CustomFontGBKSize:12];
}
-(UIFont *)labelFontChatBig
{
    return [UIFont CustomFontGBKSize:18];
}
-(UIFont *)labelFontChatText
{
    return [UIFont CustomFontGBKSize:16];
}
-(UIFont *)labelFontPromot
{
    return [UIFont CustomFontGBKSize:14];
}
@end
