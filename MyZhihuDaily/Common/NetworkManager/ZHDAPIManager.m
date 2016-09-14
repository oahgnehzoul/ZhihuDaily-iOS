//
//  ZHDAPIManager.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/2.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZHDAPIManager.h"
#import "ZHDBaseModel.h"

@implementation ZHDAPIManager

+ (instancetype)sharedInstance
{
    static ZHDAPIManager* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [ZHDAPIManager new];
    });

    return instance;
}

- (void)parseModel:(id)data modelClass:(Class)modelClass complete:(completeBlock)complete error :(errorBlock)error {
//    NSError *error;
//    ZHDBaseModel *model = [MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:data error:&error]
}

@end
