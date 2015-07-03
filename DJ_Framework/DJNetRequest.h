//
//  DJNetRequest.h
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Successed)(id obj);
typedef void(^Failure)(NSError *error);


@interface DJNetRequest : NSObject

#pragma mark - 例子
//关注接口
+(void)requestForAttentionWithCate:(NSString *)cate WithSup_id:(NSString *)sup_id WithSuccessed:(Successed)successed Failure:(Failure)failure;

@end
