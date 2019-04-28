//
//  ZHCrashCollection.m
//  ZHSafeCateory
//
//  Created by 郑晗 on 2019/4/26.
//  Copyright © 2019年 郑晗. All rights reserved.
//

#import "ZHCrashCollection.h"

#define ZHCrashSeparator         @"================================================================"
#define ZHCrashSeparatorWithFlag @"========================ZHCrash Log=========================="

#define key_errorName        @"errorName"
#define key_errorReason      @"errorReason"
#define key_errorPlace       @"errorPlace"
#define key_callStackSymbols @"callStackSymbols"
#define key_exception        @"exception"


#ifdef DEBUG

#define  ZHCrashLog(...) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])

#else

#define ZHCrashLog(...)

#endif

NSNotificationName const ZHCrashNotification = @"ZHCrashNotification";

@implementation ZHCrashCollection

+ (instancetype)shareInstance
{
    static ZHCrashCollection *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [ZHCrashCollection new];
        manager.isPrintLog = YES;
    });
    return manager;
}

+ (void)logErrorWithException:(NSException *)exception
{
    
    //堆栈数据
    NSArray *callStackSymbolsData = [NSThread callStackSymbols];
    
    //获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = [ZHCrashCollection getMainCallStackSymbolMessageWithCallStackSymbols:callStackSymbolsData];
    
    if (mainCallStackSymbolMsg == nil) {
        
        mainCallStackSymbolMsg = @"崩溃方法定位失败,请您查看函数调用栈来排查错误原因";
        
    }
    
    NSString *errorName = exception.name;
    NSString *errorReason = exception.reason;
    
    errorReason = [errorReason stringByReplacingOccurrencesOfString:@"avoidCrash" withString:@""];
    
    NSString *errorPlace = [NSString stringWithFormat:@"Error Place:%@",mainCallStackSymbolMsg];
    
    NSString *logErrorMessage = [NSString stringWithFormat:@"\n%@\n\n%@\n%@\n%@",ZHCrashSeparatorWithFlag, errorName, errorReason, errorPlace];
    
    logErrorMessage = [NSString stringWithFormat:@"%@\n\n%@\n\n",logErrorMessage,ZHCrashSeparator];
    
    if ([ZHCrashCollection shareInstance].isPrintLog) {
        ZHCrashLog(@"%@",logErrorMessage);
    }
    if ([ZHCrashCollection shareInstance].isSendNotification) {
        NSDictionary *errorInfoDic = @{
                                       key_errorName        : errorName,
                                       key_errorReason      : errorReason,
                                       key_errorPlace       : errorPlace,
                                       key_exception        : exception,
                                       key_callStackSymbols : callStackSymbolsData
                                       };
        
        //将错误信息放在字典里，用通知的形式发送出去
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter]postNotificationName:ZHCrashNotification object:errorInfoDic];
        });
        
    }
    
}


/**
 *  获取堆栈主要崩溃精简化的信息<根据正则表达式匹配出来>
 *
 *  @param callStackSymbols 堆栈主要崩溃信息
 *
 *  @return 堆栈主要崩溃精简化的信息
 */

+ (NSString *)getMainCallStackSymbolMessageWithCallStackSymbols:(NSArray<NSString *> *)callStackSymbols {
    
    //mainCallStackSymbolMsg的格式为   +[类名 方法名]  或者 -[类名 方法名]
    __block NSString *mainCallStackSymbolMsg = nil;
    
    //匹配出来的格式为 +[类名 方法名]  或者 -[类名 方法名]
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    for (int index = 2; index < callStackSymbols.count; index++) {
        NSString *callStackSymbol = callStackSymbols[index];
        
        [regularExp enumerateMatchesInString:callStackSymbol options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbol.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString* tempCallStackSymbolMsg = [callStackSymbol substringWithRange:result.range];
                
                //get className
                NSString *className = [tempCallStackSymbolMsg componentsSeparatedByString:@" "].firstObject;
                className = [className componentsSeparatedByString:@"["].lastObject;
                
                NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(className)];
                
                //filter category and system class
                if (![className hasSuffix:@")"] && bundle == [NSBundle mainBundle]) {
                    mainCallStackSymbolMsg = tempCallStackSymbolMsg;
                    
                }
                *stop = YES;
            }
        }];
        
        if (mainCallStackSymbolMsg.length) {
            break;
        }
    }
    
    return mainCallStackSymbolMsg;
}
@end
