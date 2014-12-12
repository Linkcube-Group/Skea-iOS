//
//  SkeaLanguage.h
//  guojihua
//
//  Created by youku on 14/12/12.
//  Copyright (c) 2014年 YouKu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SkeaLanguageTypeEN=0,           //英语
    SkeaLanguageTypeZH=1            //汉语
}SkeaLanguageType;

@interface SkeaLanguage : NSObject

@property(nonatomic)SkeaLanguageType languageType;

+ (SkeaLanguage *)defaultCenter;
- (NSString *)myNSLocalizedString:(NSString *)key Comment:(NSString *)comment;

#undef NSLocalizedString
#define NSLocalizedString(key, comment) \
[[SkeaLanguage defaultCenter] myNSLocalizedString:(key) Comment:(comment)]

@end
