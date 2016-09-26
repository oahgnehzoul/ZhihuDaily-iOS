//
//  Utils.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/9.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ZDUtils : NSObject

//  20160923 -->  09月23日 星期 X
+ (NSString *)dateWithString:(NSString *)string;

+ (void)toggleMMDrawerMenu;

+ (UIViewController *)rootViewController;

+ (UIViewController *)currentViewController;

@end
