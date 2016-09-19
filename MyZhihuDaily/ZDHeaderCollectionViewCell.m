//
//  ZDHeaderCollectionViewCell.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/19.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDHeaderCollectionViewCell.h"
//#import "ZDHomeStoryItem.h"
@interface ZDHeaderCollectionViewCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *sourceLabel;
//- (void)setItem:(ZDHomeStoryItem *)item;
@end

@implementation ZDHeaderCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.textLabel];
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
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        // 设置拉伸才能看到更多的图片
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont boldSystemFontOfSize:18];
        _textLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#faf9f9"];
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}


@end
