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
        self.pageMode = SBModelPageReturnCount;
    }
    return self;
}

- (NSUInteger)pageSize {
    return 13;
}

@end
