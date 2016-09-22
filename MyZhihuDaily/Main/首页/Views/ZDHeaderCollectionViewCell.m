//
//  ZDHeaderCollectionViewCell.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/19.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDHeaderCollectionViewCell.h"

@interface ZDHeaderCollectionViewCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UIImageView *topMaskView;
@property (nonatomic, strong) UIImageView *bottomMaskView;
@end

@implementation ZDHeaderCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.topMaskView];
        [self addSubview:self.bottomMaskView];
        [self addSubview:self.textLabel];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setItem:(ZDHomeStoryItem *)item {
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.image]];
    self.textLabel.text = item.title;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self).offset(-25);
    }];
    [self.bottomMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);

        if (item.isHome) {
            make.height.mas_equalTo(100);

        } else {
            make.height.mas_equalTo(kZDHomeHeaderViewHeight);
        }
    }];
    
    [self.topMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(64);
        if (item.isHome) {
            make.bottom.equalTo(self.mas_top).offset(64);
        } else {
            make.bottom.equalTo(self.bottomMaskView.mas_top);
        }
    }];
    if (item.source.length > 0) {
        [self addSubview:self.sourceLabel];
        self.sourceLabel.text = [NSString stringWithFormat:@"图片:%@",item.source];
        [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-15);
            make.bottom.equalTo(self.mas_bottom).offset(-8);
        }];
    } else {
        [self.sourceLabel removeFromSuperview];
    }
}


- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        // 设置拉伸才能看到更多的图片
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}
- (UIImageView *)bottomMaskView {
    if (!_bottomMaskView) {
        _bottomMaskView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Home_Image_Mask"]];
    }
    return _bottomMaskView;
}
- (UIImageView *)topMaskView {
    if (!_topMaskView) {
        _topMaskView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Home_Topmask"]];
    }
    return _topMaskView;
}
- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont boldSystemFontOfSize:18];
        _textLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#faf9f9"];
        _textLabel.numberOfLines = -1;
        // !!autolayout 下 label 显示不了多行.
        [_textLabel setPreferredMaxLayoutWidth:200.0];
    }
    return _textLabel;
}

- (UILabel *)sourceLabel {
    if (!_sourceLabel) {
        _sourceLabel = [[UILabel alloc] init];
        _sourceLabel.font = [UIFont systemFontOfSize:8];
        _sourceLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#ffffff"];
    }
    return _sourceLabel;
}


@end
