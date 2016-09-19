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
@interface ZDHomeViewController ()
@property (nonatomic, strong) ZDHomeDataSource *ds;
@property (nonatomic, strong) ZDHomeStoryModel *model;
@property (nonatomic, strong) SBTableViewDelegate *dl;

@property (nonatomic, strong) ZDHomeNavBarView *navBarView;
@property (nonatomic, strong) ZDHomeHeaderView *headerView;

@property (nonatomic, strong) UIButton *menuButton;
//@property (nonatomic, assign) BOOL isOpen;
@end

@implementation ZDHomeViewController

- (id)initWithRouterParams:(NSDictionary *)params {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.hidden = YES;
    
    //默认为 yes，会让 viewcontroller 根据 status bar ,navigation bar,toolbar,tabbar自动调整 insets
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.headerView = [[ZDHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kZDHomeHeaderViewHeight)];
    [self.view addSubview:self.headerView];
//    self.headerView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.menuButton];
    [self setNavBar];
    [self.view bringSubviewToFront:self.menuButton];
    [self.menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.navBarView).offset(-5);
    }];
    self.tableView.frame = self.view.bounds;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.dataSource = self.ds;
    self.delegate = self.dl;
    
//    self.headerView = [[ZDHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kZDHomeHeaderViewHeight)];
//    [self.view addSubview:self.headerView];
//    self.headerView.backgroundColor = [UIColor grayColor];
//    self.tableView.tableHeaderView = self.headerView;
    
    self.bNeedLoadMore = YES;
    [self registerModel:self.model];
    [self setKeyModel:self.model];
    [self load];
}

- (void)didLoadModel:(ZDHomeStoryModel *)model {
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

- (SBTableViewDelegate *)dl {
    if (!_dl) {
        _dl = [SBTableViewDelegate new];
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
    self.navBarView = [[ZDHomeNavBarView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 64)];
    self.navBarView.alpha = 0;
    [self.view addSubview:self.navBarView];
}

- (void)openMenu {
    NSLog(@"openMenu");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offSetY = scrollView.contentOffset.y + scrollView.contentInset.top;
    if (offSetY > 0) {
        self.navBarView.alpha = offSetY / (kZDHomeHeaderViewHeight + 30);
    }
    if (offSetY < 0) {
        self.navBarView.alpha = 0.f;
        CGFloat x = ABS(offSetY) / 120;
        if (x <= 1 && x >= 0) {
            self.navBarView.progressBlock(offSetY / 120.f);
        }
        self.headerView.top = self.view.top ;
        self.headerView.height = kZDHomeHeaderViewHeight - offSetY;
    } else {
        self.headerView.top = self.tableView.top - offSetY;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat offSetY = scrollView.contentOffset.y + scrollView.contentInset.top;
    if (offSetY < 0) {
        CGFloat progress = fabs(offSetY / 120.f);
        NSLog(@"%f",progress);
        if (progress >= 1) {
            [self.navBarView showLoadingWithBlock:^{
                @weakify(self);
                [self.model reloadWithCompletioin:^(SBModel *model, NSError *error) {
                    @strongify(self);
                    //数据回来太快，延迟一秒
                    [self.navBarView performSelector:@selector(hideLoading) withObject:nil afterDelay:1];
                }];
            }];
        } 
    }
}

@end
