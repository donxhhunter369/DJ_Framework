//
//  DJHttpTool.m
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJHttpTool.h"

@interface DJHttpTool()

@end

@implementation DJHttpTool

static DJHttpTool *shareInstance = nil;
+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}
+ (void)httpPost:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]] && [responseObject[@"Statu"] integerValue] == -1){//票据过期
            //do something...
        }else if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
