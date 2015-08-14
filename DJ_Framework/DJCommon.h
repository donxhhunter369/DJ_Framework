//
//  DJCommon.h
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#ifndef DJ_Framework_DJCommon_h
#define DJ_Framework_DJCommon_h

#pragma mark - 预编译
#import "DJBaseNavigationController.h"
#import "DJBaseViewController.h"
#import "DJBaseTabBarController.h"
#import "DJUserConfig.h"
#import "DJUtilities.h"
#import "DJ_Precompile.h"
#import "DJ_Singleton.h"
#import "DJHttpTool.h"
#import "DJNetRequest.h"
#import "DJAnalyzer.h"

#pragma mark -
#undef	ERROR
#define ERROR( ... )


// 日志输出宏定义
#define DJDEBUG
#ifdef DJDEBUG //DEBUG
// 调试状态
#define DJLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__,   __LINE__, ##__VA_ARGS__);
#else
// 发布状态
#define DJLog(...)
#endif

#endif
