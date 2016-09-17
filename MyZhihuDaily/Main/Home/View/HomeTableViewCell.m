//
//  HomeTableViewCell.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/7.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation HomeTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _createSubViews];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _createSubViews];
    }
    return self;
}

- (void)_createSubViews {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kMainScreenWidth-120, 60)];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenWidth-95, 10, 80, 60)];
//    _imgView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_imgView];
    
}

- (void)setModel:(storyModel *)model {
    _model = model;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.text = self.model.title;
    _titleLabel.textColor = [UIColor blackColor];
    //应该缩小图片,待修改
    NSURL *url = [NSURL URLWithString:self.model.image];
    [_imgView sd_setImageWithURL:url];
}

@end
