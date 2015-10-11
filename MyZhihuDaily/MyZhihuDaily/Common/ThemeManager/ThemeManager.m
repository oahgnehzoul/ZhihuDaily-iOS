//
//  ThemeManager.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/8/27.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "ThemeManager.h"
#define kDefaultThemeName @"day"
#define kThemeName @"kThemeName"
@implementation ThemeManager

+ (ThemeManager *)shareInstance {
    static ThemeManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _themeName = kDefaultThemeName;
        
    }
    //读取本地存储的主题名字
    NSString *saveThemeName = [[NSUserDefaults standardUserDefaults] objectForKey:kThemeName];
    if (saveThemeName.length > 0) {
        _themeName = saveThemeName;
    }
    return self;
}

- (void)setThemeName:(NSString *)themeName {
    if (![_themeName isEqualToString:themeName]) {
        _themeName = [themeName copy];
        
        //将kthemeName 保存到本地
        [[NSUserDefaults standardUserDefaults] setObject:_themeName forKey:kThemeName];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //主题切换时 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNofication object:nil];
    }
}

- (UIImage *)getThemeImage:(NSString *)imageName {
    if (imageName.length == 0) {
        return nil;
    }
    NSString *themePath = [self themePath];
    NSString *filePath = [themePath stringByAppendingPathComponent:imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}
//获取主题包路径
- (NSString *)themePath {
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    NSString *themePath = [NSString stringWithFormat:@"skins/%@",_themeName];
    NSString *path = [bundlePath stringByAppendingPathComponent:themePath];
    return path;
}

@end
