//
//  NSMutableDictionary+ZHSafeMethod.m
//  ZHSafeCateory
//
//  Created by 郑晗 on 2019/4/26.
//  Copyright © 2019年 郑晗. All rights reserved.
//

#import "NSMutableDictionary+ZHSafeMethod.h"
#import <objc/runtime.h>
#import "ZHCrashCollection.h"
#import "NSObject+ZHSwizzleMethod.h"

@implementation NSMutableDictionary (ZHSafeMethod)


+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        //dictionaryWithObjects:forKeys:count:

        [objc_getClass("__NSDictionaryM") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(setObject:forKey:) bySwizzledSelector:@selector(ZHSafe_setObject:forKey:)];
        
        //setObject:forKeyedSubscript:
        
        if (ZHDeviceSystemVersion(11.0)) {
            [objc_getClass("__NSDictionaryM") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(setObject:forKeyedSubscript:) bySwizzledSelector:@selector(ZHSafe_setObject:forKeyedSubscript:)];

        }
        
        //removeObjectForKey:

        [objc_getClass("__NSDictionaryM") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(removeObjectForKey:) bySwizzledSelector:@selector(ZHSafe_removeObjectForKey:)];

        
    });
    
}

- (void)ZHSafe_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    
    @try {
        [self ZHSafe_setObject:anObject forKey:aKey];
    }
    @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
    }
    @finally {
        
    }
}

- (void)ZHSafe_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    @try {
        [self ZHSafe_setObject:obj forKeyedSubscript:key];
    }
    @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
    }
    @finally {
        
    }
}

- (void)ZHSafe_removeObjectForKey:(id)aKey {
    
    @try {
        [self ZHSafe_removeObjectForKey:aKey];
    }
    @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
    }
    @finally {
        
    }
}
@end
