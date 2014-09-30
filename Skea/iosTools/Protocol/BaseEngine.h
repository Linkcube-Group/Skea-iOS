//
//  BaseEngine.h
//  TSOL
//
//  Created by Yang on 13-7-8.
//  Copyright (c) 2013年 tsol. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKNetworkKit.h"

typedef void (^ResponseBlock)(id responseObject);
typedef void (^FinishBlock)(id responseObject);

typedef void (^DownloadBlock)(NSString *loadURL);

@interface BaseEngine : MKNetworkEngine

///是否强制刷新
@property (nonatomic) BOOL useCached;
///设置请求类型get/post
@property (strong,nonatomic) NSString *httpMethod;
@property (strong,nonatomic) NSMutableDictionary *postDict;
@property (strong,nonatomic) NSMutableDictionary *postFileDict;

@property (strong,nonatomic) NSArray *nonAuthorPath;
/// mknet请求的单例
+ (BaseEngine *)sharedEngine;

/// http请求
- (MKNetworkOperation*)RunRequest:(NSMutableDictionary *)  dict
                             path:(NSString *)      path
                completionHandler:(ResponseBlock)   completionBlock
                     errorHandler:(MKNKErrorBlock)  errorBlock
                    finishHandler:(FinishBlock)     finishBlock;


///取消当前网络请求
- (void)cancelOperation:(MKNetworkOperation *)op;
@end
