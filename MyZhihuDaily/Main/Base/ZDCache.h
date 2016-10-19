//
//  ZDCache.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/10/19.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDCache : NSObject

+ (instancetype)shareInstance;

+ (NSString *)cachePathWithName:(NSString *)name;

- (BOOL)hasDataForKey:(NSString *)key expires:(NSTimeInterval )expirationTime;

- (NSData *)dataForKey:(NSString *)key expires:(NSTimeInterval )expirationTime;

- (NSString *)filePathForKey:(NSString *)key expires:(NSTimeInterval )expirationTime;

- (void)storeData:(NSData *)data forKey:(NSString *)key;

- (void)removeForKey:(NSString *)key;

- (void)removeAll;

- (void)autoRemove:(NSTimeInterval )expirationTime;

- (CGFloat)cacheSize;

@end
