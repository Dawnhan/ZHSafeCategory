//
//  NSMutableArray+ZHSafeMethod.m
//  ZHSafeCateory
//
//  Created by 郑晗 on 2019/4/26.
//  Copyright © 2019年 郑晗. All rights reserved.
//

#import "NSMutableArray+ZHSafeMethod.h"
#import <objc/runtime.h>
#import "ZHCrashCollection.h"
#import "NSObject+ZHSwizzleMethod.h"

@implementation NSMutableArray (ZHSafeMethod)

+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        //objectAtIndex:
        
        [objc_getClass("__NSArrayM") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(objectAtIndex:) bySwizzledSelector:@selector(ZHSafe_objectAtIndex:)];

        //objectAtIndexedSubscript
        
        if (ZHDeviceSystemVersion(11.0)) {
            [objc_getClass("__NSArrayM") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(objectAtIndexedSubscript:) bySwizzledSelector:@selector(ZHSafe_objectAtIndexedSubscript:)];

        }
        
        //setObject:atIndexedSubscript:
        
        [objc_getClass("__NSArrayM") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(setObject:atIndexedSubscript:) bySwizzledSelector:@selector(ZHSafe_setObject:atIndexedSubscript:)];
        
        //removeObjectAtIndex:
        
        [objc_getClass("__NSArrayM") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(removeObjectAtIndex:) bySwizzledSelector:@selector(ZHSafe_removeObjectAtIndex:)];
        
        //insertObject:atIndex:
        
        [objc_getClass("__NSArrayM") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(insertObject:atIndex:) bySwizzledSelector:@selector(ZHSafe_insertObject:atIndex:)];
        
        //getObjects:range:
        
        [objc_getClass("__NSArrayM") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(getObjects:range:) bySwizzledSelector:@selector(ZHSafe_getObjects:range:)];
    
        
    });
    
}

- (id)ZHSafe_objectAtIndex:(NSUInteger)index {
    
    id object = nil;
    
    @try {
        object = [self ZHSafe_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
    }
    @finally {
        return object;
    }
    
}
- (id)ZHSafe_objectAtIndexedSubscript:(NSUInteger)index
{
    id object = nil;
    
    @try {
        object = [self ZHSafe_objectAtIndexedSubscript:index];
    }
    @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
    }
    @finally {
        return object;
    }
}

- (void)ZHSafe_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    
    @try {
        [self ZHSafe_setObject:obj atIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
    }
    @finally {
        
    }
}

- (void)ZHSafe_removeObjectAtIndex:(NSUInteger)index {
    @try {
        [self ZHSafe_removeObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
    }
    @finally {
        
    }
}


- (void)ZHSafe_insertObject:(id)anObject atIndex:(NSUInteger)index {
    @try {
        [self ZHSafe_insertObject:anObject atIndex:index];
    }
    @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
    }
    @finally {
        
    }
}

- (void)ZHSafe_getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    
    @try {
        [self ZHSafe_getObjects:objects range:range];
    } @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
    } @finally {
        
    }
}

@end
