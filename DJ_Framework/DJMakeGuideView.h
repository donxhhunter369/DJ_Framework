//
//  DJMakeGuideView.h
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJMakeGuideView : UIView

//创建标记plist
-(void)createTheGuideViewPlistAction:(BOOL)tagblf;
-(void)getTheFristActionTabDic:(NSDictionary*)tabDic ImgRectArr:(NSArray*)imgRectArr;
-(void)changeTheGuideViewPlistAction:(NSString*)keyName;
@end
