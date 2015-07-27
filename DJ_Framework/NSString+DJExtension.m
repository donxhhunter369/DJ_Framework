//
//  NSString+DJExtension.m
//  DJ_Framework
//
//  Created by okwei on 15/7/20.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "NSString+DJExtension.h"

@implementation NSString (DJExtension)
- (BOOL)empty
{
    return [self length] > 0 ? NO : YES;
}

- (BOOL)notEmpty
{
    return [self length] > 0 ? YES : NO;
}

- (BOOL)eq:(NSString *)other
{
    return [self isEqualToString:other];
}

- (BOOL)equal:(NSString *)other
{
    return [self isEqualToString:other];
}

- (BOOL)is:(NSString *)other
{
    return [self isEqualToString:other];
}

- (BOOL)isNot:(NSString *)other
{
    return NO == [self isEqualToString:other];
}

- (BOOL)isValueOf:(NSArray *)array
{
    return [self isValueOf:array caseInsens:NO];
}

- (BOOL)isValueOf:(NSArray *)array caseInsens:(BOOL)caseInsens
{
    NSStringCompareOptions option = caseInsens ? NSCaseInsensitiveSearch : 0;
    
    for ( NSObject * obj in array )
    {
        if ( NO == [obj isKindOfClass:[NSString class]] )
            continue;
        
        if ( [(NSString *)obj compare:self options:option] )
            return YES;
    }
    
    return NO;
}
- (BOOL)isUserName
{
    NSString *		regex = @"(^[A-Za-z0-9]{3,20}$)";
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)isChineseUserName
{
    NSString *		regex = @"(^[A-Za-z0-9\u4e00-\u9fa5]{3,20}$)";
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

//- (BOOL)isPassword
//{
//    NSString *		regex = @"(^[A-Za-z0-9]{6,20}$)";
//    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    
//    return [pred evaluateWithObject:self];
//}

- (BOOL)isEmail
{
    NSString *		regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)isUrl
{
    NSString *		regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)isIPAddress
{
    NSArray *			components = [self componentsSeparatedByString:@"."];
    NSCharacterSet *	invalidCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
    
    if ( [components count] == 4 )
    {
        NSString *part1 = [components objectAtIndex:0];
        NSString *part2 = [components objectAtIndex:1];
        NSString *part3 = [components objectAtIndex:2];
        NSString *part4 = [components objectAtIndex:3];
        
        if ( [part1 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part2 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part3 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part4 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound )
        {
            if ( [part1 intValue] < 255 &&
                [part2 intValue] < 255 &&
                [part3 intValue] < 255 &&
                [part4 intValue] < 255 )
            {
                return YES;
            }
        }
    }
    
    return NO;
}

- (BOOL)isNormal
{
    NSString *		regex = @"([^%&',;=!~?$]+)";
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)isTelephone
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    return  [regextestmobile evaluateWithObject:self]   ||
    [regextestphs evaluateWithObject:self]      ||
    [regextestct evaluateWithObject:self]       ||
    [regextestcu evaluateWithObject:self]       ||
    [regextestcm evaluateWithObject:self];
}

- (BOOL)isMobilephone
{
    NSString * MOBILE = @"^[1-9]\\d{10}$";
    NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return  [regextestMobile evaluateWithObject:self];
}

- (BOOL)isChineseName
{
    NSString *		regex = @"(^[\u4e00-\u9fa5]{2,16}$)";
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)match:(NSString *)expression
{
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
    if ( nil == regex )
        return NO;
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:self
                                                        options:0
                                                          range:NSMakeRange(0, self.length)];
    if ( 0 == numberOfMatches )
        return NO;
    
    return YES;
}

