//
//  ZDStoryModel.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/20.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDStoryModel.h"
#import "ZDStoryItem.h"
@implementation ZDStoryModel

- (NSString *)urlPath {
    
    return [NSString stringWithFormat:@"https://news-at.zhihu.com/api/7/story/%@",self.storyId];
//    return @"https://news-at.zhihu.com/api/7/story/8806101";
}

- (NSDictionary *)dataParams {
    return @{};
}

- (NSArray *)parseResponse:(id)object error:(NSError *__autoreleasing *)error {
    ZDStoryItem *item = [ZDStoryItem itemWithDictioinary:object];
    self.item = object;
    return @[item];
}

@end
