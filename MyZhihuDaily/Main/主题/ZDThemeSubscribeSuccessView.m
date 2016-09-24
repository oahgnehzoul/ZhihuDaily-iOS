//
//  ZDThemeSubscribeSuccessView.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/24.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDThemeSubscribeSuccessView.h"


@implementation ZDThemeSubscribeSuccessView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [UILabel new];
        label.text = @"关注成功，你关注的内容会在首页出现";
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:12];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self);
        }];
        UIImageView *close = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Activity_Arrow"]];
        [self addSubview:close];
        [close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self);
        }];
        @weakify(self);
        [close bk_whenTapped:^{
            @strongify(self);
            [self hide];
        }];
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:kZDHomeNavDefaultColor alpha:0.7];
    }
    return self;
}

- (void)showInView:(UIView *)view {
    [view addSubview:self];
    [view bringSubviewToFront:self];
}

- (void)hide {
    [self removeFromSuperview];
}


@end
