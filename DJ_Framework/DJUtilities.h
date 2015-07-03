//
//  DJUtilities.h
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface DJUtilities : NSObject

+ (instancetype)shareInstance;

#pragma mark  是否允许"接收通知"
-(void)saveAllowReceiveNotify:(BOOL)isAllowReceiveNotify;
-(BOOL)getIsAllowReceiveNotify;

#pragma mark  是否允许"开启声音"
-(void)saveOpenVioce:(BOOL)isOpenVioce;
-(BOOL)getIsOpenVioce;

#pragma mark  是否允许"开启震动"
-(void)saveAllowShake:(BOOL)isAllowShake;
-(BOOL)getIsAllowShake;

#pragma mark - 是否中文
//是否是中文
+ (BOOL)isIncludeChineseInString:(NSString*)str;

#pragma mark - json转换
//将对象转换成Json字符串
+(NSString *)jsonString:(id)object;
//转换Json 字符串
+(NSDictionary *)getObject:(NSString *)jsonString;

#pragma mark - 时间相关
//根据一个时间，返回这个时间与现在时间差的字符串 : 如: 1天前,8小时前,3分钟前 等等;
+(NSString *)stringDateFromNow:(NSDate *)date;
//根据一个NSTimeInterval 返回 还有多少时间
+(NSString *)stringNowFromTimeInterval:(NSTimeInterval)timeInterval;
/*
 世界标准之间转换当前时间
 **/
+(NSDate *)dateGMTConvertCurrentTime:(NSString *)date;
/**
 yyyy-MM-dd'T'HH:mm:ss.SSSZ 转换为yyyy-MM-dd HH:mm:ss
 */
+(NSString *)dataGMTConvertStandTime:(NSString *)date;
+(NSString *)dateSystemConvertStandTime:(NSString *)date;

#pragma mark - 判断时区是否在大陆
//判断时区是否在中国大陆
+ (BOOL)isInChina;

#pragma mark - 图片base64编码
+(NSString*)base64EncodedStringWithIconImage:(UIImage*)image;
+(NSString*)base64EncodedStringWithJPEGImage:(UIImage*)image;
+(NSString*)base64EncodedStringWithJPEGImage:(UIImage*)image WithCompressionQuality:(CGFloat) compressionQuality;
+(NSString*)base64EncodedStringWithPNGImage:(UIImage*)image;

#pragma mark - URL编码
+(NSString*)urlEncoded:(NSString*)str;
+(NSString*)urlDecoded:(NSString*)str;


#pragma mark - 图片缩放
//图片缩放到指定大小尺寸
+(UIImage *)scaleImage:(UIImage *)img ToSize:(CGSize) size;
+(NSData*)imageCompress:(UIImage*)image;

#pragma mark - 进度条-MBProgressHUD
//第三方控件操作
+ (void)showHUD:(NSString *)text andView:(UIView *)view;
+ (void)showTextHUD:(NSString *)text andView:(UIView *)view;
//显示纯文本，并且维持delay秒后自动关闭
+ (void)showTextHUD:(NSString *)text andView:(UIView *)view maintainTime:(NSTimeInterval)delay;
//显示进度条hud
+(MBProgressHUD *)showProgressHUD:(NSString*)text andView:(UIView*)view;
+ (void)hideHUDForView:(UIView*)view;


#pragma mark - DES加密解密
+ (NSString *)encryptUseDES:(NSString *)plainText;
+ (NSString *)decryptUseDES:(NSString*)cipherText;


#pragma mark--判断身份证号是否正确
+ (BOOL) validateIdentityCard:(NSString *)identityCard;

#pragma mark - 系统属性
+ (BOOL)isRetina;  //是否是retina屏
+ (BOOL)isGiraffe;//是否是长屏的 iPone5属性
+ (BOOL)isIPhone5;//是否是iPone5
+ (BOOL)isIOS7Later;//是否是ios7及以后的版本
+ (BOOL)isIPad;

@end


@interface NSDate(DJUtilities)

-(NSString *)toStringWithFormaterTag1:(NSString *)tag1 Tag2:(NSString *)tag2;
-(NSString *)toString;

+(instancetype)dateWithDateFormatString:(NSString *)dateFormatString;
+(instancetype)dateWithDateFormatString:(NSString *)dateFormatString withTag1:(NSString *)tag1 Tag2:(NSString *)tag2;
//返回今天昨天更早过期等
-(NSString *)descriptionDayStringFromNow:(NSInteger)status;

@end
