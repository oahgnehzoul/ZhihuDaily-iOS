//
//  ThemeModel.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/7.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "ThemeModel.h"

@implementation ThemeModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _idStr = [value stringValue];
        
    }
//    if ([key isEqualToString:@"images"]) {
//        _images = value[0];
//    }
    
}

@end
