//
//  NSString+MJ.h
//  新浪微博
//
//  Created by apple on 13-10-27.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (OKW)

- (NSString *)fileAppend:(NSString *)append;

//去除两边空格
-(NSString *)okw_trimWhitespace;

//是否是手机号码 不严格检测
-(BOOL)is_PhoneNumber;

//是否是手机号码
-(BOOL)isPhoneNumber;

//是否全是数字
-(BOOL)isAllNumber;

//手机号码格式校验
+(BOOL)isMobileNumber:(NSString *)mobileNum;

@end
