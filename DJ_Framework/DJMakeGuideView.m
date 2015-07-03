//
//  DJMakeGuideView.m
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJMakeGuideView.h"

@implementation DJMakeGuideView

//创建标记plist
-(void)createTheGuideViewPlistAction:(BOOL)tagblf
{
    if (tagblf)
    {
        //获取路径对象
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        //获取完整路径
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"guideNew.plist"];
        
        //设置属性值
        NSMutableDictionary *dictplist = [[NSMutableDictionary alloc ] init];
        [dictplist setObject:@"1" forKey:@"openShow"];
        [dictplist setObject:@"1" forKey:@"upstream"];
        [dictplist setObject:@"1" forKey:@"newProConcern"];//推荐关注
        [dictplist setObject:@"1" forKey:@"discover"];
        [dictplist setObject:@"1" forKey:@"myself"];
        [dictplist setObject:@"1" forKey:@"newGuest"];
        [dictplist setObject:@"1" forKey:@"newProduct"];
        
        //写入文件
        [dictplist writeToFile:plistPath atomically:YES];
    }
}
-(void)getTheFristActionTabDic:(NSDictionary*)tabDic ImgRectArr:(NSArray*)imgRectArr
{
    [self setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
    
}
//修改plist
-(void)changeTheGuideViewPlistAction:(NSString*)keyName
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"guideNew.plist"];
    NSMutableDictionary *applist = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    [applist setObject:@"2" forKey:keyName];
    [applist writeToFile:path atomically:YES];
}
//删除所有视图
-(void)removeTheAllViewAndChangeThePlist:(NSString*)keyName
{
    [UIView animateWithDuration:1.2 animations:^{
        
        [self setAlpha:0];
        
    } completion:^(BOOL finished){
        
        [self changeTheGuideViewPlistAction:keyName];
        [self removeFromSuperview];
        
        
    }];
}
@end
