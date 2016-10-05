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
    NSMutableDictionary *ret = @{}.mutableCopy;
    [ret addEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
    [ret addEntriesFromDictionary:@{
                                    @"shareUrl":@"share_url",
                                    @"storyId":@"id"
                                    }];
    return ret;
}

@end
