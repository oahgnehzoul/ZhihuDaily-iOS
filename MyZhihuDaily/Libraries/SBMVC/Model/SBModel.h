//
//  SBModel.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>
// model 的状态
typedef NS_OPTIONS(NSInteger, SBModelState) {
    SBModelStateError     = -1,
    SBModelStateReady     = 0,
    SBModelStateLoading   = 1,
    SBModelStateFinished  = 2
};

typedef NS_OPTIONS(NSUInteger, SBModelMode) {
    SBModelModeLoad     = 0,
    SBModelModeReload   = 1,
    SBModelModeLoadMore = 2
};

typedef NS_OPTIONS(NSUInteger, SBModelResponseMode) {
    SBModelResponseDefault    = 0,
    SBModelResponseList       = 1,
    SBModelResponseData       = 2
};
// 与 Request 参数设置相关的接口协议,需要子类复写
@protocol SBModelRequestDelegate <NSObject>

- (NSDictionary *)dataParams;
- (NSString *)urlPath;
- (NSArray *)parseResponse:(id)object error:(NSError **)error;

@optional
- (BOOL)useAuth;
- (BOOL)useCache;
- (BOOL)needLogin;
- (NSDictionary *)headerParams;
- (NSDictionary *)bodyData;
- (BOOL)usePost;
- (NSString *)customRequestClassName;

/**
 api cache 的 cache 时长

 @return  NSTimeInterval
 */
- (NSTimeInterval)apiCacheTimeOutSeconds;

- (BOOL)prepareForLoad;
- (BOOL)prepareParseResponse:(id)object error:(NSError **)error;

@end

// 与 Controller 相关的接口，传递给 VC
@protocol SBModelDelegate <NSObject>

@optional
- (void)modelDidStart:(SBModel *)model;
- (void)modelDidFinish:(SBModel *)model;
- (void)modelDidFail:(NSError *)error withModel:(SBModel *)model;

@end

@class SBItemList,SBRequest;
@interface SBModel : NSObject<SBModelRequestDelegate>


@property (nonatomic, assign, readonly) SBModelState state;
@property (nonatomic, assign, readonly) SBModelMode mode;
@property (nonatomic, weak) id<SBModelDelegate> delegate;

@property (nonatomic, strong, readonly) SBItemList *itemList;
@property (nonatomic, strong) id item;
@property (nonatomic, strong, readonly) NSError *error;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, assign) BOOL isFromCache;
@property (nonatomic, strong, readonly) id responseObject;
@property (nonatomic, strong, readonly) id responseString;
@property (nonatomic, strong, readonly) NSString *cacheKey;

- (void)load;
- (void)loadWithCompletion:(void(^)(SBModel *model,NSError *error))callBack;
- (void)reload;
- (void)reloadWithCompletioin:(void(^)(SBModel *model,NSError *error))callBack;
- (void)loadMore;
- (void)cancel;
- (void)reset;

@end
