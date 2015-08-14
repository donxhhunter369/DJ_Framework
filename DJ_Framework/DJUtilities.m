//
//  DJUtilities.m
//  DJ_Framework
//
//  Created by okwei on 15/7/3.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJUtilities.h"
#import <CommonCrypto/CommonCryptor.h>

//@[@"接收通知", @"开启声音", @"开启震动"];
#define AllowReceiveNotify        @"AllowReceiveNotify"       //是否允许接收推送
#define OpenVioce                 @"OpenVioce"                //@"开启声音"
#define AllowShake                @"AllowShake"               //@"开启震动"

#define PASSWORD_KEY  @"@ai8!lk5"

@implementation DJUtilities

static DJUtilities *shareInstance = nil;
+ (instancetype)shareInstance
{
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

#pragma mark  是否允许"接收通知"
-(void)saveAllowReceiveNotify:(BOOL)isAllowReceiveNotify
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:AllowReceiveNotify];
    [setting setObject:(isAllowReceiveNotify?@"1" : @"0") forKey:AllowReceiveNotify];
    [setting synchronize];
}

-(BOOL)getIsAllowReceiveNotify
{
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    NSString * value = [setting objectForKey:AllowReceiveNotify];
    
    if (!value) { //没存过，默认开放
        return YES;
    }
    
    if (value && [value isEqualToString:@"1"]) {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark  是否允许"开启声音"
-(void)saveOpenVioce:(BOOL)isOpenVioce
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:OpenVioce];
    [setting setObject:(isOpenVioce?@"1" : @"0") forKey:OpenVioce];
    [setting synchronize];
}

-(BOOL)getIsOpenVioce
{
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    NSString * value = [setting objectForKey:OpenVioce];
    
    if (!value) { //没存过，默认开放
        return YES;
    }
    
    if (value && [value isEqualToString:@"1"]) {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark  是否允许"开启震动"
-(void)saveAllowShake:(BOOL)isAllowShake
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:AllowShake];
    [setting setObject:(isAllowShake?@"1" : @"0") forKey:AllowShake];
    [setting synchronize];
}

-(BOOL)getIsAllowShake
{
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    NSString * value = [setting objectForKey:AllowShake];
    
    if (!value) { //没存过，默认开放
        return YES;
    }
    
    if (value && [value isEqualToString:@"1"]) {
        return YES;
    }
    else
    {
        return NO;
    }
}



