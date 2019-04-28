//
//  ViewController.m
//  ZHSafeCateory
//
//  Created by 郑晗 on 2019/4/26.
//  Copyright © 2019年 郑晗. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)stringTestAction:(UIButton *)sender;
- (IBAction)arrayTestAction:(UIButton *)sender;
- (IBAction)dictionaryTestAction:(UIButton *)sender;
- (IBAction)selectorTest:(UIButton *)sender;

- (void)voidAction;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (IBAction)stringTestAction:(UIButton *)sender {
    
    NSString *testString = @"Hello apple!";
        
    unichar characterString __unused = [testString characterAtIndex:1000];
    
    NSString *subStringFrom __unused = [testString substringFromIndex:1000];
    
    NSString *subStringTo __unused = [testString substringToIndex:1000];

    NSString *subStringWithRange __unused = [testString substringWithRange:NSMakeRange(1000, 10)];

    NSString *nilString = nil;
    
    NSString *replacingString __unused = [testString stringByReplacingOccurrencesOfString:@"Hello" withString:nilString];

    NSString *replacingStringRange __unused = [testString stringByReplacingOccurrencesOfString:@"Hello" withString:nilString options:(NSCaseInsensitiveSearch) range:NSMakeRange(1000, 10)];
    
    NSMutableString *muString = [[NSMutableString alloc]initWithString:testString];
    
    [muString replaceCharactersInRange:NSMakeRange(1000, 10) withString:nilString];

    [muString insertString:@"Hi" atIndex:1000];

    [muString deleteCharactersInRange:NSMakeRange(1000, 10)];


}

- (IBAction)arrayTestAction:(UIButton *)sender {
    
    NSString *nilString = nil;
    
    NSArray *array = @[@"1",@"2"];
    
    NSArray *NSArrayI = @[@"1",@"2",nilString];
    
    NSArray *NSSingleObjectArrayI = @[@"1"];
    
    NSArray *arNSArrayray = @[];
    
    NSString *string01 __unused = NSArrayI[1000];
    NSString *string02 __unused = NSSingleObjectArrayI[1000];
    NSString *string03 __unused = arNSArrayray[1000];

    
    [array objectsAtIndexes:[NSIndexSet indexSetWithIndex:1000]];
    
    NSRange range = NSMakeRange(0, 11);
    __unsafe_unretained id cArray[range.length];
    
    [NSArrayI getObjects:cArray range:range];
    
    NSMutableArray *NSArrayM = [NSMutableArray arrayWithArray:NSArrayI];
    
    NSString *string04 __unused = NSArrayM[1000];
    
    NSArrayM[1000] = @"1";
    
    [NSArrayM removeObjectAtIndex:1000];
    
    [NSArrayM insertObject:@"1" atIndex:1000];
    
}

- (IBAction)dictionaryTestAction:(UIButton *)sender {
    
    NSString *nilString = nil;
    NSDictionary *dictionary01 = @{@"1" : @"111",
                                   @"2" : nilString
                                   };
    
    NSString *string01 __unused = dictionary01[nilString];
    
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithDictionary:dictionary01];
    
    NSString *string02 __unused = muDic[nilString];

    [muDic setObject:nilString forKey:@"3"];
    
    [muDic removeObjectForKey:nilString];
    
    
}

- (IBAction)selectorTest:(UIButton *)sender {
    
    [self voidAction];
}
@end
