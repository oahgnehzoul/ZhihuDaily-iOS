//
//  SBItemProperty.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/17.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
typedef NS_ENUM(NSInteger, SBItemPropertyType) {
    
#pragma mark - Primitive Types
    
    SBItemPropertyTypeInt = 0,
    SBItemPropertyTypeFloat = 7,
    SBItemPropertyTypeDouble = 8,
    SBItemPropertyTypeBool = 9,
    SBItemPropertyTypeChar = 10,
    
#pragma mark - Object Types
    
    SBItemPropertyTypeString = 11,
    SBItemPropertyTypeNumber = 12,
    SBItemPropertyTypeData = 13,
    SBItemPropertyTypeAny = 14,
    SBItemPropertyTypeDate = 15,
    
#pragma mark - Linked Object Types
    
    SBItemPropertyTypeDictionary = 16,
    SBItemPropertyTypeArray = 17,
    SBItemPropertyTypeObject = 18,
    SBItemPropertyTypeItem = 19,
};

@interface SBItemProperty : NSObject

@property (nonatomic, strong, readonly) NSString *propertyName;
@property (nonatomic, assign, readonly) SBItemPropertyType propertyType;
@property (nonatomic, strong, readonly) NSString *propertyClass;

- (instancetype)initWithPropertyName:(NSString *)propertyName
                        objcProperty:(objc_property_t)objcProperty;
@end
