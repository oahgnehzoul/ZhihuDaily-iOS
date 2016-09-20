//
//  ZDHomeStoryItem.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/18.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDHomeStoryItem.h"

@implementation ZDHomeStoryItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"storyId":@"id",
             @"source":@"image_source"
             };
}

@end
