//
//  ThemeManager.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/8/27.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeManager : NSObject
#define kThemeDidChangeNofication @"kThemeDidChangeNofication"

@property (nonatomic,copy) NSString *themeName;//主题名

+ (ThemeManager *)shareInstance;

- (UIImage *)getThemeImage:(NSString *)imageName;

@end
