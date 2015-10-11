//
//  ThemeTableViewCell.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/7.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeModel.h"
@interface ThemeTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *imgView;

@property (nonatomic,strong) ThemeModel *model;

@end
