//
//  DJDBQueueManager.h
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface DJDBQueueManager : NSObject

+(instancetype)defaultManager;

///**
// 上游供应商列表
// */
//-(void)db_updateUpSupplierList:(OKWUpSupplierListModel *)upModel completedBlock:(void (^)(BOOL isSuccess))completedBlock;
//-(OKWUpSupplierListModel *)upSupplierModelWithWeiNo:(NSString *)weiNo;
//-(void)db_deleteAllDataUpSupplierModelWith:(NSString *)weiNo;



@end
