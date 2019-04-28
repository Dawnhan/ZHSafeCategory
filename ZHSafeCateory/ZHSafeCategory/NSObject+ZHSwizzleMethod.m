//
//  NSObject+ZHSwizzleMethod.m
//  ZHSafeCateory
//
//  Created by 郑晗 on 2019/4/26.
//  Copyright © 2019年 郑晗. All rights reserved.
//

#import "NSObject+ZHSwizzleMethod.h"
#import <objc/runtime.h>

@implementation NSObject (ZHSwizzleMethod)

/**
 替换类方法
 
 @param originalSelector 原来的方法
 @param swizzledSelector 要替换的方法
 */
+ (void)exchangeClassMethodSwizzlingWithOriginalSelector:(SEL)originalSelector

                                      bySwizzledSelector:(SEL)swizzledSelector
{
    Class class = [self class];
    
    Method originalMethod = class_getClassMethod(class, originalSelector);
    
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

/**
 替换对象方法
 
 @param originalSelector 原来的方法
 @param swizzledSelector 要替换的方法
 */
+ (void)exchangeInstanceMethodSwizzlingWithOriginalSelector:(SEL)originalSelector

                                         bySwizzledSelector:(SEL)swizzledSelector{
    
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
        
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    //先尝试给源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
    
    BOOL didAddMethod = class_addMethod(class,originalSelector,
                                        
                                        method_getImplementation(swizzledMethod),
                                        
                                        method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        
        //添加成功：说明源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP
        
        class_replaceMethod(class,swizzledSelector,
                            
                            method_getImplementation(originalMethod),
                            
                            method_getTypeEncoding(originalMethod));
        
    } else {
        
        //添加失败：说明源SEL已经有IMP，直接将两个SEL的IMP交换即可
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
    }
    
}

@end
