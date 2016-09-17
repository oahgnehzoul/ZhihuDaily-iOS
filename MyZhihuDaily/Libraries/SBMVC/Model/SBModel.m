//
//  SBModel.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "SBModel.h"
#import "SBItemList.h"
#import "SBRequest.h"

@interface SBModel ()<SBRequestDelegate>

@property (nonatomic, copy) void(^requestCallBack)(SBModel *model,NSError *error);
@property (nonatomic, strong) id <SBRequest> request;

@end

@implementation SBModel
@synthesize itemList = _itemList;

- (instancetype)init {
    if (self = [super init]) {
        self.key = NSStringFromClass([self class]);
    }
    return self;
}

- (void)dealloc {
    [self cancel];
    NSLog(@"[%@-->dealloc]",[self class]);
}

- (SBItemList *)itemList {
    if (!_itemList) {
        _itemList = [SBItemList array];
    }
    return _itemList;
}

- (void)load {
    _mode = SBModelModeLoad;
    [self reset];
    if ([self _prepareForLoad]) {
        [self loadInternal];
    }
}

- (void)cancel {
    if (self.request) {
        [self.request cancel];
        self.request = nil;
    }
    _state = SBModelStateReady;
}

- (void)reset {
    [self cancel];
    _item = nil;
    [self.itemList reset];
}

- (void)loadWithCompletion:(void (^)(SBModel *, NSError *))callBack {
    if (callBack) {
        self.requestCallBack = callBack;
    }
    [self load];
}

- (void)loadMore {
    _mode = SBModelModeLoadMore;
    [self loadInternal];
}

- (void)reload {
    _mode = SBModelModeReload;
    [self reset];
    if ([self _prepareForLoad]) {
        [self loadInternal];
    }
}

- (void)reloadWithCompletioin:(void (^)(SBModel *, NSError *))callBack {
    if (callBack) {
        self.requestCallBack = callBack;
    }
    [self reload];
}

- (void)loadInternal {
    _error = nil;
    NSDictionary *dataParams = [self dataParams];
    self.request = [NSClassFromString([self customRequestClassName]) new];
    self.request.useAuth = [self useAuth];
    self.request.useCache = (_mode == SBModelModeLoad) ? [self useCache] : NO;
    self.request.delegate = self;
    self.request.usePost = [self usePost];
    self.request.apiCacheTimeOutSeconds = [self apiCacheTimeOutSeconds];
    self.request.mode = self.mode;
    [self.request initRequestWithBaseURL:[self urlPath]];
    [self.request addParams:dataParams];
    [self.request addHeaderParams:[self headerParams]];
    
    if ([self usePost]) {
        [self.request addBodyData:[self bodyData]];
    }

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.request load];
    });
}
#pragma mark - SubClassing
- (NSDictionary *)dataParams {
    return @{};
}

- (NSString *)urlPath {
    return @"";
}

- (NSArray *)parseResponse:(id)object error:(NSError **)error {
    return nil;
}

- (BOOL)prepareForLoad {
    return YES;
}

- (BOOL)prepareParseResponse:(id)object error:(NSError **)error {
    return YES;
}

- (NSDictionary *)headerParams {
    return nil;
}

- (BOOL)useAuth {
    return NO;
}

- (BOOL)useCache {
    return NO;
}

- (BOOL)usePost {
    return NO;
}

- (NSDictionary *)bodyData {
    return nil;
}

- (NSTimeInterval)apiCacheTimeOutSeconds {
    return (double)1000 * 60 * 60 * 24 * 365 * 10;
}

- (NSString *)customRequestClassName {
    return @"SBRequest";
}
#pragma mark - SBRequestDelegate,SBRequest 传递过来的状态.
- (void)requestDidStartLoad:(id)request {
    _state = SBModelStateLoading;
    if ([self.delegate respondsToSelector:@selector(modelDidStart:)]) {
        [self.delegate modelDidStart:self];
    }
}

- (void)requestDidFinish:(id)JSON {
    self.isFromCache = self.request.isFromCache;
    _state = SBModelStateFinished;
    _responseObject = self.request.responseObject;
    _responseString = self.request.responseString;
    _cacheKey = self.request.cacheKey;
    
    BOOL ret = [self parse:JSON];
    if (ret) {
        if ([self.delegate respondsToSelector:@selector(modelDidFinish:)]) {
            [self.delegate modelDidFinish:self];
        }
        if (self.requestCallBack) {
            self.requestCallBack(self,nil);
        }
    }
}

- (void)requestDidFailWithError:(NSError *)error {
    self.isFromCache = self.request.isFromCache;
    _state = SBModelStateError;
    _error = error;
    _responseString = self.request.responseString;
    _responseObject = self.request.responseObject;
    
    if ([self.delegate respondsToSelector:@selector(modelDidFail:withModel:)]) {
        [self.delegate modelDidFail:error withModel:self];
    }
    if (self.requestCallBack) {
        self.requestCallBack(self,error);
    }
}

#pragma mark - private

- (BOOL)_prepareForLoad {
    NSString *method = [self urlPath];
    if (!method || method.length ==0) {
        [self requestDidFailWithError:[NSError errorWithDomain:@"SBMVCErrorDomain" code:999 userInfo:@{NSLocalizedDescriptionKey:@"缺少方法名"}]];
        return NO;
    } else {
        if (self.state == SBModelStateLoading) {
            [self cancel];
        }
        return [self prepareForLoad];
    }
}

- (BOOL)parse:(id)JSON {
    NSError *error = nil;
    if (![self prepareParseResponse:JSON error:&error] && error) {
        [self requestDidFailWithError:error];
        return NO;
    }
    NSArray *list = [self parseResponse:JSON error:&error];
    if (error) {
        [self requestDidFailWithError:error];
        return NO;
    } else {
        [self.itemList addObjectsFromArray:list];
        return YES;
    }
}


@end
