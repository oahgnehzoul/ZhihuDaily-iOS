//
//  ZDListModel.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/17.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDListModel.h"

@implementation ZDListModel

- (NSString *)customRequestClassName {
    return @"ZDAFRequest";
}

- (instancetype)init {
    if (self = [super init]) {
        //因为 返回的数据条数不固定，// changed 9.22
        self.pageMode = SBModelPageDefault;
    }
    return self;
}

- (NSUInteger)pageSize {
    return 13;
}

@end
