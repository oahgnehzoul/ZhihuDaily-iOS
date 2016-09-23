//
//  ZDLaunchAdvertiseView.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/17.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDLaunchAdvertiseView.h"
#import "DACircularProgressView.h"
@interface ZDLaunchAdvertiseView ()

@property (nonatomic, strong) UIImageView *topView;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UIView *bottomBackView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) DACircularProgressView *progressView;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UIImageView *maskView;
@property (nonatomic, strong) UIButton *skipButton;

@end
@implementation ZDLaunchAdvertiseView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.topView];
        [self addSubview:self.bottomBackView];
        [self addSubview:self.maskView];
        [self.bottomBackView addSubview:self.leftView];
        [self.leftView addSubview:self.progressView];
        [self.bottomBackView addSubview:self.titleLabel];
        [self.bottomBackView addSubview:self.subTitleLabel];
        [self.bottomBackView addSubview:self.skipButton];
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#17181a"];
        [self layout];
    }
    return self;
}


- (void)layout {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 98, 0));
    }];

//    [self.bottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.top.equalTo(self.mas_bottom);
//        make.height.mas_equalTo(98);
//    }];
    // 因为用 mansory 布局，动画的时候会从上面掉下来，改用 frame 就是正常，不知道原因 \
    之前 用mansory 与动画结合好像也出现过问题。
    self.bottomBackView.frame = CGRectMake(0, self.bottom, self.width, 98);
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.topView);
    }];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(46, 46));
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self.bottomBackView);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 28));
        make.center.equalTo(self.leftView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftView.mas_right).offset(15);
        make.top.equalTo(self.leftView);
    }];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.leftView.mas_bottom).offset(-2);
    }];
    
//    [self.skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(84, 28));
//        make.right.equalTo(self.bottomBackView).offset(-2);
//        make.centerY.equalTo(self.leftView);
//    }];
//    [self.skipButton sizeToFit];
//    self.skipButton.size = CGSizeMake(self.skipButton.width + 20, self.skipButton.height + 5);
    [self.skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 28));
        make.right.equalTo(self.bottomBackView).offset(-2);
        make.centerY.equalTo(self.leftView);
    }];

}

- (void)startLaunch {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    NSString *bootImageUrl = [[NSUserDefaults standardUserDefaults] objectForKey:kZDBootImageUrl];
    // 之前 把 bootImageUrl 写成了 kZDBootImageUrl，调试了半个小时，我也是醉了。。。
    UIImage *image = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:bootImageUrl];
    if (bootImageUrl.length > 0 && image) {
        self.topView.image = image;
    } else {
        self.topView.image = [UIImage imageNamed:@"Splash_Image.jpg"];
    }
    
    NSString *author = [[NSUserDefaults standardUserDefaults] objectForKey:kZDBootImageAuthor];
    if (author.length > 0) {
        [self addSubview:self.authorLabel];
        
        self.authorLabel.text = author;
        [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.topView.mas_bottom).offset(-10);
            make.centerX.equalTo(self);
        }];
    }
    self.index = 3;
    
    [UIView animateWithDuration:0.8 animations:^{
        self.bottomBackView.bottom = self.bottom;
    } completion:^(BOOL finished) {
        [self.progressView setProgress:0.8 animated:YES initialDelay:0 withDuration:2];
        [UIView animateWithDuration:0.2 animations:^{
            self.skipButton.hidden = YES;
        } completion:^(BOOL finished) {
            self.skipButton.hidden = NO;
        }];
        @weakify(self);
        self.timer = [NSTimer bk_scheduledTimerWithTimeInterval:1.0 block:^(NSTimer *timer) {
            @strongify(self);
            self.index--;
            if (self.index == 0) {
                [self dissmiss];
            }
        } repeats:YES];
    }];
    
    
}

- (void)dealloc {
    NSLog(@"[%@-->dealloc]",self.class);
}

- (void)dissmiss {
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self removeFromSuperview];
}

- (UIImageView *)topView {
    if (!_topView) {
        _topView = [[UIImageView alloc] init];
    }
    return _topView;
}

- (UILabel *)authorLabel {
    if (!_authorLabel) {
        _authorLabel = [UILabel new];
        _authorLabel.font = [UIFont systemFontOfSize:10];
        _authorLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"faf9f9"];
    }
    return _authorLabel;
}

- (UIView *)bottomBackView {
    if (!_bottomBackView) {
        _bottomBackView = [UIView new];
        _bottomBackView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#17181a"];
    }
    return _bottomBackView;
}

- (UIImageView *)maskView {
    if (!_maskView) {
        _maskView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AD_Mask"]];
    }
    return _maskView;
}

- (UIView *)leftView {
    if (!_leftView) {
        _leftView = [UIView new];
        _leftView.layer.cornerRadius = 10;
        _leftView.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"bec2c9"].CGColor;
        _leftView.layer.borderWidth = 0.8;
    }
    return _leftView;
}

- (DACircularProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[DACircularProgressView alloc] init];
        _progressView.progressTintColor = [UIColor hx_colorWithHexRGBAString:@"faf9f9"];
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.thicknessRatio = 0.3;
        _progressView.transform = CGAffineTransformMakeRotation(M_PI);
    }
    return _progressView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#faf9f9"];
        _titleLabel.text = @"知乎日报";
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel new];
        _subTitleLabel.font = [UIFont systemFontOfSize:12];
        _subTitleLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"74777a"];
        _subTitleLabel.text = @"每天三次，每次七分钟";
    }
    return _subTitleLabel;
}

- (UIButton *)skipButton {
    if (!_skipButton) {
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_skipButton setTitle:@"跳过广告" forState: UIControlStateNormal];
        [_skipButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"74777a"] forState:UIControlStateNormal];
        _skipButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _skipButton.hidden = YES;
        _skipButton.layer.cornerRadius = 3;
        _skipButton.layer.borderWidth = 1;
        _skipButton.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"74777a"].CGColor;
        WEAKSELF
        [_skipButton bk_whenTapped:^{
            [weakSelf dissmiss];
        }];
    }
    return _skipButton;
}


@end
