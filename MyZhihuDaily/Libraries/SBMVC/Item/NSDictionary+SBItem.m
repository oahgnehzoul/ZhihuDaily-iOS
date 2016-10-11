//
//  NSDictionary+SBItem.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/17.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "NSDictionary+SBItem.h"

@implementation NSDictionary (SBItem)
// 兼容 key 点语法。dic[a.b] -->  dic[a][b]
- (id)sb_valueForJSONKeyPath:(NSString *)JSONKeyPath {
    NSArray *components = [JSONKeyPath componentsSeparatedByString:@"."];
    id ret = self;
    for (NSString *component in components) {
        if (ret == nil || ret == [NSNull null] || ![ret isKindOfClass:[NSDictionary class]]) {
            break;
        }
        ret = ret[component];
    }
    return ret;
}

@end
