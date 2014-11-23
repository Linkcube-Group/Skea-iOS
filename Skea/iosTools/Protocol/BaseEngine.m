//
//  BaseEngine.m
//  TSOL
//
//  Created by Yang on 13-7-8.
//  Copyright (c) 2013年 tsol. All rights reserved.
//

#import "BaseEngine.h"


NSString * const kProtocolHelperLocalizedDescription = @"网络连接错误";

@implementation BaseEngine


+ (BaseEngine *)sharedEngine
{
    static dispatch_once_t pred;
    
    static BaseEngine *sharedSingleton;
    
    dispatch_once(&pred,^{sharedSingleton=[[self alloc] initSingleton];} );
    
    return sharedSingleton;
}


- (id)initSingleton
{
    if(self=[super init]){
        
        self = [[BaseEngine alloc] initWithHostName:kServerDomain customHeaderFields:nil];
        self.httpMethod = @"POST";
        self.useCached = NO;
        self.postDict = [[NSMutableDictionary alloc] init];
        self.postFileDict = [[NSMutableDictionary alloc] init];
        [self useCache];
        
        self.nonAuthorPath = @[];
    }
    return self;
}




- (MKNetworkOperation*)RunRequest:(NSMutableDictionary *)  dict
                             path:(NSString *)      path
                completionHandler:(ResponseBlock)   completionBlock
                     errorHandler:(MKNKErrorBlock)  errorBlock
                    finishHandler:(FinishBlock)     finishBlock
{
    
    MKNetworkOperation *op = [self operationWithPath:path
                                              params:dict
                                          httpMethod:self.httpMethod];
    
    
    
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        DLog(@"MKNET URL=%@",completedOperation.url);
        
        NSString *response = [completedOperation responseString];
        
        id reDict = [response objectFromJSONString];
        DLog(@"MKNET RESPONSE=%@",reDict);
        int statusCode = -1;
        
        if (reDict) {
            statusCode = [[reDict valueForKey:@"status"] intValue]; ///0-normal or none
            
            if (statusCode==100){
                completionBlock(reDict);
                reDict = nil;
            }
            
        }
        else{
            reDict = @{@"code":@"400",@"msg":@"服务器请求错误"};
        }
        
       
        
        finishBlock(reDict);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        showIndicator(NO, nil);
        error = [[NSError alloc] initWithDomain:kProtocolHelperLocalizedDescription code:201 userInfo:nil];
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
    ///完成上传后把请求体清空
//    self.httpMethod = @"GET";
    
    
    return op;
}



- (void)cancelOperation:(MKNetworkOperation *)op
{
    showIndicator(NO, nil);
    if (op && [op isExecuting]) {
        [op cancel];
    }
}
@end
