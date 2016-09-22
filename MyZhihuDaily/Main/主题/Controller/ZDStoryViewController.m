//
//  ZDStoryViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/20.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDStoryViewController.h"
#import "ZDStoryBottomBar.h"
#import "ZDStoryModel.h"
#import "ZDHomeHeaderView.h"
#import "ZDStoryItem.h"
#import "ZDHomeStoryItem.h"
#import "ZDHeaderCollectionViewCell.h"
#import "ZDRootViewController.h"
@interface ZDStoryViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet ZDStoryBottomBar *bottomBar;
@property (nonatomic, strong) ZDStoryModel *model;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) ZDHeaderCollectionViewCell *headerView;

@property (nonatomic, strong) UIButton *topButton;
@property (nonatomic, strong) UIButton *bottomButton;
@property (nonatomic, assign) BOOL isStatusBarStyleDefault;
@property (nonatomic, strong) UIView *statusView;
@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic, assign) BOOL isLast;
@end

@implementation ZDStoryViewController

- (id)initWithStoryId:(NSString *)storyId {
    if (self = [super init]) {
        self.model.storyId = storyId;
    }
    return self;
}

- (id)initWithRouterParams:(NSDictionary *)params {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    ZDRootViewController *root = (ZDRootViewController *)window.rootViewController;
    [root setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}

- (void)dealloc {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    ZDRootViewController *root = (ZDRootViewController *)window.rootViewController;
    [root setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];

}
- (IBAction)bottomBarClicked:(id)sender {
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case 1:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 2:
            [self loadNext];
            break;
        case 3:
            NSLog(@"点赞");
            break;
        case 4:
            NSLog(@"分享");
            break;
        case 5:
            NSLog(@"讨论");
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bottomBar = [[[NSBundle mainBundle] loadNibNamed:@"ZDStoryBottomBar" owner:self options:nil] lastObject];
    [self.view addSubview:self.bottomBar];
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    [self.view addSubview:self.webView];
    [self.webView.scrollView addSubview:self.headerView];
//    [self.webView setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 44, 0));
    }];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, kZDHomeHeaderViewHeight));
    }];
    
   
    [self.webView.scrollView addSubview:self.topButton];
    [self.webView.scrollView addSubview:self.bottomButton];
    [self.topButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 32));
        make.centerY.equalTo(self.webView.scrollView.mas_top).offset(-(64-32)/2);
    }];

    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.topButton);
        make.centerX.equalTo(self.webView);
        make.top.equalTo(self.webView.scrollView.mas_bottom).offset(self.webView.scrollView.contentSize.height);
    }];
    
    [self.view addSubview:self.statusView];
    self.statusView.hidden = YES;
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(20);
    }];
    
    @weakify(self);
    [self.model loadWithCompletion:^(SBModel *model, NSError *error) {
        @strongify(self);
        ZDStoryItem *item = model.itemList.array[0];
        [self.webView loadHTMLString:[NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>",item.css[0],item.body] baseURL:nil];
        ZDHomeStoryItem *headerItem = [ZDHomeStoryItem itemWithDictioinary:model.item];
        [self.headerView setItem:headerItem];
    }];
}

- (void)loadLast {
    NSString *str = [self.vc getPreviousStoryIdWithCurrentId:self.model.storyId];
    if (str) {
        self.model.storyId = str;
        @weakify(self);
        [self.model loadWithCompletion:^(SBModel *model, NSError *error) {
            @strongify(self);
            
            [UIView animateWithDuration:0.4 animations:^{
                [self.webView.scrollView setContentOffset:CGPointMake(0, kMainScreenHeight)];
            } completion:^(BOOL finished) {
                self.webView.scrollView.contentOffset = CGPointMake(0, 0);
                ZDStoryItem *item = model.itemList.array[0];
                [self.webView loadHTMLString:[NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>",item.css[0],item.body] baseURL:nil];
                ZDHomeStoryItem *headerItem = [ZDHomeStoryItem itemWithDictioinary:model.item];
                [self.headerView setItem:headerItem];
                self.isLast = NO;
            }];
            
            
        }];
    } else {
        self.isLast = NO;
        self.isFirst = YES;
    }
    
}

- (void)loadNext {
    NSString *str = [self.vc getNextStoryIdWithCurrentId:self.model.storyId];
    if (str) {
        self.model.storyId = str;
        @weakify(self);
        [self.model loadWithCompletion:^(SBModel *model, NSError *error) {
            @strongify(self);
            
            
            [UIView animateWithDuration:0.3 animations:^{
                [self.webView.scrollView setContentOffset:CGPointMake(0, kMainScreenHeight)];
            } completion:^(BOOL finished) {
                ZDStoryItem *item = model.itemList.array[0];
//                self.webView.scrollView.contentOffset = CGPointMake(0, 0);
                [self.webView loadHTMLString:[NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>",item.css[0],item.body] baseURL:nil];
                ZDHomeStoryItem *headerItem = [ZDHomeStoryItem itemWithDictioinary:model.item];
                [self.headerView setItem:headerItem];
                self.isFirst = NO;
            }];
            
            
        }];
    } else {
        self.isLast = YES;
        self.isFirst = NO;
    }
    
}

- (UIView *)statusView {
    if (!_statusView) {
        _statusView = [UIView new];
        _statusView.backgroundColor = [UIColor whiteColor];
    }
    return _statusView;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.isStatusBarStyleDefault ? UIStatusBarStyleDefault: UIStatusBarStyleLightContent;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 拖动视图的真谛，能拖动的视图都是 contentView,
    // 拖动的时候 view 的 frame 并没有改变，我们视觉上看到的是 contentOffset，拖动就是 contentOffSet 的变化，
    CGFloat offSetY = scrollView.contentOffset.y;
    self.statusView.hidden = offSetY < kZDHomeHeaderViewHeight;
    if (offSetY < 0) {
        self.webView.scrollView.contentOffset = CGPointMake(0, MAX(-55, offSetY));
        [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.webView.scrollView).offset(offSetY);
            make.height.mas_equalTo(kZDHomeHeaderViewHeight - offSetY);
        }];
        [self.topButton setTitle:self.isFirst ? @"已经是第一篇了":@"载入上一篇" forState:UIControlStateNormal];
        if (offSetY < -32) {
            [UIView animateWithDuration:0.25 animations:^{
                self.topButton.imageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
            }];
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                self.topButton.imageView.transform = CGAffineTransformIdentity;
            }];
        }
    } else  {
        self.isStatusBarStyleDefault = offSetY > kZDHomeHeaderViewHeight;
        [self setNeedsStatusBarAppearanceUpdate];
        [self.bottomButton setTitle:self.isLast ?@"已经是最后一篇了":@"载入下一篇" forState:UIControlStateNormal];
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
        [self loadNext];
    }
    if (offSetY < -32) {
        [self loadLast];
    }
}

#pragma mark - webviewdelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"load:%f",webView.scrollView.contentSize.height);
//    CGFloat offSetY = webView.scrollView.contentSize.height - (kMainScreenHeight - 44);
    [self.bottomButton mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(webView.mas_bottom).offset(offSetY);
        // 非常得奇怪，设置 bottom,top 都不管用，但是设置 centerY 可以，为什么？？？,找到原因了，因为之前上面设置了 centerY，感觉是冲突了，且没有设置优先级，所以没有起作用。
        make.top.equalTo(webView.scrollView.mas_bottom).offset(webView.scrollView.contentSize.height);
    }];
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

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
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

- (ZDStoryModel *)model {
    if (!_model) {
        _model = [[ZDStoryModel alloc] init];
    }
    return _model;
}

@end
