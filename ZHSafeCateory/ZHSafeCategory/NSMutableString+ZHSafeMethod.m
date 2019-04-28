//
//  NSMutableString+ZHSafeMethod.m
//  ZHSafeCateory
//
//  Created by 郑晗 on 2019/4/26.
//  Copyright © 2019年 郑晗. All rights reserved.
//

#import "NSMutableString+ZHSafeMethod.h"
#import <objc/runtime.h>
#import "ZHCrashCollection.h"
#import "NSObject+ZHSwizzleMethod.h"

@implementation NSMutableString (ZHSafeMethod)

+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        //replaceCharactersInRange
        [objc_getClass("__NSCFString") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(replaceCharactersInRange:withString:) bySwizzledSelector:@selector(ZHSafe_replaceCharactersInRange:withString:)];
        
        //insertString:atIndex:
        [objc_getClass("__NSCFString") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(insertString:atIndex:) bySwizzledSelector:@selector(ZHSafe_insertString:atIndex:)];
        
        //deleteCharactersInRange
        [objc_getClass("__NSCFString") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(deleteCharactersInRange:) bySwizzledSelector:@selector(ZHSafe_deleteCharactersInRange:)];

        
    });
    
}


- (void)ZHSafe_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    
    @try {
        [self ZHSafe_replaceCharactersInRange:range withString:aString];
    }
    @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
    }
    @finally {
        
    }
}

- (void)ZHSafe_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    
    @try {
        [self ZHSafe_insertString:aString atIndex:loc];
    }
    @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
    }
    @finally {
        
    }
}

- (void)ZHSafe_deleteCharactersInRange:(NSRange)range {
    
    @try {
        [self ZHSafe_deleteCharactersInRange:range];
    }
    @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
    }
    @finally {
        
    }
}
@end
