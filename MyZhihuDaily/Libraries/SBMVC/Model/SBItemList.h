//
//  SBItemList.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SBMockedNSMutableArray <NSObject>

+ (instancetype)array;
@optional


- (NSUInteger)count;
- (id)objectAtIndex:(NSUInteger)index;
- (void)addObject:(id)object;
- (void)addObjectsFromArray:(NSArray *)array;
- (void)removeAlObjects;
- (void)removeObject:(id)object;

@end

@interface SBItemList : NSObject<SBMockedNSMutableArray,NSFastEnumeration>

@property (nonatomic, strong, readonly) NSMutableArray *array;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) NSUInteger totalCount;
@property (nonatomic, assign) NSUInteger pageSize;
@property (nonatomic, assign) BOOL hasMore;

- (void)reset;

- (BOOL)hasMore;

@end
