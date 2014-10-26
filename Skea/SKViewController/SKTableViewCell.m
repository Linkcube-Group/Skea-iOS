//
//  SKTableViewCell.m
//  tempSKTableViewController
//
//  Created by yuyang on 14/10/25.
//  Copyright (c) 2014年 yuyang. All rights reserved.
//

#import "SKTableViewCell.h"
#import "UIImage+SKCategory.h"

@implementation SKTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (systemVersion >= 7.0)
        {
            
            self.textLabel.backgroundColor              = [UIColor clearColor];
            self.detailTextLabel.backgroundColor        = [UIColor clearColor];
            self.textLabel.highlightedTextColor         = [UIColor whiteColor];
            self.detailTextLabel.highlightedTextColor   = [UIColor whiteColor];
        }
    }
    return self;
}

-(void)setBackgroundViewType:(SKTableViewCellBackgroundType)backgroundViewType
{
    _backgroundViewType = backgroundViewType;
    
    if (_backgroundViewType == SKTableViewCellBackgroundTypeNone) {
        self.indentationLevel = 0;
        self.backgroundView = nil;
        self.selectedBackgroundView = nil;
    } else {
        self.indentationLevel = 1;
        self.backgroundColor = [UIColor clearColor];
        
        NSString *backgroundImageName = nil;
        NSString *selectedBackgroundImageName = nil;
        switch (_backgroundViewType) {
            case SKTableViewCellBackgroundTypeGroup:
                backgroundImageName = @"cell_group_bg_nor";
                selectedBackgroundImageName = @"cell_group_bg_sel";
                break;
                
            case SKTableViewCellBackgroundTypeGroupTop:
                backgroundImageName = @"cell_group_bg_top_nor";
                selectedBackgroundImageName = @"cell_group_bg_top_sel";
                break;
                
            case SKTableViewCellBackgroundTypeGroupMiddle:
                backgroundImageName = @"cell_group_bg_mid_nor";
                selectedBackgroundImageName = @"cell_group_bg_mid_sel";
                break;
                
            case SKTableViewCellBackgroundTypeGroupBottom:
                backgroundImageName = @"cell_group_bg_btm_nor";
                selectedBackgroundImageName = @"cell_group_bg_btm_sel";
                break;
                
            default:
                break;
        }
        
        //背景
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView = backgroundView;
        
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 0.0, self.frame.size.width - 20.0, self.frame.size.height)];
        backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        backgroundImageView.image = [[UIImage imageNamed:backgroundImageName] resizableImageWithCompatibleCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0) resizingMode:UIImageResizingModeStretch];
        [backgroundView addSubview:backgroundImageView];
        
        //选中背景
        UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:backgroundView.frame];
        self.selectedBackgroundView = selectedBackgroundView;
        
        UIImageView *selectedBackgroundImageView = [[UIImageView alloc] initWithFrame:backgroundImageView.frame];
        selectedBackgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        selectedBackgroundImageView.image = [[UIImage imageNamed:selectedBackgroundImageName] resizableImageWithCompatibleCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0) resizingMode:UIImageResizingModeStretch];
        [selectedBackgroundView addSubview:selectedBackgroundImageView];
    }
}

- (void)setAccessoryViewType:(SKTableViewCellAccessoryType)accessoryViewType
{
    _accessoryViewType = accessoryViewType;
    
    self.accessoryView = nil;
    self.accessoryType = UITableViewCellAccessoryNone;
    
    if (_accessoryViewType != SKTableViewCellAccessoryTypeNone) {
        UIView *accessoryContentView = nil;
        if (_accessoryViewType == SKTableViewCellAccessoryTypeDisclosureIndicator) {
            _accessoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 10.0, self.bounds.size.height)];
            _accessoryImageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
            _accessoryImageView.contentMode = UIViewContentModeCenter;
            _accessoryImageView.image = [UIImage imageNamed:@"cell_accessory_indicator_nor"];
            _accessoryImageView.highlightedImage = [UIImage imageNamed:@"cell_accessory_indicator_sel"];
            
            accessoryContentView = _accessoryImageView;
        } else if (_accessoryViewType == SKTableViewCellAccessoryTypeSwitch) {
            _accessorySwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
            _accessorySwitch.center = CGPointMake(_accessorySwitch.frame.size.width / 2.0, self.bounds.size.height / 2.0);
            _accessorySwitch.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
            
            accessoryContentView = _accessorySwitch;
        }
        
        CGFloat rightMargin = 8.0;
        UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, accessoryContentView.frame.size.width + rightMargin, self.bounds.size.height)];
        [accessoryView addSubview:accessoryContentView];
        self.accessoryView = accessoryView;
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
