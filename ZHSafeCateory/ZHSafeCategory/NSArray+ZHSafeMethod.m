//
//  NSArray+ZHSafeMethod.m
//  ZHSafeCateory
//
//  Created by 郑晗 on 2019/4/26.
//  Copyright © 2019年 郑晗. All rights reserved.
//

#import "NSArray+ZHSafeMethod.h"
#import <objc/runtime.h>
#import "ZHCrashCollection.h"
#import "NSObject+ZHSwizzleMethod.h"

@implementation NSArray (ZHSafeMethod)

+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        //NSArray arrayWithObjects:count:
        
        [[NSArray class] exchangeClassMethodSwizzlingWithOriginalSelector:@selector(arrayWithObjects:count:) bySwizzledSelector:@selector(ZHSafe_arrayWithObjects:count:)];

        //objectsAtIndex
        
        [objc_getClass("__NSArray0") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(objectAtIndex:) bySwizzledSelector:@selector(ZHSafe__NSArray0_objectAtIndex:)];
        
        [objc_getClass("__NSSingleObjectArrayI") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(objectAtIndex:) bySwizzledSelector:@selector(ZHSafe__NSSingleObjectArrayI_objectAtIndex:)];

        [objc_getClass("__NSArrayI") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(objectAtIndex:) bySwizzledSelector:@selector(ZHSafe__NSArrayI_objectAtIndex:)];
        
        //objectsAtIndexes
        
        [objc_getClass("__NSArray") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(objectAtIndex:) bySwizzledSelector:@selector(ZHSafe__NSArray_objectAtIndex:)];
        
        //objectAtIndexedSubscript:
        if (ZHDeviceSystemVersion(11.0)) {
            [objc_getClass("__NSArrayI") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(objectAtIndexedSubscript:) bySwizzledSelector:@selector(ZHSafe_objectAtIndexedSubscript:)];
        }
        
        //getObjects:range:
        
        [objc_getClass("__NSArray") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(getObjects:range:) bySwizzledSelector:@selector(ZHSafe_getObjects:range:)];
        
//        [objc_getClass("__NSSingleObjectArrayI") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(getObjects:range:) bySwizzledSelector:@selector(ZHSafe_getObjects:range:)];
        
        [objc_getClass("__NSArrayI") exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(getObjects:range:) bySwizzledSelector:@selector(ZHSafe_getObjects:range:)];


    
    });
    
}


+ (instancetype)ZHSafe_arrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    
    id instance = nil;
    
    @try {
        instance = [self ZHSafe_arrayWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
        //对错误数据进行处理，把为nil的数据去掉,然后初始化数组
        
        NSInteger newObjsIndex = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex++;
            }
        }
        instance = [self ZHSafe_arrayWithObjects:newObjects count:newObjsIndex];
    }
    @finally {
        return instance;
    }
}
- (id)ZHSafe__NSArray0_objectAtIndex:(NSUInteger)index {
    
    id object = nil;
    
    @try {
        object = [self ZHSafe__NSArray0_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
    }
    @finally {
        return object;
    }
    
}

- (id)ZHSafe__NSSingleObjectArrayI_objectAtIndex:(NSUInteger)index {
    
    id object = nil;
    
    @try {
        object = [self ZHSafe__NSSingleObjectArrayI_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
    }
    @finally {
        return object;
    }
    
}

- (id)ZHSafe__NSArrayI_objectAtIndex:(NSUInteger)index {
    
    id object = nil;
    
    @try {
        object = [self ZHSafe__NSArrayI_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
    }
    @finally {
        return object;
    }
    
}
- (id)ZHSafe__NSArray_objectAtIndex:(NSUInteger)index {
    
    id object = nil;
    
    @try {
        object = [self ZHSafe__NSArray_objectAtIndex:index];
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
- (void)ZHSafe_getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    
    @try {
        [self ZHSafe_getObjects:objects range:range];
    } @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
    } @finally {
        
    }
}
@end
