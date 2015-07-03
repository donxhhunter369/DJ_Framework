//
//  AppDelegate.h
//  DJ_Framework
//
//  Created by okwei on 15/7/2.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,assign ) BOOL bIsFirstRun;//是否第一次启动
@property (nonatomic,assign ) BOOL isTimeOut;//判断是否超时登陆

@end

