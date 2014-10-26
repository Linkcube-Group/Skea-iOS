//
//  UIImage+SKCategory.h
//  tempSKTableViewController
//
//  Created by yuyang on 14/10/25.
//  Copyright (c) 2014年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SKCategory)

///图片拉伸、平铺接口，兼容iOS5+
- (UIImage *)resizableImageWithCompatibleCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode;

///图片以ScaleToFit方式拉伸后的CGSize
- (CGSize)sizeOfScaleToFit:(CGSize)scaledSize;

///将图片转向调整为向上
- (UIImage *)fixOrientation;

///以ScaleToFit方式压缩图片
- (UIImage *)compressedImageWithSize:(CGSize)compressedSize;

@end
