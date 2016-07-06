//
//  storyModel.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/6.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "storyModel.h"

@implementation storyModel

- (NSDictionary *)attributeMapDictionary {
    NSDictionary *mapAtt = @{
                             @"image":@"image",
                             @"idStr":@"id",
                             @"ga_prefix":@"ga_prefix",
                             @"title":@"title"
                             };
    return mapAtt;
}

@end
