//
//  Utils.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/9.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "ZDUtils.h"
#import "ZDRootViewController.h"
#import "UIViewController+CurrentViewController.h"
@implementation ZDUtils

+ (NSString *)dateWithString:(NSString *)string{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:string];
    [formatter setDateFormat:@"MM月dd日 EEEE"];
    return [formatter stringFromDate:date];
}

+ (void)toggleMMDrawerMenu {
    
    [(ZDRootViewController *)[self.class rootViewController] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

+ (UIViewController *)rootViewController {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    return (ZDRootViewController *)window.rootViewController;
}

+ (UIViewController *)currentViewController {
    return [UIViewController currentViewController];
}


@end
