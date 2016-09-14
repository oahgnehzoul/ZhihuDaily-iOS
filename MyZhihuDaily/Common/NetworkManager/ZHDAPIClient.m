//
//  ZHDAPIClient.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/2.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZHDAPIClient.h"

@implementation ZHDAPIClient

+ (instancetype)sharedJsonClient
{
    static ZHDAPIClient* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [ZHDAPIClient new];
    });

    return instance;
}

- (void)requestJsonDataWithPath:(NSString *)path
                         params:(NSDictionary *)params
                     MethodType:(NetworkMethod)method
                          Block:(dataBlock)block {
    if (!path || path.length <= 0) {
        return;
    }
    
//    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    switch (method) {
        case Get:{
            NSMutableString *localPath = [path mutableCopy];
            if (params) {
                [localPath appendString:params.description];
            }
            [self GET:path parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                block(responseObject,nil);
            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                block(nil,error);
            }];
            break;
        }
        case Post: {
            [self POST:path parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                block(responseObject,nil);
            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                block(nil,error);
            }];
        }
        default:
            break;
    }
}

@end
