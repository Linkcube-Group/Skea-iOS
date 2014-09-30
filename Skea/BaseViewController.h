//
//  BaseViewController.h
//  BossZP
//
//  Created by mosn on 4/9/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (strong,nonatomic) NSMutableArray *opHandlers;
- (void)cacelAllRequest;

@end
