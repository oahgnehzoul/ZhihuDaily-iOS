//
//  ZDStoryItem.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/20.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDStoryItem.h"

@implementation ZDStoryItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"imageSource":@"image_source",
             @"shareUrl":@"share_url",
             @"storyId":@"id"
             };
}

@end
