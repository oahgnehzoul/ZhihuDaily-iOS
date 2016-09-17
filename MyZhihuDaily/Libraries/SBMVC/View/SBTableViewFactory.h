//
//  SBTableViewFactory.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/17.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBTableViewFactory : NSObject
+ (UIView *)getClickableFooterView:(CGRect)frame Text:(NSString *)text Target:(id)target Action:(SEL)action;
+ (UIView *)getNormalFooterView:(CGRect)frame Text:(NSString *)text;
+ (UIView *)getLoadingFooterView:(CGRect)frame Text:(NSString *)text;
+ (UIView *)getErrorFooterView:(CGRect)frame Text:(NSString *)text;

@end
