//
//  SBItem.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBItemProperty.h"

#define SB_ARRAY_TYPE(VAL)\
        @protocol VAL <NSObject>\
        @end

@interface SBItem : NSObject

+ (instancetype)itemWithDictioinary:(NSDictionary *)dictionary;
+ (NSArray *)itemsWithArray:(NSArray *)array;
- (void)autoKVCBinding:(NSDictionary *)dictionary;
//- (NSDictionary *)convertToDictionary;

// 返回所有的属性名称集合，
+ (NSSet *)propertyKeys;


+ (NSDictionary *)JSONKeyPathsByPropertyKey;



@end
