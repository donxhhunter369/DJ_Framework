//
//  DJURLConfig.h
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#ifndef DJ_Framework_DJURLConfig_h
#define DJ_Framework_DJURLConfig_h

static NSString * const AppStore_AppID = @"897046858";

//#define DJ_DEBUG
#ifdef DJ_DEBUG //DEBUG

static NSString * const URL_BASE                    = @"http://api.okwei.net";
#define URL_BASE_API [NSString stringWithFormat:@"%@%@", URL_BASE, @"/api/v3/"]
#else
static NSString * const URL_BASE                    = @"https://api.okwei.com";
#define URL_BASE_API [NSString stringWithFormat:@"%@%@", URL_BASE, @"/api/v3/"]

#endif

#define URL_GET_API(x) [NSString stringWithFormat:@"%@%@", URL_BASE_API, x]
//#define URL_BASE_UPLOADIMAGE_API                    @"http://fdfsservice.okwei.net/handle/UploadImg.ashx"
//系统消息
static NSString * const URL_SystemMessage           = @"Mine/GetPushMsgList";

#endif
