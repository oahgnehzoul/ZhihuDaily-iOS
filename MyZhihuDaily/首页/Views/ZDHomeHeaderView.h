//
//  ZDHomeHeaderView.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/18.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDHomeHeaderView : UIView

- (void)setItems:(NSArray *)items;

@property (nonatomic, strong, readonly) NSArray *items;

@end