#pragma mark - 将对象转换成Json字符串
+(NSString *)jsonString:(id)object{
    
    if(!object || [object isKindOfClass:[NSNull class]])return [NSString stringWithFormat:@"\"%@\"",[[NSNull null] description]];
    
    //直接返回
    if ([object isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"\"%@\"",object];
    }
    
    if ([object isKindOfClass:[NSValue class]]) {
        return [NSString stringWithFormat:@"%@",object];
    }
    
    //数组
    if ([object isKindOfClass:[NSArray class]]) {
        NSMutableString * arrayString = @"[".mutableCopy;
        if(((NSArray *)object).count == 0){
            [arrayString appendString:@"]"];
            return [NSString stringWithString:arrayString];
        }
        for (NSObject * arraySubObject in (NSArray *)object) {
            [arrayString appendFormat:@"%@%@",[DJUtilities jsonString:arraySubObject],(arraySubObject == [(NSArray *)object lastObject]) ? @"]" : @","];
        }
        return [NSString stringWithString:arrayString];
    }
    
    //字典
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary * objectDic = (NSDictionary *)object;
        
        NSMutableString * jsonDic = @"{".mutableCopy;
        NSArray * keyArray = [objectDic allKeys];
        if(keyArray.count == 0){
            [jsonDic appendString:@"}"];
            return [NSString stringWithString:jsonDic];
        }
        for (NSObject * key in keyArray) {
            [jsonDic appendFormat:@"\"%@\":%@%@",key,[DJUtilities jsonString:objectDic[key]],(key == [keyArray lastObject]) ? @"}" : @","];
        }
        return [NSString stringWithString:jsonDic];
    }
    
    
    uint count;
    objc_property_t * propertys = class_copyPropertyList([object class], &count);
    NSMutableString * jsonStr = @"{".mutableCopy;
    
    if (count == 0){
        [jsonStr appendString:@"}"];
        return [NSString stringWithString:jsonStr];
    }
    
    for (uint i = 0 ; i < count ; i ++) {
        objc_property_t property = propertys[i];
        NSString * key = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSObject * value = [DJUtilities jsonString:[object valueForKey:key]];
        [jsonStr appendFormat:@"\"%@\":%@%@",key,value,(i == count - 1) ? @"}" : @","];
    }
    return [NSString stringWithString:jsonStr];
}
#pragma mark - 转换Json字符串
+(NSDictionary *)getObject:(NSString *)jsonString{
    if (!jsonString)return nil;
    
    NSString *jsonDynamicPrice = [jsonString stringByReplacingOccurrencesOfString:@"(\\w+)\\s*:"
                                                                       withString:@"\"$1\":"
                                                                          options:NSRegularExpressionSearch
                                                                            range:NSMakeRange(0, [jsonString length])];
    NSDictionary *dict = [jsonDynamicPrice objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    return dict;
}

#pragma mark - 时间相关
+(NSString *)stringDateFromNow:(NSDate *)date{
    
    
    if([date toString].length < 19)return @"";
    
    
    NSString * nowYearString = [[[NSDate dateWithTimeIntervalSinceNow:8 * 60 * 60] toString] substringToIndex:4];
    NSString * dateYearString = [[date toString] substringToIndex:4];
    
    BOOL isYearEqual = [nowYearString isEqualToString:dateYearString];
    
    
    NSTimeInterval timeInterval = -[date timeIntervalSinceDate:[NSDate dateWithTimeIntervalSinceNow:8 * 60 * 60]];
    NSString * str = [NSString stringWithFormat:@"%@",timeInterval < 60 ? @"刚刚" : [NSString stringWithFormat:@"%@前",timeInterval < 60 * 60 ? [NSString stringWithFormat:@"%d分钟",(int)timeInterval / 60] : timeInterval < 60 * 60 * 24 ? [NSString stringWithFormat:@"%d小时",(int)timeInterval / (60 * 60)] : timeInterval < 60 * 60 * 24 * 31 ? [NSString stringWithFormat:@"%d天",(int)(timeInterval) / (60 * 60 * 24)] : [[date toStringWithFormaterTag1:@"-" Tag2:@":"] substringWithRange:isYearEqual ? NSMakeRange(5, 5) : NSMakeRange(0, 10)]]];
    
    if (timeInterval > 60 * 60 * 24 * 31) {
        str = [str substringToIndex:str.length - 1];
    }
    
    return str;
}

+(NSString *)stringNowFromTimeInterval:(NSTimeInterval)timeInterval{
    return [NSString stringWithFormat:@"%@%@",timeInterval > 60 * 60 * 24 ? [NSString stringWithFormat:@"%d天 ",(int)(timeInterval / (60 * 60 * 24))] : @"",[NSString stringWithFormat:@"%02d:%02d:%02d",((int)timeInterval % (60 * 60 * 24)) / (60 * 60),((int)timeInterval % (60 * 60 * 24)) % (60 * 60) / 60,((int)timeInterval % (60 * 60 * 24)) % (60 * 60) % 60]];
}
+(NSDate *)dateGMTConvertCurrentTime:(NSString *)date
{
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *localDate = [dataFormatter dateFromString:date];
    NSTimeZone * timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSTimeZone * destinationTimeZone = [NSTimeZone localTimeZone];
    NSInteger sourceOffset = [timeZone secondsFromGMTForDate:localDate];
    NSInteger destinationOffet = [destinationTimeZone secondsFromGMTForDate:localDate];
    NSTimeInterval interval = destinationOffet - sourceOffset;
    NSDate *detinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:localDate];
    return detinationDateNow;
}
+(NSString *)dataGMTConvertStandTime:(NSString *)date
{
    NSDateFormatter  *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *localDate = [dataFormatter dateFromString:date];
    NSString * dateString =[formatter stringFromDate:localDate];
    return dateString;
}
+(NSString *)dateSystemConvertStandTime:(NSString *)date
{
    NSDateFormatter  *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *localDate = [dataFormatter dateFromString:date];
    NSString * dateString =[formatter stringFromDate:localDate];
    return dateString;
}

