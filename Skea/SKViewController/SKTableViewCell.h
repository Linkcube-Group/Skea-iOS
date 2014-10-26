//
//  SKTableViewCell.h
//  tempSKTableViewController
//
//  Created by yuyang on 14/10/25.
//  Copyright (c) 2014年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SKTableViewCellBackgroundTypeNone,
    SKTableViewCellBackgroundTypeGroup,
    SKTableViewCellBackgroundTypeGroupTop,
    SKTableViewCellBackgroundTypeGroupMiddle,
    SKTableViewCellBackgroundTypeGroupBottom
} SKTableViewCellBackgroundType;

typedef enum {
    SKTableViewCellAccessoryTypeNone,
    SKTableViewCellAccessoryTypeDisclosureIndicator,
    SKTableViewCellAccessoryTypeSwitch
} SKTableViewCellAccessoryType;

@interface SKTableViewCell : UITableViewCell

@property (nonatomic)           SKTableViewCellBackgroundType backgroundViewType;
@property (nonatomic)           SKTableViewCellAccessoryType  accessoryViewType;

@property (nonatomic, strong)   UISwitch                        *accessorySwitch;
@property (nonatomic, strong)   UIImageView                     *accessoryImageView;

@property (nonatomic, strong)   NSString                        *badgeString;

@end
