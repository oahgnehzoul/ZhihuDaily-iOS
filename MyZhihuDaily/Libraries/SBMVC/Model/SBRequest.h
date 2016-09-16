//
//  SBRequest.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>
// 传递给 model 的网络请求状态（开始，结束，失败）
@protocol SBRequestDelegate <NSObject>

- (void)requestDidStartLoad:(id)request;
- (void)requestDidFinish:(id)JSON;
- (void)requestDidFailWithError:(NSError *)error;

@end
// 传递给 model 需要的数据，从而设置 model 的参数
@protocol SBRequest <NSObject>

@property (nonatomic, assign) BOOL useAuth;
@property (nonatomic, assign) BOOL useCache;
@property (nonatomic, assign) BOOL usePost;
@property (nonatomic, assign) BOOL isFromCache;
@property (nonatomic, assign) SBModelMode mode;
@property (nonatomic, assign) NSTimeInterval timeOutSeconds;
@property (nonatomic, assign) NSTimeInterval apiCacheTimeOutSeconds;
@property (nonatomic, weak) id<SBRequestDelegate> delegate;

@property (nonatomic, strong, readonly) NSString *responseString;
@property (nonatomic, strong, readonly) id responseObject;
@property (nonatomic, strong, readonly) NSString *cacheKey;

- (void)initRequestWithBaseURL:(NSString *)url;
- (void)addParams:(NSDictionary *)params;
- (void)addHeaderParams:(NSDictionary *)params;
- (void)addBodyData:(NSDictionary *)data;
- (void)load;
- (void)cancel;

@end

@interface SBRequest : NSObject<SBRequest>

@end