#pragma mark - 判断时区是否在大陆
+ (BOOL)isInChina{
    BOOL result = NO;
    //NSString* localeStr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    if([[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Chongqing"].location == 0 ||
       [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Harbin"].location == 0 ||
       /* [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Hong_Kong"].location == 0 || */
       /* [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Macau"].location == 0 ||     */
       [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Shanghai"].location == 0 /* ||
                                                                                         [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Taipei"].location == 0*/)
    {
        result = YES;
    }
    return result;
}

#pragma mark - 图片base54编码
//头像的
+(NSString*)base64EncodedStringWithIconImage:(UIImage*)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    return [imageData sam_base64EncodedString];
}
//转换成jpg各式的 base64编码  0.7压缩jpeg
+(NSString*)base64EncodedStringWithJPEGImage:(UIImage*)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    return [imageData sam_base64EncodedString];
}
//转换成jpg各式的 base64编码
+(NSString*)base64EncodedStringWithJPEGImage:(UIImage*)image WithCompressionQuality:(CGFloat) compressionQuality
{
    NSData *imageData = UIImageJPEGRepresentation(image, compressionQuality);
    return [imageData sam_base64EncodedString];
}
//png
+(NSString*)base64EncodedStringWithPNGImage:(UIImage*)image
{
    NSData *imageData = UIImagePNGRepresentation(image);
    return [imageData sam_base64EncodedString];
}





#pragma mark - 图片缩放/压缩
//图片缩放到指定大小尺寸
+(UIImage *)scaleImage:(UIImage *)img ToSize:(CGSize) size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
+(NSData*)imageCompress:(UIImage*)image
{
    if (image.size.width == 0 || image.size.height == 0) {
        return [NSData data];
    }
    
    if (image.size.width > 1080 || image.size.height > 1080) {
        CGSize size = CGSizeZero;
        if (image.size.width > image.size.height) {
            size = CGSizeMake(1080, image.size.height / image.size.width * 1080);
        }else{
            size = CGSizeMake(image.size.width / image.size.height * 1080, 1080);
        }
        image = [DJUtilities scaleImage:image ToSize:size];
    }
    NSInteger maxData = 1024 * 300;   //最高上传 300K
    NSData * compressImageData = nil;
    @autoreleasepool {
        compressImageData  = UIImageJPEGRepresentation(image,1);
        CGFloat compression = 1.0f;
        CGFloat maxCompression = 0.3f;
        while ([compressImageData length] > maxData && compression > maxCompression)
        {
            compression -= 0.05;
            compressImageData = UIImageJPEGRepresentation(image, compression);
        }
        if (compressImageData.length > maxData) {
            CGFloat compressionQuality = (CGFloat)maxData/compressImageData.length;
            compressImageData  = UIImageJPEGRepresentation(image, compressionQuality);
        }
    }
    return compressImageData;
}


#pragma mark - MBProgressHUD---进度条
+ (void)showHUD:(NSString *)text andView:(UIView *)view
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.labelText = text;
    hud.square = YES;
    [hud show:YES];
}

//纯文本
+ (void)showTextHUD:(NSString *)text andView:(UIView *)view
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.labelText = text;
    hud.mode = MBProgressHUDModeText;
    [hud show:YES];
}
//显示纯文本，并且维持delay秒后自动关闭
+ (void)showTextHUD:(NSString *)text andView:(UIView *)view maintainTime:(NSTimeInterval)delay
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.labelText = text;
    hud.mode = MBProgressHUDModeText;
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
}

+(MBProgressHUD *)showProgressHUD:(NSString*)text andView:(UIView*)view
{
    MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.labelText = text;
    
    //设置模式为进度框形的
    hud.mode = MBProgressHUDModeDeterminate;//  MBProgressHUDModeDeterminate
    hud.progress = 0.05f;
    [hud show:YES];
    return hud;
}
+ (void)hideHUDForView:(UIView*)view
{
    while ([MBProgressHUD hideHUDForView:view animated:YES]) {
    }
}


#pragma mark - DES 加密解密
+(NSString *)encryptUseDES:(NSString *)plainText
{
    return [self encryptUseDES:plainText key:PASSWORD_KEY];
}

+ (NSString *) decryptUseDES:(NSString*)cipherText
{
    return [self decryptUseDES:cipherText key:PASSWORD_KEY];
}
/*字符串加密
 *参数
 *plainText :  DES加密明文
 *key        : 密钥 64位
 */
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key
{
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    NSUInteger dataLength = [plainText length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    Byte *iv = (Byte *)[[key dataUsingEncoding:NSUTF8StringEncoding] bytes];
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
        //        ciphertext =   [data base64Encoding];
        //ciphertext =  [[data sam_hexadedimalString] uppercaseString];
        ciphertext = [[self myHexadedimalString:data] uppercaseString];
    }
    return ciphertext;
}

