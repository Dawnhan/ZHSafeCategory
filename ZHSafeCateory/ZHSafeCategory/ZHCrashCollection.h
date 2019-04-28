//
//  ZHCrashCollection.h
//  ZHSafeCateory
//
//  Created by 郑晗 on 2019/4/26.
//  Copyright © 2019年 郑晗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


//崩溃日志通知并携带崩溃日志参数
UIKIT_EXTERN NSNotificationName const ZHCrashNotification;

#define ZHDeviceSystemVersion(version) ([[UIDevice currentDevice].systemVersion floatValue] >= version)

NS_ASSUME_NONNULL_BEGIN

@interface ZHCrashCollection : NSObject


+ (instancetype)shareInstance;


/**
 是否打印Log日志，默认打印
 */
@property (nonatomic ,assign)BOOL isPrintLog;

/**
 是否发送通知,如果发送则可以通过监听 ZHCrashNotification来获取崩溃信息,默认不发送
 */
@property (nonatomic ,assign)BOOL isSendNotification;

/**
 *  提示崩溃的信息(控制台输出、通知)
 *
 *  @param exception   捕获到的异常
 */
+ (void)logErrorWithException:(NSException *)exception;
    
@end

NS_ASSUME_NONNULL_END
