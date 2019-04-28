//
//  NSDictionary+ZHSafeMethod.m
//  ZHSafeCateory
//
//  Created by 郑晗 on 2019/4/26.
//  Copyright © 2019年 郑晗. All rights reserved.
//

#import "NSDictionary+ZHSafeMethod.h"
#import <objc/runtime.h>
#import "ZHCrashCollection.h"
#import "NSObject+ZHSwizzleMethod.h"

@implementation NSDictionary (ZHSafeMethod)

+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        //dictionaryWithObjects:forKeys:count:
        
        [[NSDictionary class] exchangeClassMethodSwizzlingWithOriginalSelector:@selector(dictionaryWithObjects:forKeys:count:) bySwizzledSelector:@selector(ZHSafe_dictionaryWithObjects:forKeys:count:)];
    });
    
}


+ (instancetype)ZHSafe_dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt {
    
    id instance = nil;
    
    @try {
        instance = [self ZHSafe_dictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
        //处理错误的数据，然后重新初始化一个字典
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        id  _Nonnull __unsafe_unretained newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self ZHSafe_dictionaryWithObjects:newObjects forKeys:newkeys count:index];
    }
    @finally {
        return instance;
    }
}
@end
