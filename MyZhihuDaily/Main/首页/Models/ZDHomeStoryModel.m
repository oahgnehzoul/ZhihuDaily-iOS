//
//  ZDHomeStoryModel.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/18.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDHomeStoryModel.h"
#import "ZDHomeStoryItem.h"
@implementation ZDHomeStoryModel

- (NSString *)urlPath {
    //4.0以后需要登录
    return @"http://news-at.zhihu.com/api/4/stories/latest";
}

- (NSDictionary *)dataParams {
    return @{};
}

- (NSArray *)parseResponse:(id)object error:(NSError *__autoreleasing *)error {
    if (object[@"date"]) {
        self.dateStr = object[@"date"];
    }
    
    if (object[@"top_stories"]) {
        NSArray *items = [ZDHomeStoryItem itemsWithArray:object[@"top_stories"]];
        [items enumerateObjectsUsingBlock:^(ZDHomeStoryItem *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isHome = YES;
        }];
        self.stories = items;
    }
    if (object[@"stories"]) {
        return [ZDHomeStoryItem itemsWithArray:object[@"stories"]];
    }
    return @[];
    
}

@end
