//
//  SBItemList.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "SBItemList.h"

@implementation SBItemList
@synthesize array = _array;

+ (instancetype)array {
    return [[SBItemList alloc] init];
}

- (void)reset {
    self.currentPage = 0;
    self.totalCount = 0;
    self.hasMore = 0;
    [self removeAlObjects];
}

- (BOOL)hasMore {
    return (self.pageSize * self.currentPage) < self.totalCount;
}

- (NSUInteger)count {
    return self.array.count;
}

- (id)objectAtIndex:(NSUInteger)index {
    if (index < self.array.count) {
        return self.array[index];
    }
    return nil;
}

- (void)addObject:(id)object {
    [self.array addObject:object];
}

- (void)addObjectsFromArray:(NSArray *)array {
    [self.array addObjectsFromArray:array];
}

- (void)removeAlObjects {
    [self.array removeAllObjects];
}

- (void)removeObject:(id)object {
    [self.array removeObject:object];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id  _Nullable __unsafe_unretained [])buffer count:(NSUInteger)len {
    return [self.array countByEnumeratingWithState:state objects:buffer count:len];
}

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}


@end
