//
//  ZDStoryView.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/26.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDStoryView.h"
#import "ZDHeaderCollectionViewCell.h"
#import "ZDStoryViewController.h"
@interface ZDStoryView ()<UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) ZDHeaderCollectionViewCell *headerView;
@property (nonatomic, strong) UIButton *topButton;
@property (nonatomic, strong) UIButton *bottomButton;
@property (nonatomic, strong) UIView *statusView;

@end

@implementation ZDStoryView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.headerView];
        [self addSubview:self.webView];
        [self.webView.scrollView addSubview:self.topButton];
        [self.webView.scrollView addSubview:self.bottomButton];
        [self addSubview:self.statusView];
        [self layout];
    }
    return self;
}

- (void)layout {
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.topButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.webView.scrollView.mas_top).offset(-16);
        make.size.mas_equalTo(CGSizeMake(150, 32));
    }];
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.topButton);
        make.centerX.equalTo(self.topButton);
        make.top.equalTo(self.webView.scrollView.mas_bottom).offset(self.webView.scrollView.contentSize.height);
    }];
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(20);
    }];

}

- (void)setItem:(ZDStoryItem *)item {
    [self.webView loadHTMLString:[NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>",item.css[0],item.body] baseURL:nil];
    
    if (item.image && item.image.length > 0) {
        [self.headerView setItem:item];
        [self.webView.scrollView addSubview:self.headerView];
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, kZDStoryHeaderViewHeight));
        }];
    }else {
        [self.headerView removeFromSuperview];
        self.headerView = nil;
    }
    [self.webView.scrollView bringSubviewToFront:self.topButton];

}
#pragma mark - webviewdelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self.bottomButton mas_updateConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(webView.mas_bottom).offset(offSetY);
        // 非常得奇怪，设置 bottom,top 都不管用，但是设置 centerY 可以，为什么？？？,找到原因了，因为之前上面设置了 centerY，感觉是冲突了，且没有设置优先级，所以没有起作用。
        make.top.equalTo(webView.scrollView.mas_bottom).offset(webView.scrollView.contentSize.height);
    }];
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offSetY = scrollView.contentOffset.y;
    self.statusView.hidden = offSetY < kZDStoryHeaderViewHeight;
    if (offSetY < 0) {
        if (self.headerView) {
            [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.webView.scrollView).offset(offSetY);
                make.height.mas_equalTo(kZDStoryHeaderViewHeight - offSetY);
            }];
        }
        self.webView.scrollView.contentOffset = CGPointMake(0, MAX(-55, offSetY));
        
        if (self.isFirst) {
            [self.topButton setTitle:@"已经是第一篇了" forState: UIControlStateNormal];
            [self.topButton setImage:nil forState:UIControlStateNormal];
        } else {
            [self.topButton setTitle:@"载入上一篇" forState:UIControlStateNormal];
            [self.topButton setImage:[UIImage imageNamed:@"ZHAnswerViewBack"] forState:UIControlStateNormal];

            if (offSetY < -32) {
                [UIView animateWithDuration:0.25 animations:^{
                    self.topButton.imageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
                }];
            } else {
                [UIView animateWithDuration:0.25 animations:^{
                    self.topButton.imageView.transform = CGAffineTransformIdentity;
                }];
            }
        }
    } else {
        ZDStoryViewController *vc = (ZDStoryViewController *)self.delegate;
        vc.isStatusBarStyleDefault = offSetY > kZDStoryHeaderViewHeight;
        [vc setNeedsStatusBarAppearanceUpdate];
        if (offSetY > self.webView.scrollView.contentSize.height - (kMainScreenHeight - 44) + 32) {
            [UIView animateWithDuration:0.25 animations:^{
                self.bottomButton.imageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
            }];
        } else if (offSetY < self.webView.scrollView.contentSize.height - (kMainScreenHeight - 44) + 32){
            [UIView animateWithDuration:0.25 animations:^{
                self.bottomButton.imageView.transform = CGAffineTransformIdentity;
            }];
        }
    
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat offSetY = scrollView.contentOffset.y;
    if (offSetY > self.webView.scrollView.contentSize.height - (kMainScreenHeight - 44) + 32) {
        if ([self.delegate respondsToSelector:@selector(getNextStoryPage)]) {
            [self.delegate getNextStoryPage];
        }
    }
    if (offSetY < -32) {
        if ([self.delegate respondsToSelector:@selector(getPreviousStoryPage)]) {
            [self.delegate getPreviousStoryPage];
        }
    }
}

- (UIButton *)topButton {
    if (!_topButton) {
        _topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topButton setTitle:@"载入上一篇" forState:UIControlStateNormal];
        [_topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _topButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_topButton setImage:[UIImage imageNamed:@"ZHAnswerViewBack"] forState:UIControlStateNormal];
        _topButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    }
    return _topButton;
}

- (UIButton *)bottomButton {
    if (!_bottomButton) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomButton setTitle:@"载入下一篇" forState:UIControlStateNormal];
        [_bottomButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#e5e5e5"] forState:UIControlStateNormal];
        _bottomButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_bottomButton setImage:[UIImage imageNamed:@"ZHAnswerViewPrevIcon"] forState:UIControlStateNormal];
        _bottomButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    }
    return _bottomButton;
}

- (UIView *)statusView {
    if (!_statusView) {
        _statusView = [UIView new];
        _statusView.backgroundColor = [UIColor whiteColor];
        _statusView.hidden = YES;
    }
    return _statusView;
}
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.bounds];
        _webView.delegate = self;
        _webView.scrollView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
    }
    return _webView;
}

- (ZDHeaderCollectionViewCell *)headerView {
    if (!_headerView) {
        _headerView = [[ZDHeaderCollectionViewCell alloc] initWithFrame:CGRectZero];
    }
    return _headerView;
}

@end
