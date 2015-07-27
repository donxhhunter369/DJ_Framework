//
//  DJ_Keychain.h
//  DJ_Framework
//
//  Created by okwei on 15/7/27.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJCommon.h"

#pragma mark -

#define AS_KEYCHAIN( __name )	AS_STATIC_PROPERTY( __name )
#define DEF_KEYCHAIN( __name )	DEF_STATIC_PROPERTY3( __name, @"keychain", [self description] )

#pragma mark -

@interface DJ_Keychain : NSObject

@property (nonatomic, retain) NSString * defaultDomain;

AS_SINGLETON(DJ_Keychain)


+ (void)setDefaultDomain:(NSString *)domain;

+ (NSString *)readValueForKey:(NSString *)key;
+ (NSString *)readValueForKey:(NSString *)key andDomain:(NSString *)domain;

+ (void)writeValue:(NSString *)value forKey:(NSString *)key;
+ (void)writeValue:(NSString *)value forKey:(NSString *)key andDomain:(NSString *)domain;

+ (void)deleteValueForKey:(NSString *)key;
+ (void)deleteValueForKey:(NSString *)key andDomain:(NSString *)domain;

@end
