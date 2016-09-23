//
//  Utils.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/9.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "ZDUtils.h"

@implementation ZDUtils

+ (NSString *)dateWithString:(NSString *)string{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:string];
    [formatter setDateFormat:@"MM月dd日 EEEE"];
    return [formatter stringFromDate:date];
}

@end
