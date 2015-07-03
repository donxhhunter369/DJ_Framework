//
//  DJUserConfig.h
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJUserConfig : NSObject

+ (instancetype)shareInstance;

#pragma mark 存储版本号
-(void)saveOkweiAppVersion:(NSString*)okweiAppVersion;
-(NSString*)getOkweiAppSavedVersion;
//退出清理
-(void)logoutClean;

@end
