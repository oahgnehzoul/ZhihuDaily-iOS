//
//  SBViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "SBViewController.h"
#import <libkern/OSAtomic.h>
#import "SBModel.h"

@interface SBViewController ()<SBModelDelegate>

{
    OSSpinLock _lock;
}
@end

@implementation SBViewController
- (instancetype)init {
    if (self = [super init]) {
        _modelDictInternal = @{}.mutableCopy;
        _lock = OS_SPINLOCK_INIT;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dealloc {
    NSLog(@"[%@-->dealloc]",[self class]);
}

- (NSDictionary *)modelDictionary {
    return [_modelDictInternal copy];
}

- (void)registerModel:(SBModel *)model {
    NSAssert(model.key, @"model must have a key");
    model.delegate = self;
    OSSpinLockLock(&_lock);
    [_modelDictInternal setObject:model forKey:model.key];
    OSSpinLockUnlock(&_lock);
}

- (void)unRegisterModel:(SBModel *)model {
    NSAssert(model.key, @"model must have a key");
    OSSpinLockLock(&_lock);
    [_modelDictInternal removeObjectForKey:model.key];
    OSSpinLockUnlock(&_lock);
}

- (void)load {
    if ([self prepareForLoad]) {
        [_modelDictInternal enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, SBModel *  _Nonnull model, BOOL * _Nonnull stop) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [model load];
            });
        }];
    }
}

- (void)loadMore {
    
}

- (void)reload {
    [_modelDictInternal enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, SBModel *  _Nonnull model, BOOL * _Nonnull stop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [model reload];
        });
    }];

}

- (BOOL)prepareForLoad {
    return YES;
}

#pragma mark SBModelDelegate

- (void)modelDidStart:(SBModel *)model {
    [self showLoading:model];
}

- (void)modelDidFinish:(SBModel *)model {
    [self didLoadModel:model];
    if ([self canShowModel:model]) {
        [self showModel:model];
    } else {
        [self showEmpty:model];
    }
}

- (void)modelDidFail:(NSError *)error withModel:(SBModel *)model {
    [self showError:error withModel:model];
}

#pragma mark SubClassing

- (void)didLoadModel:(SBModel *)model {
}

- (BOOL)canShowModel:(SBModel *)model {
    if ([_modelDictInternal.allKeys containsObject:model.key]) {
        return YES;
    }
    return NO;
}

- (void)showModel:(SBModel *)model {
}

- (void)showEmpty:(SBModel *)model {
}

- (void)showLoading:(SBModel *)model {
}

- (void)showError:(NSError *)error withModel:(SBModel *)model {
}

@end
