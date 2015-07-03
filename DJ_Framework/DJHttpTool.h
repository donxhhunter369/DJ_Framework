//
//  DJHttpTool.h
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"

@interface DJHttpTool : NSObject

+(instancetype)sharedInstance;
+ (void)httpPost:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)( id responseObject))success failure:(void (^)( NSError *error))failure;

@end
