//
//  NSString+DJExtension.h
//  DJ_Framework
//
//  Created by okwei on 15/7/20.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -

typedef NSString *			(^NSStringAppendBlock)( id format, ... );
typedef NSString *			(^NSStringReplaceBlock)( NSString * string, NSString * string2 );

typedef NSMutableString *	(^NSMutableStringAppendBlock)( id format, ... );
typedef NSMutableString *	(^NSMutableStringReplaceBlock)( NSString * string, NSString * string2 );

#pragma mark -

#undef	FORMAT
#define	FORMAT( __fmt, ... )	[NSString stringWithFormat:__fmt, __VA_ARGS__]

@interface NSString (DJExtension)

- (BOOL)match:(NSString *)expression;
- (BOOL)matchAnyOf:(NSArray *)array;

- (BOOL)empty;
- (BOOL)notEmpty;

- (BOOL)eq:(NSString *)other;
- (BOOL)equal:(NSString *)other;

- (BOOL)is:(NSString *)other;
- (BOOL)isNot:(NSString *)other;

- (BOOL)isValueOf:(NSArray *)array;
- (BOOL)isValueOf:(NSArray *)array caseInsens:(BOOL)caseInsens;

- (BOOL)isNormal;		//
- (BOOL)isTelephone;    // match telephone
- (BOOL)isMobilephone;  // match mobilephone, 11 numberic
- (BOOL)isUserName;     // match alphabet 3-20
- (BOOL)isChineseUserName;  // match alphabet and chinese characters, 3-20
- (BOOL)isChineseName;      // match just chinese characters 2-16
//- (BOOL)isPassword; //这里可以根据密码要求去自己更改
- (BOOL)isEmail;
- (BOOL)isUrl;
- (BOOL)isIPAddress;


- (NSString *)substringFromIndex:(NSUInteger)from untilString:(NSString *)string;
- (NSString *)substringFromIndex:(NSUInteger)from untilString:(NSString *)string endOffset:(NSUInteger *)endOffset;

- (NSString *)substringFromIndex:(NSUInteger)from untilCharset:(NSCharacterSet *)charset;
- (NSString *)substringFromIndex:(NSUInteger)from untilCharset:(NSCharacterSet *)charset endOffset:(NSUInteger *)endOffset;
- (NSUInteger)countFromIndex:(NSUInteger)from inCharset:(NSCharacterSet *)charset;

#pragma mark - 是否包含中文
//是否包含中文
- (BOOL)isIncludeChineseInString:(NSString*)str;
#pragma mark - URL编码
-(NSString*)urlEncoded:(NSString*)str;
-(NSString*)urlDecoded:(NSString*)str;
@end


#pragma mark -

@interface NSMutableString(BeeExtension)

@property (nonatomic, readonly) NSMutableStringAppendBlock	APPEND;
@property (nonatomic, readonly) NSMutableStringAppendBlock	LINE;
@property (nonatomic, readonly) NSMutableStringReplaceBlock	REPLACE;

@end
