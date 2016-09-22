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
    return self.isLatest ? @"http://news-at.zhihu.com/api/4/stories/latest" :[NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/news/before/%@",self.dateStr ?:@"20160910"];
}

- (NSDictionary *)dataParams {
    return @{};
}

- (NSArray *)parseResponse:(id)object error:(NSError *__autoreleasing *)error {
    NSMutableArray *array = @[].mutableCopy;
    [array addObjectsFromArray:self.dates];
    if (object[@"date"]) {
        self.dateStr = object[@"date"];
        [array addObject:self.dateStr];
        self.dates = array;
    }
    
    if (object[@"top_stories"]) {
        NSArray *items = [ZDHomeStoryItem itemsWithArray:object[@"top_stories"]];
        [items enumerateObjectsUsingBlock:^(ZDHomeStoryItem *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isHome = YES;
        }];
        self.stories = items;
    }
    NSMutableArray *ids = @[].mutableCopy;
    [ids addObjectsFromArray:self.storyIds];
    if (object[@"stories"]) {
        NSArray *items = [ZDHomeStoryItem itemsWithArray:object[@"stories"]];
        [items enumerateObjectsUsingBlock:^(ZDHomeStoryItem *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [ids addObject:obj.storyId];
        }];
        self.storyIds = ids;
        
        return [ZDHomeStoryItem itemsWithArray:object[@"stories"]];
    }
    return @[];
    
}

@end
