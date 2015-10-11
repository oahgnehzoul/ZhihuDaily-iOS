//
//  HomeHeaderViewCell.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/7.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "storyModel.h"
@interface HomeHeaderViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) storyModel *model;
@end
