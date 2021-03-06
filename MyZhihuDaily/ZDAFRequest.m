//
//  ZDAFRequest.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/17.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDAFRequest.h"
#import "AFNetworking.h"
#import "ZDCache.h"
@interface ZDAFRequest ()<SBRequest,SBRequestDelegate>
@property (nonatomic, strong) AFHTTPRequestOperation *requestOperation;
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, copy) NSDictionary *queries;

@end
@implementation ZDAFRequest
@synthesize delegate = _delegate;
@synthesize useCache = _useCache;
@synthesize usePost = _usePost;
@synthesize useAuth = _useAuth;
@synthesize responseObject = _responseObject;
@synthesize responseString = _responseString;
@synthesize timeOutSeconds = _timeOutSeconds;
@synthesize apiCacheTimeOutSeconds = _apiCacheTimeOutSeconds;
@synthesize mode = _mode;
@synthesize isFromCache = _isFromCache;
@synthesize cacheKey = _cacheKey;


- (void)initRequestWithBaseURL:(NSString *)url {
    self.timeOutSeconds = 60.f;
    self.url = url;
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/plain",@"text/html", nil];
    self.manager.requestSerializer.timeoutInterval = self.timeOutSeconds;
}

- (void)addHeaderParams:(NSDictionary *)params {
    NSMutableDictionary *dic = @{}.mutableCopy;
    if (params) {
        [dic addEntriesFromDictionary:params];
    }
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
}

- (void)addBodyData:(NSDictionary *)data {

}

- (void)addParams:(NSDictionary *)params {

}

- (void)load {
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self requestDidStartLoad:self];
    });
    NSMutableURLRequest *request = [self.manager.requestSerializer requestWithMethod:self.usePost ? @"POST":@"GET" URLString:self.url parameters:self.queries error:nil];
    NSString *cacheKey = [NSString stringWithFormat:@"%@",request.URL];
    void (^ZDAFSuccess)(AFHTTPRequestOperation *request,id response) = ^(AFHTTPRequestOperation *operation,id response) {
        // readonly
        self->_responseObject = response;
        
        if (self.useCache) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:response];
                [[ZDCache shareInstance] storeData:data forKey:cacheKey];
            });
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self requestDidFinish:response];
            NSLog(@"#ZAFRequest requestDidFinish:%@",response);
        });
    };
    
    void (^ZDAFFailure)(AFHTTPRequestOperation *operation,NSError *error) = ^(AFHTTPRequestOperation *operation,NSError *error) {
        self->_responseString = [NSString stringWithFormat:@"%@",operation.response];
        if ([error.domain isEqualToString:NSURLErrorDomain]) {
            NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
            userInfo[NSLocalizedDescriptionKey] = [NSString stringWithFormat:@"网络异常%ld",error.code];
            error = [NSError errorWithDomain:NSURLErrorDomain code:error.code userInfo:userInfo];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self requestDidFailWithError:error];
            NSLog(@"#ZDAFRequest requestDidFailWithError:%@",error);
        });
    };
    
    if (self.useCache && [[ZDCache shareInstance] hasDataForKey:cacheKey expires:self.apiCacheTimeOutSeconds]) {
        NSData *data = [[ZDCache shareInstance] dataForKey:cacheKey expires:self.apiCacheTimeOutSeconds];
        if (data) {
            NSDictionary *responseObj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSLog(@"#ZDAFRequest requestDidFinish with cache :%@",responseObj);
                self.isFromCache = YES;
                [self requestDidFinish:responseObj];
            });
            return;
        }
    }
    
    self.isFromCache = NO;
    if (self.usePost) {
        self.requestOperation = [self.manager POST:self.url parameters:self.queries success:ZDAFSuccess failure:ZDAFFailure];
    } else {
        self.requestOperation = [self.manager GET:self.url parameters:self.queries success:ZDAFSuccess failure:ZDAFFailure];
    }
    
}

- (void)cancel {
    if (self.requestOperation) {
        [self.requestOperation cancel];
    }
}

- (void)requestDidStartLoad:(id)request {
    if ([self.delegate respondsToSelector:@selector(requestDidStartLoad:)]) {
        [self.delegate requestDidStartLoad:request];
    }
}

- (void)requestDidFinish:(id)JSON {
    if ([self.delegate respondsToSelector:@selector(requestDidFinish:)]) {
        [self.delegate requestDidFinish:JSON];
    }
}

- (void)requestDidFailWithError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(requestDidFailWithError:)]) {
        [self.delegate requestDidFailWithError:error];
    }
}

@end
