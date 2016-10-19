//
//  ZDCache.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/10/19.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDCache.h"
#import <CommonCrypto/CommonDigest.h>

@interface ZDCache ()

@property (nonatomic, copy) NSString *cachePath;

@end

@implementation ZDCache

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static ZDCache *obj;
    dispatch_once(&onceToken, ^{
        obj = [[ZDCache alloc] init];
    });
    return obj;
}

+ (NSString *)cachePathWithName:(NSString *)name {
    /**
     获取 Documents 文件夹目录

     @param NSDocumentDirectory  Document 目录
     @param NSUserDomainMask     在当前沙盒范围内查找
     @param YES                  展开路径，NO 为不展开

     @return  名字为 name 的沙盒路径
     */
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:name];
    [self cratePathIfNecessary:path];
    return path;
}

+ (BOOL)cratePathIfNecessary:(NSString *)path {
    BOOL successed = YES, isDir;
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path isDirectory:&isDir] && isDir) {
        successed = [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return successed;
}

- (NSString *)cachePathForKey:(NSString *)key {
    NSString *path = [self md5:key];
    return [self.cachePath stringByAppendingPathComponent:path];
}

- (void)storeData:(NSData *)data forKey:(NSString *)key {
    NSString *filePath = [self cachePathForKey:key];
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager createFileAtPath:filePath contents:data attributes:nil];
}

- (BOOL)hasDataForKey:(NSString *)key expires:(NSTimeInterval)expirationTime {
    NSString *filePath = [self cachePathForKey:key];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        NSDictionary *attrs = [manager attributesOfItemAtPath:filePath error:nil];
        NSDate *modified = [attrs objectForKey:NSFileModificationDate];
        if ([modified timeIntervalSinceNow] < -expirationTime) {
            [self removeForKey:key];
            return NO;
        }
        return YES;
    }
    return NO;
}

- (NSData *)dataForKey:(NSString *)key expires:(NSTimeInterval)expirationTime {
    NSString *filePath = [self cachePathForKey:key];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        NSDictionary *attrs = [manager attributesOfItemAtPath:filePath error:nil];
        NSDate *modified = [attrs objectForKey:NSFileModificationDate];
        if ([modified timeIntervalSinceNow] > expirationTime) {
            return nil;
        }
        return [NSData dataWithContentsOfFile:filePath];
    }
    return nil;
}

- (NSString *)filePathForKey:(NSString *)key expires:(NSTimeInterval)expirationTime {
    NSString *filePath = [self cachePathForKey:key];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        NSDictionary *attrs = [manager attributesOfItemAtPath:filePath error:nil];
        NSDate *modified = [attrs objectForKey:NSFileModificationDate];
        if (fabs([modified timeIntervalSinceNow]) > expirationTime) {
            return nil;
        }
        return filePath;
    }
    return nil;
}


- (void)removeForKey:(NSString *)key {
    if (!key) {
        return;
    }
    NSString *filePath = [self cachePathForKey:key];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (filePath && [manager fileExistsAtPath:filePath]) {
        [manager removeItemAtPath:filePath error:nil];
    }
}

- (void)removeAll {
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:self.cachePath error:nil];
    [ZDCache cratePathIfNecessary:self.cachePath];
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
}

- (void)autoRemove:(NSTimeInterval)expirationTime {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSFileManager *manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath:self.cachePath]) {
            NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:self.cachePath] objectEnumerator];
            NSString *key;
            while ((key = [childFilesEnumerator nextObject]) != nil) {
                NSString *filePath = [self.cachePath stringByAppendingString:key];
                NSDictionary *attrs = [manager attributesOfItemAtPath:filePath error:nil];
                NSDate *modified = [attrs objectForKey:NSFileModificationDate];
                if ([modified timeIntervalSinceNow] < -expirationTime) {
                    [manager removeItemAtPath:filePath error:nil];
                }
            }
        }
    });
}

- (CGFloat)cacheSize {
    NSFileManager *manager = [NSFileManager defaultManager];
    // Library/Caches 文件目录
    NSString *cacheDictionary = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSArray *cacheFiles = @[];
    NSEnumerator *cacheEnumerator;
    NSString *cacheFilePath;
    unsigned long long cacheFolderSize = 0;
    cacheFiles = [manager subpathsOfDirectoryAtPath:cacheDictionary error:nil];
    cacheEnumerator = [cacheFiles objectEnumerator];
    while (cacheFilePath = [cacheEnumerator nextObject]) {
        NSDictionary *cacheFileAttributes = [manager attributesOfItemAtPath:[cacheDictionary stringByAppendingPathComponent:cacheFilePath] error:nil];
        cacheFolderSize += [cacheFileAttributes fileSize];
    }
//    MB
    return cacheFolderSize / 1024 / 1024;
}

- (NSString *)cachePath {
    if (!_cachePath) {
        _cachePath = [ZDCache cachePathWithName:@"ZDCache"];
    }
    return _cachePath;
}

- (NSString *)md5:(NSString *)aString {
    const char *cStr = [aString UTF8String];
    
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

@end
