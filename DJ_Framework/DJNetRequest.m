//
//  DJNetRequest.m
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJNetRequest.h"

@implementation DJNetRequest

#pragma mark - 例子
//关注接口
+(void)requestForAttentionWithCate:(NSString *)cate WithSup_id:(NSString *)sup_id WithSuccessed:(Successed)successed Failure:(Failure)failure{
//    OKWAccount * account = [OKWAccountTool shareInstance].account;
//    NSString *urlString = [NSString stringWithFormat:@"%@%@",URL_BASE_API,URL_Attention];
//    
//    NSDictionary *httpGetPara;
//    if (account.tiket != nil) {
//        httpGetPara = @{@"tiket": account.tiket,
//                        @"cate":cate,
//                        @"sup_id":[NSString stringWithFormat:@"%@",sup_id]};
//    }else{
//        failure(nil);
//    }
    
    /**/  //打印链接
    //    NSMutableString * str = [NSMutableString stringWithFormat:@"%@?",urlString];
    //    for (NSString * key in [httpGetPara allKeys]) {
    //        [str appendString:[NSString stringWithFormat:@"%@=%@&",key,httpGetPara[key]]];
    //    }
    //    NSLog(@"str =+= %@",str);
    
//    [DJHttpTool httpGet:urlString parameters:httpGetPara success:^(id responseObject) {
//        successed([DJAnalyzer analyzeAttentionWihtDic:responseObject]);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
}

@end
