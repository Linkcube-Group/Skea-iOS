//
//  SkeaSliderButtonView.m
//  Skea
//
//  Created by yuyang on 14/11/15.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import "SkeaSliderButtonView.h"

//标题高度
#define height0 30.f
//选项高度
#define height1 20.f
//选项提示语高度
#define height2 30.f
//notice高度
#define height3 40.f
//间距
#define insert 5.f

@implementation SkeaSliderButtonView
{
    UIImageView * _bluePointImageView;
    UIView * line;
}
-(id)init
{
    if(self = [super init])
    {
        //self.frame = CGRectMake(0, 0, 100, 100);
        //默认颜色
        self.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1.f];
//        self.backgroundColor = [UIColor redColor];
        self.userInteractionEnabled = YES;
        self.selectedIndex = 0;
        _bluePointImageView = [[UIImageView alloc] init];
        _bluePointImageView.image = [UIImage imageNamed:@"scroll-bar-selection.png"];
        _bluePointImageView.userInteractionEnabled = YES;
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    NSInteger count = self.selectedStringsArray.count;
    if(count < 2)
    {
        NSLog(@"画不出来啊，亲！");
        return;
    }
    if(self.selectedIndex < 0 || self.selectedIndex > count - 1)
    {
        NSLog(@"越界了，亲！");
        return;
    }
    
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(20, insert, ScreenWidth - 40, height0);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:17.f];
    label.text = self.title;
    [self addSubview:label];
    
    //insert+height0
    
    //圆圈直径
    CGFloat cycleD = 14.f;
    //圆圈半径
    CGFloat cycleR = cycleD/2.f;
    CGFloat lineWidth = (ScreenWidth - 40 - count * cycleD)/(count - 1);
    
    line = [[UIView alloc] init];
    line.frame = CGRectMake(20, insert + height1/2.f - 0.25 + label.frame.origin.y + label.frame.size.height - 1.25, ScreenWidth - 40, 2);
    line.backgroundColor = [UIColor colorWithRed:160/255.f green:160/255.f blue:160/255.f alpha:1.f];
    line.userInteractionEnabled = YES;
    [self addSubview:line];
    
    UIImageView * leftPoint = [[UIImageView alloc] init];
    leftPoint.frame = CGRectMake(0, 0.25 - cycleR, cycleD, cycleD);
    leftPoint.image = [UIImage imageNamed:@"xiaoyuanquan.png"];
    [line addSubview:leftPoint];
    leftPoint.userInteractionEnabled = YES;
    if(self.selectedIndex == 0)
    {
        _bluePointImageView.frame = CGRectMake(-10 + cycleR + 0.25, 0.25 - 10, 20, 20);
        [line addSubview:_bluePointImageView];
    }
    
    UIImageView * rightPoint = [[UIImageView alloc] init];
    rightPoint.frame = CGRectMake(ScreenWidth - 40 - cycleD, 0.25 - cycleR, cycleD, cycleD);
    rightPoint.userInteractionEnabled = YES;
    rightPoint.image = [UIImage imageNamed:@"xiaoyuanquan.png"];
    [line addSubview:rightPoint];
    if(self.selectedIndex == count - 1)
    {
        _bluePointImageView.frame = CGRectMake(rightPoint.frame.origin.x -10 + cycleR, 0.25 - 10, 20, 20);
        [line addSubview:_bluePointImageView];
    }
    
    for(int i=0;i< count - 2;i++)
    {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake((cycleD + lineWidth) * (i + 1), 0.25 - cycleR, cycleD, cycleD);
        imageView.image = [UIImage imageNamed:@"xiaoyuanquan.png"];
        [line addSubview:imageView];
        
        if(self.selectedIndex == i + 1 && self.selectedIndex != count - 1)
        {
            _bluePointImageView.frame = CGRectMake(imageView.frame.origin.x -10 + cycleR, 0.25 - 10, 20, 20);
            [line addSubview:_bluePointImageView];
        }
        if(i + 1 != count - 1)
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor clearColor];
            btn.tag = i+1;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = CGRectMake(imageView.frame.origin.x + 10 + cycleR, insert +height0 + insert + height1/2 - 10, 20, 20);
            [self addSubview:btn];
        }
    }
    
    UIButton * btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn0.backgroundColor = [UIColor clearColor];
    btn0.tag = 0;
    [btn0 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn0.frame = CGRectMake(20 + cycleR - 10 ,insert +height0 + insert + height1/2 - 10, 20, 20);
    [self addSubview:btn0];
    
    UIButton * btnn = [UIButton buttonWithType:UIButtonTypeCustom];
    btnn.backgroundColor = [UIColor clearColor];
    btnn.tag = count - 1;
    [btnn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btnn.frame = CGRectMake(self.frame.size.width - 20 - cycleR - 10, insert +height0 + insert + height1/2 - 10, 20, 20);
    [self addSubview:btnn];
    
    // insert+height0+insert+height1
    [self addSubview:[self createLabelWithFrame:CGRectMake(0, insert + height0 +insert + height1 + insert, 20 + cycleD + 20, height2) title:[self.selectedStringsArray objectAtIndex:0]]];
    
    [self addSubview:[self createLabelWithFrame:CGRectMake(ScreenWidth - 40 - cycleD, insert + height0 +insert + height1 + insert, 20 + cycleD + 20, height2) title:[self.selectedStringsArray lastObject]]];
    
    for(int i=0;i< count - 2;i++)
    {
        [self addSubview:[self createLabelWithFrame:CGRectMake((cycleD + lineWidth) * (i + 1), insert + height0 +insert + height1 + insert, 20 + cycleD + 20, height2) title:[self.selectedStringsArray objectAtIndex:i+1]]];
    }
    
    //insert+height0+insert+height1+insert+height2
    UIImageView * noticeImageView = [[UIImageView alloc] init];
    noticeImageView.frame = CGRectMake(20, insert + height0 + insert + height1 + insert + height2 + 5, 30, 30);
    noticeImageView.image = [UIImage imageNamed:@"bookmark.png"];
    [self addSubview:noticeImageView];
    
    UILabel * noticeLabel = [[UILabel alloc] init];
    noticeLabel.frame = CGRectMake(20 + 30 + 5, insert + height0 + insert + height1 + insert + height2, ScreenWidth - 20 - 30 - 5 - 20, height3);
    noticeLabel.backgroundColor = [UIColor clearColor];
    noticeLabel.textColor = [UIColor colorWithRed:138/255.f green:199/255.f blue:222/255.f alpha:1.f];
    noticeLabel.text = self.notice.length?self.notice:@"";
    noticeLabel.font = [UIFont systemFontOfSize:11.f];
    noticeLabel.numberOfLines = 2;
    [self addSubview:noticeLabel];
    
}

-(UILabel *)createLabelWithFrame:(CGRect)rect title:(NSString *)title
{
    UILabel * label = [[UILabel alloc] init];
    label.frame = rect;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:9.f];
    label.numberOfLines = 2;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title.length?title:@"";
    return label;
}

