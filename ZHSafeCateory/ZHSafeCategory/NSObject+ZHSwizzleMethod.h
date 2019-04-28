//
//  NSObject+ZHSwizzleMethod.h
//  ZHSafeCateory
//
//  Created by 郑晗 on 2019/4/26.
//  Copyright © 2019年 郑晗. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ZHSwizzleMethod)

/**
 替换类方法
 
 @param originalSelector 原来的方法
 @param swizzledSelector 要替换的方法
 */
+ (void)exchangeClassMethodSwizzlingWithOriginalSelector:(SEL)originalSelector

                                      bySwizzledSelector:(SEL)swizzledSelector;
/**
 替换对象方法
 
 @param originalSelector 原来的方法
 @param swizzledSelector 要替换的方法
 */
+ (void)exchangeInstanceMethodSwizzlingWithOriginalSelector:(SEL)originalSelector

                                         bySwizzledSelector:(SEL)swizzledSelector;


@end

NS_ASSUME_NONNULL_END
