//
//  MenuView.h
//  Dasheng
//
//  Created by mosn on 9/28/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuView : UIView<UIGestureRecognizerDelegate>

@property (nonatomic,copy) EventHandler menuHandler;

- (void)showMenu:(BOOL)flag;
@end
