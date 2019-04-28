//
//  NSString+ZHSafeMethod.m
//  ZHSafeCateory
//
//  Created by 郑晗 on 2019/4/26.
//  Copyright © 2019年 郑晗. All rights reserved.
//

#import "NSString+ZHSafeMethod.h"
#import <objc/runtime.h>
#import "ZHCrashCollection.h"
#import "NSObject+ZHSwizzleMethod.h"

@implementation NSString (ZHSafeMethod)

+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        //characterAtIndex
        
        [objc_getClass("__NSCFConstantString") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(characterAtIndex:) bySwizzledSelector:@selector(ZHSafe_characterAtIndex:)];
        
        //substringFromIndex
        
        [objc_getClass("__NSCFConstantString") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(substringFromIndex:) bySwizzledSelector:@selector(ZHSafe_substringFromIndex:)];
        
        //substringToIndex
        
        [objc_getClass("__NSCFConstantString") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(substringToIndex:) bySwizzledSelector:@selector(ZHSafe_substringToIndex:)];
        
        //substringWithRange:
        
        [objc_getClass("__NSCFConstantString") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(substringWithRange:) bySwizzledSelector:@selector(ZHSafe_substringWithRange:)];
        
        //stringByReplacingOccurrencesOfString:
        
        [objc_getClass("__NSCFConstantString") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(stringByReplacingOccurrencesOfString:withString:) bySwizzledSelector:@selector(ZHSafe_stringByReplacingOccurrencesOfString:withString:)];
        
        //stringByReplacingOccurrencesOfString:withString:options:range:
        
        [objc_getClass("__NSCFConstantString") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) bySwizzledSelector:@selector(ZHSafe_stringByReplacingOccurrencesOfString:withString:options:range:)];
        
        //stringByReplacingCharactersInRange:withString:
        
        [objc_getClass("__NSCFConstantString") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(stringByReplacingCharactersInRange:withString:) bySwizzledSelector:@selector(ZHSafe_stringByReplacingCharactersInRange:withString:)];
        
    });
    
}

- (unichar)ZHSafe_characterAtIndex:(NSUInteger)index {
    
    unichar characteristic;
    @try {
        characteristic = [self ZHSafe_characterAtIndex:index];
    }
    @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
    }
    @finally {
        return characteristic;
    }
}

- (NSString *)ZHSafe_substringFromIndex:(NSUInteger)from {
    
    NSString *subString = nil;
    
    @try {
        subString = [self ZHSafe_substringFromIndex:from];
    }
    @catch (NSException *exception) {
        
        subString = nil;
        
        [ZHCrashCollection logErrorWithException:exception];
        
    }
    @finally {
        return subString;
    }
}

- (NSString *)ZHSafe_substringToIndex:(NSUInteger)to {
    
    NSString *subString = nil;
    
    @try {
        subString = [self ZHSafe_substringToIndex:to];
    }
    @catch (NSException *exception) {
        
        subString = nil;

        [ZHCrashCollection logErrorWithException:exception];
        
    }
    @finally {
        return subString;
    }
}

- (NSString *)ZHSafe_substringWithRange:(NSRange)range {
    
    NSString *subString = nil;
    
    @try {
        subString = [self substringWithRange:range];
    }
    @catch (NSException *exception) {
        
        subString = nil;
        
        [ZHCrashCollection logErrorWithException:exception];
        
    }
    @finally {
        return subString;
    }
}

- (NSString *)ZHSafe_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement {
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self ZHSafe_stringByReplacingOccurrencesOfString:target withString:replacement];
    }
    @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
        newStr = nil;
        
    }
    @finally {
        return newStr;
    }
}

- (NSString *)ZHSafe_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self ZHSafe_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    @catch (NSException *exception) {
        
        newStr = nil;
        
        [ZHCrashCollection logErrorWithException:exception];
        
    }
    @finally {
        return newStr;
    }
}


- (NSString *)ZHSafe_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self ZHSafe_stringByReplacingCharactersInRange:range withString:replacement];
    }
    @catch (NSException *exception) {
        
        newStr = nil;
        
        [ZHCrashCollection logErrorWithException:exception];
        
    }
    @finally {
        return newStr;
    }
}
@end
