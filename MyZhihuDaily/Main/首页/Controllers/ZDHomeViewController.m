//
//  ZDHomeViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/17.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDHomeViewController.h"
#import "ZDThemeViewController.h"
#import "UINavigationBar+BackgroundColor.h"
#import "ZDHomeDataSource.h"
#import "ZDHomeStoryModel.h"
#import "ZDHomeStoryItem.h"
#import "ZDHomeNavBarView.h"
#import "ZDHomeHeaderView.h"
#import "ZDRootViewController.h"
#import "ZDStoryViewController.h"
#import "ZDHomeDelegate.h"
@interface ZDHomeViewController ()
@property (nonatomic, strong) ZDHomeDataSource *ds;
@property (nonatomic, strong) ZDHomeStoryModel *model;
@property (nonatomic, strong) ZDHomeDelegate *dl;

@property (nonatomic, strong) ZDHomeNavBarView *navBarView;
@property (nonatomic, strong) ZDHomeHeaderView *headerView;

@property (nonatomic, strong) UIButton *menuButton;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) NSInteger firstPageCount;

@end

@implementation ZDHomeViewController

- (id)initWithRouterParams:(NSDictionary *)params {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = YES;
    
    //默认为 yes，会让 viewcontroller 根据 status bar ,navigation bar,toolbar,tabbar自动调整 insets
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.headerView = [[ZDHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 220 / 375.0 * CGRectGetWidth(self.view.frame))];
    [self.view addSubview:self.headerView];

    //把 tableview 顶下去.相当于改变 UIEdgeInset,但是直接改变 inset会影响 sectionHeader.
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kZDHomeHeaderViewHeight - 20)];
    self.tableView.tableHeaderView = view;
    [self.view addSubview:self.menuButton];

    [self setNavBar];
    [self.view bringSubviewToFront:self.menuButton];
    [self.menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(24);
    }];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(20, 0, 0, 0));
    }];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.dataSource = self.ds;
    self.delegate = self.dl;
    
    self.loadMoreAutomatically = YES;
    self.bNeedLoadMore = YES;
    [self registerModel:self.model];
    [self setKeyModel:self.model];
    self.model.isLatest = YES;
    [self load];
}

- (void)didLoadModel:(ZDHomeStoryModel *)model {
    if (model.currentPageIndex == 0) {
        self.firstPageCount = model.itemList.count;
    }
    [super didLoadModel:model];
    if ([model.stories count]) {
        self.headerView.items = model.stories;
    }
}

- (ZDHomeDataSource *)ds {
    if (!_ds) {
        _ds = [ZDHomeDataSource new];
    }
    return _ds;
}

- (ZDHomeDelegate *)dl {
    if (!_dl) {
        _dl = [ZDHomeDelegate new];
    }
    return _dl;
}

- (ZDHomeStoryModel *)model {
    if (!_model) {
        _model = [[ZDHomeStoryModel alloc] init];
    }
    return _model;
}

- (UIButton *)menuButton {
    if (!_menuButton) {
        _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_menuButton setImage:[UIImage imageNamed:@"Home_Icon"] forState:UIControlStateNormal];
        [_menuButton setImage:[UIImage imageNamed:@"home_Icon_Highlight"] forState:UIControlStateHighlighted];
        @weakify(self);
        [_menuButton bk_addEventHandler:^(id sender) {
            @strongify(self);
            [self.mmDraw toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _menuButton;
}




- (void)setNavBar {
    self.navBarView = [[ZDHomeNavBarView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 58)];
    self.navBarView.alpha = 0;
    [self.view addSubview:self.navBarView];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[ZDStoryViewController alloc] initWithStoryId:@"1"] animated:YES];
}

- (void)loadMore {
    self.model.isLatest = NO;
    self.model.clearBeforeAdd = YES;
    self.model.sectionNubmer = self.model.currentPageIndex + 1;
    [super loadMore];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {

}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offSetY = scrollView.contentOffset.y + scrollView.contentInset.top;
    if (offSetY > 0) {
        self.navBarView.alpha = offSetY / (kZDHomeHeaderViewHeight - 20);
        CGFloat h = (self.firstPageCount * 90 + kZDHomeHeaderViewHeight);
        if (offSetY > h) {
            if (self.model.sectionNubmer != self.model.currentPageIndex) {
                [self loadMore];
            }
        }
        
        if (offSetY > (self.firstPageCount * 90 + kZDHomeHeaderViewHeight - 20)) {
            [self.navBarView setLabelAlpha:0];
            self.navBarView.height = 20;
        } else {
            self.navBarView.height = 58;
            [self.navBarView setLabelAlpha:1];
        }
        
        [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, kZDHomeHeaderViewHeight));
            make.bottom.equalTo(self.view.mas_top).offset(kZDHomeHeaderViewHeight - offSetY);
            make.left.equalTo(self.view);
        }];
        
    }
    if (offSetY < 0 ) {
        self.navBarView.alpha = 0.f;
        CGFloat x = ABS(offSetY) / 70.f;
        self.progress = x;
        if (x <= 1 && x >= 0 && !self.navBarView.isAnimating) {
            self.navBarView.progressBlock(offSetY / 70.f);
        }
        //设置下拉的最大距离
        self.tableView.contentOffset = CGPointMake(0, MAX(offSetY, -80));

        //改变 h 会调用 setFrame 方法，从而调用 collection 重新布局 subView，拉伸效果
        self.headerView.height = kZDHomeHeaderViewHeight - offSetY;
        [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, kZDHomeHeaderViewHeight - offSetY));
            make.left.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_top).offset(-offSetY + kZDHomeHeaderViewHeight);
        }];
        
    }
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (self.progress >= 1) {
        if (!self.navBarView.isAnimating) {
            
            @weakify(self);
            [self.navBarView showLoadingWithBlock:^{
                 @strongify(self);
                // 延迟一秒 ，不然会马上弹回去，有点丑。
                [self performSelector:@selector(refresh) withObject:nil afterDelay:1];
            }];
        }
    }
    self.navBarView.progressBlock(self.progress);
}

- (void)refresh {
    @weakify(self);
    [self.model reloadWithCompletioin:^(SBModel *model, NSError *error) {
        @strongify(self);
        [self.navBarView hideLoading];
    }];
}

@end
