//
//  DataService.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/6.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "DataService.h"
#import "JSONKit.h"
@implementation DataService

+ (AFHTTPRequestOperation *)requestAFUrl:(NSString *)urlString httpMethod:(NSString *)method params:(NSMutableDictionary *)params data:(NSMutableDictionary *)datas block:(BlockType)block {
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
//    NSString *accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
    
//    [params setValue:accessToken forKey:@"access_token"];
    NSString *urlStr = [BaseUrl stringByAppendingString:urlString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    if ([method isEqualToString:@"GET"]) {
        AFHTTPRequestOperation *operation =  [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            block(responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"传输失败 ");
            NSLog(@"%@",error);
        }];
        return  operation;
        
    }else if ([method isEqualToString:@"POST"]) {
        if (datas != nil) {
            AFHTTPRequestOperation *operation = [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                for (NSString *name in datas) {
                    NSData *data = [datas objectForKey:name];
                    [formData appendPartWithFileData:data name:name fileName:@"1.png" mimeType:@"image/jpeg"];
                }
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"图片上传成功");
                block(responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"图片上传失败");
            }];
            [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                NSLog(@"上传进度,已经上传 %lld",totalBytesWritten);
            }];
            return operation;
        }else { //不带图片
            AFHTTPRequestOperation *operation = [manager POST:urlString parameters:params success:^void(AFHTTPRequestOperation *operation , id responseObject ) {
                NSLog(@"POST成功");
                
                block(responseObject);
            } failure:^void(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
            return operation;
            
        }
        
        
    }
    return nil;
    
    
}

+ (void)requestUrl:(NSString *)urlStr params:(NSMutableDictionary *)params httpMethod:(NSString *)method block:(BlockType)block {
    NSString *str = @"http://news-at.zhihu.com";
    NSString *urlString = [NSString stringWithFormat:@"%@%@",str,urlStr];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:method];
    NSArray *allKeys = [params allKeys];
    NSMutableString *paramsString = [[NSMutableString alloc] init];
    for (int i = 0; i < allKeys.count; i++) {
        NSString *key = allKeys[i];
        NSString *value = [params objectForKey:key];
        [paramsString appendFormat:@"%@=%@",key,value];
        if (i < allKeys.count - 1) {
            [paramsString appendString:@"&"];
        }
    }
    if ([method isEqualToString:@"POST"]) {
        NSData *data = [paramsString dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
    }
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError ) {
            NSLog(@"请求失败");
        }
        id result = [data objectFromJSONData];
        if (block) {
            block(result);
        }
    }];
}
@end
