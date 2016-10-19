//
//  ZDLaunchModel.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/20.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDLaunchModel.h"

@implementation ZDLaunchModel

- (NSString *)urlPath {
    NSString *str = [NSString stringWithFormat:@"%@%.f*%.f",@"http://news-at.zhihu.com/api/4/start-image/",kMainScreenWidth,kMainScreenHeight];
    return str;
}

- (NSDictionary *)dataParams {
    return @{};
}

- (NSArray *)parseResponse:(id)object error:(NSError *__autoreleasing *)error {
    self.text = object[@"text"];
    self.imageUrl = object[@"img"];
    return @[];
}

- (BOOL)useCache {
    return NO;
}

@end
