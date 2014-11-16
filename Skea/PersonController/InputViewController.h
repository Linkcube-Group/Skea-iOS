//
//  InputViewController.h
//  Skea
//
//  Created by yuyang on 14/11/15.
//  Copyright (c) 2014年 com.dlnu.*. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol inputDelegate <NSObject>

@required

-(void)inputText:(NSString *)text;

@end

@interface InputViewController : UIViewController

@property (nonatomic,strong) NSString * nickName;

@property(nonatomic)id<inputDelegate>delegate;

@end
