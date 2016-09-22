//
//  ZDThemeModel.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/22.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDThemeModel.h"
#import "ZDThemeItem.h"
@implementation ZDThemeModel

- (NSString *)urlPath {
    if (self.currentPageIndex == 0) {
        return [NSString stringWithFormat:@"https://news-at.zhihu.com/api/7/theme/%@",self.themeId];
    } else {
        return [NSString stringWithFormat:@"https://news-at.zhihu.com/api/7/theme/%@/before/%@",self.themeId,self.storyId];
    }
}

- (NSDictionary *)dataParams {
    return @{};
}


- (NSArray *)parseResponse:(id)object error:(NSError *__autoreleasing *)error {
    
    ZDThemeItem *item = [ZDThemeItem itemWithDictioinary:object];
    if (self.currentPageIndex == 0) {
        self.item = item;
    }
    return item.stories;
}

@end
