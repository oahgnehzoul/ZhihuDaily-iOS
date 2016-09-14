//
//  ZHDAPIManager.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/2.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completeBlock) (id data);
typedef void (^errorBlock) (NSError *error);

@interface ZHDAPIManager : NSObject

+ (instancetype)sharedInstance;

# pragma mark - 启动页
- (void)requestLanuchImage:(completeBlock)complete error:(errorBlock)error;

- (void)parseModel:(id)data modelClass:(Class)modelClass complete:(completeBlock)complete error:(errorBlock)error;
@end
