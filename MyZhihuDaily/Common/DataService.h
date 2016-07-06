//
//  DataService.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/6.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef void(^BlockType) (id result);
@interface DataService : NSObject
//http://news-at.zhihu.com/api/4/news/latest

+ (AFHTTPRequestOperation *)requestAFUrl:(NSString *)urlString
                              httpMethod:(NSString *)method
                                  params:(NSMutableDictionary *)params //token  文本
                                    data:(NSMutableDictionary *)datas //文件
                                   block:(BlockType)block;

+ (void)requestUrl:(NSString *)urlStr
        params:(NSMutableDictionary *)params
        httpMethod:(NSString *)method
             block:(BlockType)block;

@end
