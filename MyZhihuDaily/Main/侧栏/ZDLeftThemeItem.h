//
//  ZDLeftThemeItem.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/17.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "SBTableViewItem.h"

@interface ZDLeftThemeItem : SBTableViewItem

@property (nonatomic, copy) NSString *themeName;
@property (nonatomic, copy) NSString *themeId;
@property (nonatomic, assign) NSInteger index;
//关注显示→，否则显示➕
@property (nonatomic, assign) BOOL isSubcribed;

@property (nonatomic, assign) BOOL isSelected;

@end
