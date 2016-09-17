//
//  ZDGetThemeModel.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/17.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDGetThemeModel.h"
#import "ZDLeftThemeItem.h"
@implementation ZDGetThemeModel

- (NSDictionary *)dataParams {
    return @{};
}

- (BOOL)useCache {
    return NO;
}

- (NSString *)urlPath {
    return @"http://news-at.zhihu.com/api/7/themes";
}

- (NSArray *)parseResponse:(id)object error:(NSError *__autoreleasing *)error {
    NSLog(@"object:%@",object);
    NSMutableArray *items = @[].mutableCopy;
    ZDLeftThemeItem *firstItem = [ZDLeftThemeItem itemWithDictioinary:@{
                                                                        @"name":@"首页"
                                                                        }];
    firstItem.isSelected = YES;
    firstItem.isSubcribed = YES;
    [items addObject:firstItem];
    NSArray *subcribedThemes = object[@"subcribed"];
    [subcribedThemes enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZDLeftThemeItem *item = [ZDLeftThemeItem itemWithDictioinary:obj];
        item.isSubcribed = YES;
        [items addObject:item];
    }];
    
    [object[@"others"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZDLeftThemeItem *item = [ZDLeftThemeItem itemWithDictioinary:obj];
        item.isSubcribed = NO;
        item.isSelected = NO;
        [items addObject:item];
    }];
    
    [items enumerateObjectsUsingBlock:^(ZDLeftThemeItem *  _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        item.index = idx;
    }];
    return items;
}

@end
