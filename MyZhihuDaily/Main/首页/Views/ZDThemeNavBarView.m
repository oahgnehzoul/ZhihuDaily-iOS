//
//  ZDThemeNavBarView.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/22.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDThemeNavBarView.h"
#import "DACircularProgressView.h"
#import "UIImage+ZDBlur.h"
@interface ZDThemeNavBarView ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *subcribeButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) DACircularProgressView *progressView;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) UIImageView *maskView;
@property (nonatomic, strong) UIImage *image;

@end
@implementation ZDThemeNavBarView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.backImageView];
//        [self addSubview:self.maskView];
        [self addSubview:self.backButton];
        [self addSubview:self.titleLabel];
        [self addSubview:self.progressView];
        [self addSubview:self.indicator];
        [self addSubview:self.subcribeButton];
        self.clipsToBounds = YES;
    }
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
//    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(25);
    }];
    
    [self.subcribeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.backButton);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.backButton);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(35);
    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLabel.mas_left).offset(-8);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.centerY.equalTo(self.titleLabel);
    }];
    [self.indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.progressView);
    }];
    return self;

}

- (void)setImageAlpha:(CGFloat)alpha {
    UIImage *image = self.image;
    image = [image getBlurImageWith:alpha];
    self.backImageView.image = image;
}

- (void)setData:(ZDThemeItem *)item {
    self.titleLabel.text = item.name;
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:item.image] placeholderImage:[UIImage imageNamed:@"Field_Mask_Bg"]];
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:item.image] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        self.image = image;
        [self setImageAlpha:1.0];
    }];
    
    [self setImageAlpha:0.99];
    if (item.subscribed) {
        [self.subcribeButton setImage:[UIImage imageNamed:@"Field_Unfollow"] forState:UIControlStateNormal];
    } else {
        [self.subcribeButton setImage:[UIImage imageNamed:@"Field_Follow"] forState:UIControlStateNormal];
    }
    
    @weakify(self);
    [self.subcribeButton bk_whenTapped:^{
        @strongify(self);
        item.subscribed = !item.subscribed;
        NSString *str = item.subscribed ?@"Field_Unfollow":@"Field_Follow";
        [self.subcribeButton setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
        self.subcribBlock(item.subscribed);
    }];
    
    [self.backButton bk_whenTapped:^{
        @strongify(self);
        if (self.BackBlock) {
            self.BackBlock();
        }
    }];
}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [UIImageView new];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backImageView;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"Field_Back"] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (UIImageView *)maskView {
    if (!_maskView) {
        _maskView = [UIImageView new];
        _maskView.image = [UIImage imageNamed:@"Field_Mask"];
    }
    return _maskView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#faf9f9"];
    }
    return _titleLabel;

}

- (UIButton *)subcribeButton {
    if (!_subcribeButton) {
        _subcribeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _subcribeButton;
}

- (void)dealloc {
    NSLog(@"[%@-->dealloc]",self.class);
}


@end
