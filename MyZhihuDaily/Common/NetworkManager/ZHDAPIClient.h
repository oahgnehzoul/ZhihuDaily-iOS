//
//  ZHDAPIClient.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/2.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} NetworkMethod;
typedef void (^dataBlock)(id data, NSError *error);

@interface ZHDAPIClient : AFHTTPRequestOperationManager

+ (instancetype)sharedJsonClient;

- (void)requestJsonDataWithPath:(NSString *)path
                         params:(NSDictionary *)params
                     MethodType:(NetworkMethod)method
                          Block:(dataBlock)block;

@end
