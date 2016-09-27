//
//  ZDThemeNavBarView.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/22.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDThemeItem.h"
@interface ZDThemeNavBarView : UIView

- (void)setData:(ZDThemeItem *)item;

@property (nonatomic, copy) void(^BackBlock)();
@property (nonatomic, copy) void(^subcribBlock)(BOOL isSubcribed);

- (void)setImageAlpha:(CGFloat)alpha;

@end
