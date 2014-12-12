//
//  SkeaLanguage.m
//  guojihua
//
//  Created by youku on 14/12/12.
//  Copyright (c) 2014年 YouKu. All rights reserved.
//

#import "SkeaLanguage.h"

@implementation SkeaLanguage

static SkeaLanguage *defaultManagerInstance = nil;

+ (SkeaLanguage *)defaultCenter
{
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            defaultManagerInstance = [[self alloc] init];
        });
    }
    return defaultManagerInstance;
}

-(id)init
{
    if(self = [super init])
    {
        self.languageType = ((SkeaLanguageType)[[NSUserDefaults standardUserDefaults] integerForKey:@"languageType"]);
    }
    return self;
}

-(void)setLanguageType:(SkeaLanguageType)languageType
{
    [[NSUserDefaults standardUserDefaults] setInteger:languageType forKey:@"languageType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(SkeaLanguageType)languageType
{
    return ((SkeaLanguageType)[[NSUserDefaults standardUserDefaults] integerForKey:@"languageType"]);
}

- (NSString *)myNSLocalizedString:(NSString *)key Comment:(NSString *)comment
{
    NSBundle* bundle = [NSBundle bundleWithPath:[NSString stringWithFormat:@"%@/zh-Hans.lproj",[[NSBundle mainBundle] bundlePath]]];
    NSLog(@"%d",self.languageType);
    if (self.languageType == SkeaLanguageTypeZH) {
        bundle = [NSBundle bundleWithPath:[NSString stringWithFormat:@"%@/zh-Hans.lproj",[[NSBundle mainBundle] bundlePath]]];
    }
    else if (self.languageType == SkeaLanguageTypeEN) {
        bundle = [NSBundle bundleWithPath:[NSString stringWithFormat:@"%@/en.lproj",[[NSBundle mainBundle] bundlePath]]];
    }
    
    return [bundle localizedStringForKey:key value:@"" table:nil];
}

@end
