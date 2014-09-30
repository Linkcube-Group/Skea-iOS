//
//  UITextField+Extension.h
//  BossZP
//
//  Created by yang Eric on 4/21/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ExtentRange)

- (NSRange) selectedRange;
- (void) setSelectedRange:(NSRange) range;

@end