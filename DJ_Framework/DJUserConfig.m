//
//  DJUserConfig.m
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJUserConfig.h"

#define DJAppVersionKey        @"DJAppVersionKey"       //保存版本号key

@implementation DJUserConfig

static DJUserConfig *shareInstance = nil;
+ (instancetype)shareInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}



#pragma mark 退出登录要清理的数据
-(void)logoutClean
{
    
}

#pragma mark 存储版本号
-(void)saveOkweiAppVersion:(NSString*)okweiAppVersion
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:DJAppVersionKey];
    [setting setObject:okweiAppVersion forKey:DJAppVersionKey];
    [setting synchronize];
}

-(NSString*)getOkweiAppSavedVersion
{
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    NSString * value = [setting objectForKey:DJAppVersionKey];
    
    return value;
}

@end