- (BOOL)matchAnyOf:(NSArray *)array
{
    for ( NSString * str in array )
    {
        if ( NSOrderedSame == [self compare:str options:NSCaseInsensitiveSearch] )
        {
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - substring
- (NSString *)substringFromIndex:(NSUInteger)from untilString:(NSString *)string
{
    return [self substringFromIndex:from untilString:string endOffset:NULL];
}

- (NSString *)substringFromIndex:(NSUInteger)from untilString:(NSString *)string endOffset:(NSUInteger *)endOffset
{
    if ( 0 == self.length )
        return nil;
    
    if ( from >= self.length )
        return nil;
    
    NSRange range = NSMakeRange( from, self.length - from );
    NSRange range2 = [self rangeOfString:string options:NSCaseInsensitiveSearch range:range];
    
    if ( NSNotFound == range2.location )
    {
        if ( endOffset )
        {
            *endOffset = range.location + range.length;
        }
        
        return [self substringWithRange:range];
    }
    else
    {
        if ( endOffset )
        {
            *endOffset = range2.location + range2.length;
        }
        
        return [self substringWithRange:NSMakeRange(from, range2.location - from)];
    }
}

- (NSString *)substringFromIndex:(NSUInteger)from untilCharset:(NSCharacterSet *)charset
{
    return [self substringFromIndex:from untilCharset:charset endOffset:NULL];
}

- (NSString *)substringFromIndex:(NSUInteger)from untilCharset:(NSCharacterSet *)charset endOffset:(NSUInteger *)endOffset
{
    if ( 0 == self.length )
        return nil;
    
    if ( from >= self.length )
        return nil;
    
    NSRange range = NSMakeRange( from, self.length - from );
    NSRange range2 = [self rangeOfCharacterFromSet:charset options:NSCaseInsensitiveSearch range:range];
    
    if ( NSNotFound == range2.location )
    {
        if ( endOffset )
        {
            *endOffset = range.location + range.length;
        }
        
        return [self substringWithRange:range];
    }
    else
    {
        if ( endOffset )
        {
            *endOffset = range2.location + range2.length;
        }
        
        return [self substringWithRange:NSMakeRange(from, range2.location - from)];
    }
}

- (NSUInteger)countFromIndex:(NSUInteger)from inCharset:(NSCharacterSet *)charset
{
    if ( 0 == self.length )
        return 0;
    
    if ( from >= self.length )
        return 0;
    
    NSCharacterSet * reversedCharset = [charset invertedSet];
    
    NSRange range = NSMakeRange( from, self.length - from );
    NSRange range2 = [self rangeOfCharacterFromSet:reversedCharset options:NSCaseInsensitiveSearch range:range];
    
    if ( NSNotFound == range2.location )
    {
        return self.length - from;
    }
    else
    {
        return range2.location - from;		
    }
}







#pragma mark - 是否包含中文
- (BOOL)isIncludeChineseInString:(NSString*)str {
    for (int i=0; i<str.length; i++) {
        unichar ch = [str characterAtIndex:i];
        if (0x4e00 < ch  && ch < 0x9fff) {
            return true;
        }
    }
    return false;
}
#pragma mark - url编码
-(NSString*)urlEncoded:(NSString*)str {
    NSString *encodeUrlString = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encodeUrlString;
}
-(NSString*)urlDecoded:(NSString*)str {
    NSString * decodeUrlString = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return decodeUrlString;
}

@end



#pragma mark -

@implementation NSMutableString(BeeExtension)

@dynamic APPEND;
@dynamic LINE;
@dynamic REPLACE;

- (NSMutableStringAppendBlock)APPEND
{
    NSMutableStringAppendBlock block = ^ NSMutableString * ( id first, ... )
    {
        va_list args;
        va_start( args, first );
        
        NSString * append = [[NSString alloc] initWithFormat:first arguments:args];
        
        va_end( args );
        
        if ( NO == [self isKindOfClass:[NSMutableString class]] )
        {
            NSMutableString * copy = [self mutableCopy];
            [copy appendString:append];
            
            return copy;
        }
        else
        {
            [self appendString:append];
            
            return self;
        }
    };
    
    return [block copy];
}

- (NSMutableStringAppendBlock)LINE
{
    NSMutableStringAppendBlock block = ^ NSMutableString * ( id first, ... )
    {
        NSString * append = nil;
        
        if ( first )
        {
            va_list args;
            va_start( args, first );
            
            append = [[NSString alloc] initWithFormat:first arguments:args];
            
            va_end( args );
        }
        
        if ( NO == [self isKindOfClass:[NSMutableString class]] )
        {
            NSMutableString * copy = [self mutableCopy];
            
            if ( append )
            {
                [copy appendString:append];
            }
            
            [copy appendString:@"\n"];
            
            return copy;
        }
        else
        {
            if ( append )
            {
                [self appendString:append];
            }
            
            [self appendString:@"\n"];
            
            return self;
        }
        
        return self;
    };
    
    return [block copy];
}

- (NSMutableStringReplaceBlock)REPLACE
{
    NSMutableStringReplaceBlock block = ^ NSMutableString * ( NSString * string1, NSString * string2 )
    {
        [self replaceOccurrencesOfString:string1
                              withString:string2
                                 options:NSCaseInsensitiveSearch
                                   range:NSMakeRange(0, self.length)];
        
        return self;
    };
    
    return [block copy];
}

@end