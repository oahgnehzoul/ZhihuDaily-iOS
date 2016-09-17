//
//  HomeHeaderViewCell.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/7.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "HomeHeaderViewCell.h"
#import "UIImageView+WebCache.h"
@implementation HomeHeaderViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _createSubViews];
//        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)_createSubViews {
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 220)];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100+45, kMainScreenWidth-40, 60)];
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-50, 175+20, 100, 20)];
//    _pageControl.backgroundColor = [UIColor redColor];
    _pageControl.numberOfPages = 5;
   
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_pageControl];
}

- (void)setModel:(storyModel *)model {
    _model = model;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = self.model.title;
//    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.model.image]];
}

@end