//DES解密
+ (NSString *) decryptUseDES:(NSString*)cipherText key:(NSString*)key
{
    NSData* cipherData =[self dataWithHexString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    //Byte iv[] = {1,2,3,4,5,6,7,8};
    Byte *iv = (Byte *)[[key dataUsingEncoding:NSUTF8StringEncoding] bytes];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
    }
    return plainText;
}
#pragma mark NSData与16进制字符串转换
+ (NSString *)myHexadedimalString:(NSData*)data {
    NSMutableString *string = [NSMutableString string];
    const unsigned char *bytes = [data bytes];
    NSUInteger length = [data length];
    for (NSUInteger i = 0; i < length; i++) {
        NSString * str = [NSString stringWithFormat:@"%02x", bytes[i]];
        
        if (str.length < 2 ) {
            [string appendFormat:@"0%@", str];
        }
        else
        {
            [string appendString:str];
        }
    }
    return string;
}
+ (NSData*) dataWithHexString: (NSString*) hexString
{
    NSMutableData* data = [NSMutableData dataWithCapacity: [hexString length] / 2];
    
    char* chars = (char*)[hexString UTF8String];
    
    unsigned char value;
    
    while(*chars != '\0')
    {
        if(*chars >= '0' && *chars <= '9')
        {
            value = (*chars - '0') << 4;
        }
        else if(*chars >= 'a' && *chars <= 'f')
        {
            value = (*chars - 'a' + 10) << 4;
        }
        else if(*chars >= 'A' && *chars <= 'F')
        {
            value = (*chars - 'A' + 10) << 4;
        }
        else
        {
            return nil;
        }
        
        chars++;
        
        if(*chars >= '0' && *chars <= '9')
        {
            value |= *chars - '0';
        }
        else if(*chars >= 'a' && *chars <= 'f')
        {
            value |= *chars - 'a' + 10;
        }
        else if(*chars >= 'A' && *chars <= 'F')
        {
            value |= *chars - 'A' + 10;
        }
        else
        {
            return nil;
        }
        
        [data appendBytes: &value length: sizeof(value)];
        
        chars++;
    }
    
    return data;
}


#pragma mark - 判断身份证号是否正确
//判断身份证号是否正确
+ (BOOL) validateIdentityCard:(NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

#pragma mark - 系统属性
#pragma mark -
#pragma mark system info
+ (BOOL)isRetina
{
    return [[UIScreen mainScreen] sam_isRetina];
}
+ (BOOL)isGiraffe
{
    static BOOL isGiraffe = NO;
    static BOOL isLoaded = NO;
    
    if (!isLoaded) {
        isGiraffe = [[UIScreen mainScreen] sam_isGiraffe];
        isLoaded = YES;
    }
    return isGiraffe;
}
+ (BOOL)isIPhone5
{
    return [self isGiraffe];
}
+ (BOOL)isIPad{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}
//是否是ios7及以后的版本
+ (BOOL)isIOS7Later
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
    {
        return YES;
    }
    
    return NO;
}
+ (NSString *)appIdentifier
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    static NSString * __identifier = nil;
    if ( nil == __identifier )
    {
        __identifier = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    }
    return __identifier;
#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    return @"";
#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
}

@end



@implementation NSDate (DJUtilities)


-(NSString *)toStringWithFormaterTag1:(NSString *)tag1 Tag2:(NSString *)tag2{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:[NSString stringWithFormat:@"yyyy%@MM%@dd HH%@mm%@ss",tag1,tag1,tag2,tag2]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    return [dateFormatter stringFromDate:self];
}

+(instancetype)dateWithDateFormatString:(NSString *)dateFormatString withTag1:(NSString *)tag1 Tag2:(NSString *)tag2{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:[NSString stringWithFormat:@"yyyy%@MM%@dd HH%@mm%@ss",tag1,tag1,tag2,tag2]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    return [dateFormatter dateFromString:dateFormatString];
}


-(NSString *)toString{
    return [self toStringWithFormaterTag1:@"/" Tag2:@":"];
}

+(instancetype)dateWithDateFormatString:(NSString *)dateFormatString{
    return [NSDate dateWithDateFormatString:dateFormatString withTag1:@"/" Tag2:@":"];
}

-(NSString *)toDayString{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    return [dateFormatter stringFromDate:self];
}


//返回今天昨天更早过期等
-(NSString *)descriptionDayStringFromNow:(NSInteger)status{
    if (status == 0 || status == 1) {
        NSDate * nowDate = [NSDate dateWithTimeIntervalSinceNow:8 * 60 * 60];
        NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:self];
        
        if (timeInterval < -60) {
            return @"未来";
        }
        
        if (timeInterval > 48 * 60 * 60) {
            return @"已过期";
        }
        
        NSArray * dateDayArray = [[self toDayString] componentsSeparatedByString:@"/"];
        NSArray * nowDayArray = [[nowDate toDayString] componentsSeparatedByString:@"/"];
        
        if ([[dateDayArray lastObject] isEqualToString:[nowDayArray lastObject]]) {
            return @"今天";
        }
        
        return [[self toDayString] stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    }else{
        return [[self toDayString] stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    }
}


@end
