//
//  SBItem.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "SBItem.h"
#import <objc/runtime.h>
#import "NSDictionary+SBItem.h"

static void *SBItemCachedPropertyKeysKey = &SBItemCachedPropertyKeysKey;
static void *SBItemCachedPropertyInfos = &SBItemCachedPropertyInfos;

@implementation SBItem

static inline id SBTransformNormalValueForClass(id val, NSString *className) {
    id ret = val;
    
    Class valClass = [val class];
    Class kls = nil;
    if (className.length > 0) {
        kls = NSClassFromString(className);
    }
    
    if (!kls || !valClass) {
        ret = nil;
    } else if (![kls isSubclassOfClass:[val class]] &&
               ![valClass isSubclassOfClass:kls]) {
        ret = nil;
    }
    
    return ret;
}


+ (instancetype)itemWithDictioinary:(NSDictionary *)dictionary {
    SBItem *item = [[self alloc] init];
    [item autoKVCBinding:dictionary];
    return item;
}

+ (NSArray *)itemsWithArray:(NSArray *)array {
    NSMutableArray *items = @[].mutableCopy;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [items addObject:[self itemWithDictioinary:obj]];
    }];
    return items.mutableCopy;
}

- (void)autoKVCBinding:(NSDictionary *)dictionary {
    // Item 自定义的属性 map:{@"carName":@"name"};
    NSDictionary *JSONKeyPathsByPropertyKey = [self.class JSONKeyPathsByPropertyKey];
    
    NSDictionary *propertyInfos = [self.class propertyInfos];
    [propertyInfos enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, SBItemProperty  *_Nonnull propertyInfo, BOOL * _Nonnull stop) {
        NSString *propertyName = propertyInfo.propertyName; //model自定义的属性名,carName
//        NSString *propertyClassName = propertyInfo.propertyClass;
        NSString *JSONKey = propertyName; //返回的JSON数据的 key，默认为 model 中定义的 属性名，
        // 如果方法中重定义，覆盖
        if ([JSONKeyPathsByPropertyKey objectForKey:propertyName]) {
            JSONKey = JSONKeyPathsByPropertyKey[propertyName];
        }
        
        id value = [dictionary sb_valueForJSONKeyPath:JSONKey];
        if (value == nil || value == [NSNull null]) {
            return;
        }
        Class propertyClass = nil;
        if (propertyInfo.propertyClass.length > 0) {
            propertyClass = NSClassFromString(propertyInfo.propertyClass);
        }

        switch (propertyInfo.propertyType) {
            case SBItemPropertyTypeBool:{
                if ([value isKindOfClass:[NSString class]]) {
                    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
                    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    value = [numberFormatter numberFromString:value];
                } else {
                    value = SBTransformNormalValueForClass(value, NSStringFromClass([NSNumber class]));
                }

                break;
            }
            case SBItemPropertyTypeChar:
            {
                if ([value isKindOfClass:[NSString class]]) {
                    char firstCharacter = [value characterAtIndex:0];
                    value = [NSNumber numberWithChar:firstCharacter];
                } else {
                    value = SBTransformNormalValueForClass(value, NSStringFromClass([NSNumber class]));
                }
                break;
            }
            case SBItemPropertyTypeString:
            {
                if ([value isKindOfClass:[NSNumber class]]) {
                    value = [value stringValue];
                } else {
                    value = SBTransformNormalValueForClass(value, NSStringFromClass([NSString class]));
                }
                break;
            }
            case SBItemPropertyTypeNumber:
            {
                if ([value isKindOfClass:[NSString class]]) {
                    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
                    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    value = [numberFormatter numberFromString:value];
                } else {
                    value = SBTransformNormalValueForClass(value, NSStringFromClass([NSNumber class]));
                }
                break;
            }
            case SBItemPropertyTypeData:
            {
                value = SBTransformNormalValueForClass(value, NSStringFromClass([NSData class]));
                break;
            }
            case SBItemPropertyTypeDate:
            {
                value = SBTransformNormalValueForClass(value, NSStringFromClass([NSDate class]));
                break;
            }
            case SBItemPropertyTypeDictionary:
            {
                value = SBTransformNormalValueForClass(value, NSStringFromClass([NSDictionary class]));
                break;
            }
            case SBItemPropertyTypeArray:
            {
                if (propertyClass && [propertyClass isSubclassOfClass:[SBItem class]]) {
                    value = [propertyClass itemsWithArray:value];
                } else {
                    value = SBTransformNormalValueForClass(value, NSStringFromClass([NSArray class]));
                }
                break;
            }
            case SBItemPropertyTypeItem:
            {
                if (propertyClass) {
                    if ([propertyClass isSubclassOfClass:[SBItem class]] &&
                        [value isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *oldVal = value;
                        value = [propertyClass new];
                        [value autoKVCBinding:oldVal];
                    } else {
                        value = SBTransformNormalValueForClass(value, propertyInfo.propertyClass);
                    }
                }
                break;
            }
            default:
                break;
        }
        
        if (value && value != [NSNull null]) {
            [self setValue:value forKey:propertyName];
        }
        
    }];
}


+ (NSDictionary *)propertyInfos {
    NSDictionary *cachedInfos = objc_getAssociatedObject(self, SBItemCachedPropertyInfos);
    if (cachedInfos) {
        return cachedInfos;
    }
    NSMutableDictionary *ret = @{}.mutableCopy;
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(self, &count);
    for (int i = 0; i < count; i++) {
        NSString *propertyName = @(property_getName(properties[i]));
        SBItemProperty *propertyInfo = [[SBItemProperty alloc] initWithPropertyName:propertyName objcProperty:properties[i]];
        [ret setValue:propertyInfo forKey:propertyName];
    }
    
    Class superClass = class_getSuperclass(self);
    if (superClass && ![superClass isEqual:[SBItem class]] && ![superClass isEqual:[SBTableViewItem class]]) {
        NSDictionary *superPropertyInfos = [superClass propertyInfos];
        [ret addEntriesFromDictionary:superPropertyInfos];
    }
    free(properties);
    objc_setAssociatedObject(self, SBItemCachedPropertyInfos, ret, OBJC_ASSOCIATION_COPY);
    return ret;
}

+ (NSSet *)propertyKeys {
    //查找之前是否利用 runtime 给 Class 添加过属性，如果添加过就说明我们已经获取过了，没必要重复获取一个类的所有 property，如果没有，就通过 runtime 获取 class 的所有 property 的名字，并利用 objc_setAssociatedObject 给 class 添加属性。
    NSSet *cachedKeys = objc_getAssociatedObject(self, SBItemCachedPropertyKeysKey);
    if (cachedKeys) {
        return cachedKeys;
    }
    NSMutableSet *keys = [NSMutableSet set];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(self, &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        [keys addObject:@(propertyName)];
    }
    
    Class superClass = class_getSuperclass(self);
    if (superClass && ![NSStringFromClass(superClass) isEqualToString:@"SBItem"] && ![NSStringFromClass(superClass) isEqualToString:@"SBTableViewItem"]) {
        NSSet *superPropertyKeys = [superClass propertyKeys];
        [keys addObjectsFromArray:(NSArray *)superPropertyKeys];
    }
    
    free(properties);
    
    objc_setAssociatedObject(self, SBItemCachedPropertyKeysKey, keys, OBJC_ASSOCIATION_COPY);
    
    return keys;
    
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             [self propertyKeys]:[self propertyKeys]
             }.mutableCopy;
}

@end
