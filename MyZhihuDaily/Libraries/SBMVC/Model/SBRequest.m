//
//  SBRequest.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "SBRequest.h"

@implementation SBRequest

@synthesize useAuth = _useAuth;
@synthesize useCache = _useCache;
@synthesize usePost = _usePost;
@synthesize isFromCache = _isFromCache;
@synthesize mode = _mode;
@synthesize timeOutSeconds = _timeOutSeconds;
@synthesize apiCacheTimeOutSeconds = _apiCacheTimeOutSeconds;
@synthesize delegate = _delegate;
@synthesize responseObject = _responseObject;
@synthesize responseString = _responseString;
@synthesize cacheKey = _cacheKey;

- (void)initRequestWithBaseURL:(NSString *)url {

}

- (void)addHeaderParams:(NSDictionary *)params {

}

- (void)addParams:(NSDictionary *)params {

}

- (void)addBodyData:(NSDictionary *)data {

}

- (void)load {

}

- (void)cancel {

}
@end
