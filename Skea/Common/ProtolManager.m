//
//  ProtolManager.m
//  BossZP
//
//  Created by mosn on 4/28/14.
//  Copyright (c) 2014 com.dlnu.*. All rights reserved.
//

#import "ProtolManager.h"


@interface ProtolManager()

@end


@implementation ProtolManager

+ (ProtolManager *)shareProtolManager
{
    static ProtolManager * singleClient;
    static dispatch_once_t pred;
    dispatch_once(&pred,^{
        singleClient=[[self alloc] initManager];
    } );
    return singleClient;
}


- (id)initManager
{
    if (self=[super init]) {
        
    }
    return self;
}

@end