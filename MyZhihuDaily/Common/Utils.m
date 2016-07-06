//
//  Utils.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/9.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString *)dateWithString:(NSString *)string{
    NSString *formatStr = @"yyyyMMdd";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatStr;
    NSDate *date = [formatter dateFromString:string];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"MM月dd日"];
    NSString *dateString = [formatter1 stringFromDate:date];
    return dateString;
    
    
}

@end
