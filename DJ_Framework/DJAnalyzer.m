//
//  DJAnalyzer.m
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJAnalyzer.h"

@implementation DJAnalyzer

#pragma mark - 例子
//新版产品管理
+(id)analyzeNewProductManagerPageWithDic:(NSDictionary *)dic{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    NSString *netStatu = [NSString stringWithFormat:@"%@",dic[@"Statu"]];
//    if (netStatu.integerValue == 1) {
//        if ([dic[@"BaseModle"] isKindOfClass:[NSDictionary class]]) {
//            if ([dic[@"BaseModle"][@"productList"] isKindOfClass:[NSArray class]]) {
//                for (NSDictionary * subDic in dic[@"BaseModle"][@"productList"]) {
//                    OKWProductManagerModel * productManagerModel = [[OKWProductManagerModel alloc] init];
//                    productManagerModel.proNo = OutNULL(subDic[@"proNo"]);
//                    [array addObject:productManagerModel];
//                }
//            }
//        }
//    }else if (netStatu.integerValue == -1){
//        [AppDelegateOBJ restartWithReason:YES];
//    }else{
//        if ([dic[@"StatusReson"] isKindOfClass:[NSString class]]) {
//            [DJUtilities showTextHUD:dic[@"StatusReson"] andView:AppDelegateOBJ.window maintainTime:1.0];
//        }
//    }
    return array;
}

@end