-(void)btnClick:(UIButton *)btn
{
    NSLog(@"%ld",btn.tag);
    //圆圈直径
    CGFloat cycleD = 14.f;
    //圆圈半径
    CGFloat cycleR = cycleD/2.f;
    NSInteger count = self.selectedStringsArray.count;
    CGFloat lineWidth = (ScreenWidth - 40 - count * cycleD)/(count - 1);
    if(btn.tag == 0)
    {
        [UIView animateWithDuration:0.3 animations:^{
            _bluePointImageView.frame = CGRectMake(-10 + cycleR + 0.25, 0.25 - 10, 20, 20);
            [line bringSubviewToFront:_bluePointImageView];
        }];
    }
    else if(btn.tag == self.selectedStringsArray.count - 1)
    {
        [UIView animateWithDuration:0.3 animations:^{
            _bluePointImageView.frame = CGRectMake(ScreenWidth - 40 - cycleD -10 + cycleR, 0.25 - 10, 20, 20);
            [line bringSubviewToFront:_bluePointImageView];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            _bluePointImageView.frame = CGRectMake((cycleD + lineWidth) * (btn.tag) -10 + cycleR, 0.25 - 10, 20, 20);
            [line bringSubviewToFront:_bluePointImageView];
        }];
    }
    [_delegate sliderClickWithTag:self.tager index:btn.tag];
}


@end
