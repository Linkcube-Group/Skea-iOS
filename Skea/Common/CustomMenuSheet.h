//
//  CustomMenuSheet.h
//  BossZP
//
//  Created by mosn on 5/7/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomMenuSheet : UIView

@property (nonatomic,copy) EventHandler menuHandler;
- (id)initShareWithTitles:(NSArray *)titles images:(NSArray *)imageArray Handler:(EventHandler)handler sheetTitle:(NSString *)sheetTitle;
- (id)initSeletWithTitles:(NSArray *)titles Handler:(EventHandler)handler sheetTitle:(NSString *)sheetTitle;

- (void)showMenuSheet;
@end
