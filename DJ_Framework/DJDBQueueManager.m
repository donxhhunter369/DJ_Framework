//
//  DJDBQueueManager.m
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJDBQueueManager.h"

static NSString * const OKW_QUEUE_TABLE_UPSUPPLIER = @"OKW_QUEUE_TABLE_UPSUPPLIER";

@interface DJDBQueueManager()
@property(nonatomic,strong) FMDatabaseQueue * db;
@end

@implementation DJDBQueueManager

#define DBQueuePath @"DJ_queuedatasource.db"

static DJDBQueueManager *sharedInstance = nil;
+(id)defaultManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DJDBQueueManager alloc] init];
        sharedInstance.db = [FMDatabaseQueue databaseQueueWithPath:[sharedInstance getDatabasePath]];
        NSString * upSupplier_queue_table = [NSString stringWithFormat:@"CREATE TABLE if not exists %@ (upID INTEGER PRIMARY KEY AUTOINCREMENT,WeiID,newMsgTitle,NewMsgCount)",OKW_QUEUE_TABLE_UPSUPPLIER];
        [sharedInstance.db inDatabase:^(FMDatabase *db) {
            if (![db open]) {
                return;
            }
            [db executeUpdate:upSupplier_queue_table];
            //            NSLog(@"%@表 创建 %@",OKW_QUEUE_TABLE_UPSUPPLIER,([db executeUpdate:upSupplier_queue_table] ? @"成功" : @"失败"));
            //            NSLog(@"%@表 创建 %@",OKW_QUEUE_TABLE_DOWNUSERS,([db executeUpdate:downUsers_queue_table] ? @"成功" : @"失败"));
        }];
    });
    return sharedInstance;
}
-(NSString *)getDatabasePath
{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DBQueuePath]];
}

///**
// 上游供应商列表
// */
//-(void)db_updateUpSupplierList:(OKWUpSupplierListModel *)upModel completedBlock:(void (^)(BOOL isSuccess))completedBlock{
//    [sharedInstance.db inDatabase:^(FMDatabase *db) {
//        if (![db open]) {
//            return ;
//        }
//        NSString * resultSetString = [NSString stringWithFormat:@"select * from OKW_QUEUE_TABLE_UPSUPPLIER where WeiID = '%@'",upModel.WeiID];
//        FMResultSet * resultSet = [db executeQuery:resultSetString];
//        while ([resultSet next]) {
//            BOOL res = [db executeUpdate:@"UPDATE OKW_QUEUE_TABLE_UPSUPPLIER SET newMsgTitle=?,NewMsgCount=? WHERE WeiID=?",upModel.NewMsgTitle,[NSNumber numberWithInt:([resultSet intForColumn:@"NewMsgCount"]+1)],upModel.WeiID];
//            if (!res) {
//                NSLog(@"error when update db table");
//            }else{
//                NSLog(@"success to update db table %@",upModel.WeiID);
//            }
//            [db close];
//            if(completedBlock)completedBlock(res);
//            return ;
//        }
//        
//        BOOL res = [db executeUpdate:@"insert into OKW_QUEUE_TABLE_UPSUPPLIER (WeiID,newMsgTitle,NewMsgCount) VALUES (?,?,?)",upModel.WeiID,upModel.NewMsgTitle,[NSNumber numberWithInteger:(upModel.NewMsgCount==0?1:upModel.NewMsgCount)]];
//        [db close];
//        if(completedBlock)completedBlock(res);
//    }];
//}
//-(OKWUpSupplierListModel *)upSupplierModelWithWeiNo:(NSString *)weiNo{
//    __block OKWUpSupplierListModel * upSupplierModel = [[OKWUpSupplierListModel alloc] init];
//    [sharedInstance.db inDatabase:^(FMDatabase *db) {
//        [db open];
//        NSString * resultSetString = [NSString stringWithFormat:@"select * from OKW_QUEUE_TABLE_UPSUPPLIER where WeiID = '%@'",weiNo];
//        FMResultSet * resultSet = [db executeQuery:resultSetString];
//        
//        while ([resultSet next]) {
//            upSupplierModel.WeiID = [resultSet stringForColumn:@"WeiID"];
//            upSupplierModel.NewMsgTitle = [resultSet stringForColumn:@"newMsgTitle"];
//            upSupplierModel.NewMsgCount = [resultSet intForColumn:@"NewMsgCount"];
//        }
//        [db close];
//    }];
//    return upSupplierModel;
//}
//-(void)db_deleteAllDataUpSupplierModelWith:(NSString *)weiNo{
//    [sharedInstance.db inDatabase:^(FMDatabase *db) {
//        [db open];
//        [db executeUpdate:@"DELETE from OKW_QUEUE_TABLE_UPSUPPLIER where WeiID=?",weiNo];
//        [db close];
//    }];
//}


@end
