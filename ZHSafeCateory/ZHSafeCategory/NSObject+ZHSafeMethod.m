//
//  NSObject+ZHSafeMethod.m
//  ZHSafeCateory
//
//  Created by 郑晗 on 2019/4/28.
//  Copyright © 2019年 郑晗. All rights reserved.
//

#import "NSObject+ZHSafeMethod.h"
#import <objc/runtime.h>
#import "ZHCrashCollection.h"
#import "NSObject+ZHSwizzleMethod.h"

@implementation NSObject (ZHSafeMethod)


+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        //unrecognized selector sent to instance
        
        [[self class] exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(methodSignatureForSelector:) bySwizzledSelector:@selector(ZHSafe_methodSignatureForSelector:)];
        
        [[self class] exchangeInstanceMethodSwizzlingWithOriginalSelector:@selector(forwardInvocation:) bySwizzledSelector:@selector(ZHSafe_forwardInvocation:)];
        
    });
    
}

- (NSMethodSignature *)ZHSafe_methodSignatureForSelector:(SEL)aSelector {
    
    NSMethodSignature *methodSignature = [self ZHSafe_methodSignatureForSelector:aSelector];
    
    if (!methodSignature) {
        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:*"];
    }
    
    return methodSignature;
}


- (void)ZHSafe_forwardInvocation:(NSInvocation *)anInvocation {
    
    @try {
        [self ZHSafe_forwardInvocation:anInvocation];
        
    } @catch (NSException *exception) {
        
        [ZHCrashCollection logErrorWithException:exception];
        
        
    } @finally {
        
    }
    
}

@end
