//
//  ZDHomeNavBarView.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/18.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDHomeNavBarView.h"
#import "DACircularProgressView.h"

@interface ZDHomeNavBarView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) DACircularProgressView *progressView;

@end

@implementation ZDHomeNavBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.progressView];
        [self addSubview:self.indicator];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self).offset(-10);
        }];
        
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.titleLabel.mas_left).offset(-8);
            make.size.mas_equalTo(CGSizeMake(18, 18));
            make.centerY.equalTo(self.titleLabel);
        }];
        
        [self.indicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.progressView);
        }];
        

        @weakify(self);
        self.progressBlock = ^(CGFloat progress) {
            @strongify(self);
            progress = fabs(progress);
            if (progress > 0 && progress <= 1) {
                self.progressView.progress = progress;
                self.progressView.hidden = NO;
                self.progressView.hidden = progress <= 0.007143;
            }
        };
        [self bk_whenTapped:^{
            @strongify(self);
            if (self.touchBlock) {
                self.touchBlock();
            }
        }];

    }
    return self;
}


- (void)setLabelAlpha:(CGFloat)alpha {
    self.titleLabel.alpha = alpha;
}

- (void)setAlpha:(CGFloat)alpha {
    self.backgroundColor = [UIColor hx_colorWithHexRGBAString:kZDHomeNavDefaultColor alpha:alpha];
}

- (void)hideProgress {
    self.progressView.hidden = YES;
}

- (void)showLoadingWithBlock:(void (^)())refreshBlock {
    self.indicator.hidden = NO;
    self.isAnimating = YES;
    if (!self.progressView.hidden) {
        self.progressView.hidden = YES;
    }
    [self.indicator startAnimating];
    if (refreshBlock) {
        refreshBlock();
    }
}

- (void)hideLoading {
    [self.indicator stopAnimating];
    self.isAnimating = NO;
    self.indicator.hidden = YES;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

//    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) {
//        return nil;
//    }
//    if (![self pointInside:point withEvent:event]) {
//        return nil;
//    }
//    for (UIView *subview in self.subviews) {
//        CGPoint childPoint = [self convertPoint:point toView:subview];
//        UIView *fitView = [subview hitTest:childPoint withEvent:event];
//        NSLog(@"%@",fitView);
//        if (fitView) {
//            return fitView;
//        }
//    }
//    return self;
    
    return [super hitTest:point withEvent:event];
}

- (DACircularProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[DACircularProgressView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
        _progressView.progress = 0.f;
        _progressView.thicknessRatio = 0.2; //设置外圈宽度
        _progressView.trackTintColor = [UIColor  hx_colorWithHexRGBAString:@"faf9f9" alpha:0.5]; //背景颜色
        _progressView.progressTintColor = [UIColor hx_colorWithHexRGBAString:@"#faf9f9"]; //进度颜色
        CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI);
        [_progressView setTransform:trans];
        _progressView.hidden = YES;
    }
    return _progressView;
}

- (UIActivityIndicatorView *)indicator {
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc] init];
    }
    return _indicator;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#faf9f9"];
        _titleLabel.text = @"今日热闻";
    }
    return _titleLabel;
}

@end
