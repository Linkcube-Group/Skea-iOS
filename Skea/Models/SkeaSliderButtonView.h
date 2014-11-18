//
//  SkeaSliderButtonView.h
//  Skea
//
//  Created by yuyang on 14/11/15.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SkeaSliderButtonViewDelegate <NSObject>

@required

-(void)sliderClickWithTag:(NSInteger)tag index:(NSInteger)index;

@end

@interface SkeaSliderButtonView : UIView

@property (nonatomic) NSInteger tager;                           //tag值
@property (nonatomic,strong) NSString * title;                   //标题
@property (nonatomic,strong) NSArray * selectedStringsArray;     //选项数组
@property (nonatomic,strong) NSString * noticeImageName;         //提示的图标
@property (nonatomic,strong) NSString * notice;                  //提示
@property (nonatomic) id<SkeaSliderButtonViewDelegate>delegate;  //代理
@property (nonatomic) NSInteger selectedIndex;                   //默认位置

@end
