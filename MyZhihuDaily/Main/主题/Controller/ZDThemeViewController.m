//
//  ZDThemeViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/18.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDThemeViewController.h"
#import "ZDThemeDataSource.h"
#import "ZDThemeModel.h"
#import "ZDThemeNavBarView.h"
#import "ZDRootViewController.h"
#import "ZDThemeDelegate.h"
#import "ZDHomeStoryItem.h"
#import "ZDStoryViewController.h"
@interface ZDThemeViewController ()

@property (nonatomic, copy) NSString *themeId;
@property (nonatomic, strong) ZDThemeModel *model;
@property (nonatomic, strong) ZDThemeDataSource *ds;
@property (nonatomic, strong) ZDThemeDelegate *dl;
@property (nonatomic, strong) ZDThemeNavBarView *navBar;
@end

@implementation ZDThemeViewController

- (id)initWithRouterParams:(NSDictionary *)params {
    if (self = [super init]) {
        
    }
    return self;
}

- (id)initWithThemeId:(NSString *)themeId {
    if (self = [super init]) {
        self.themeId = themeId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;

    [self.view addSubview:self.navBar];
    self.navBar.subcribBlock = ^(BOOL subcribed) {
        if (subcribed) {
            NSLog(@"关注成功");
        } else {
            NSLog(@"取消关注成功");
        }
    };
    @weakify(self);
    self.navBar.BackBlock = ^{
        @strongify(self);
        [self openLeft];
    };
    
    self.tableView.frame = CGRectMake(0, self.navBar.bottom, kMainScreenWidth, kMainScreenHeight - self.navBar.height);
    self.dataSource = self.ds;
    self.delegate = self.dl;
    
    self.bNeedLoadMore = YES;
//    self.loadMoreAutomatically = YES;
    [self registerModel:self.model];
    self.model.themeId = self.themeId;
    [self setKeyModel:self.model];
    [self load];
}

- (void)loadMore {
    ZDHomeStoryItem *item = [self.model.itemList.array lastObject];
    self.model.storyId = item.storyId;
    [self.model loadMore];
}

- (void)openLeft {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    ZDRootViewController *root = (ZDRootViewController *)window.rootViewController;
    [root toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (UITableViewStyle)tableViewStyle {
    return UITableViewStyleGrouped;
}

- (void)didLoadModel:(ZDThemeModel *)model {
    [super didLoadModel:model];
    ZDThemeItem *item = (ZDThemeItem *)model.item;
    [self.navBar setData:item];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDHomeStoryItem *item = [self.ds getItems:indexPath.section][indexPath.row];
    [self.navigationController pushViewController:[[ZDStoryViewController alloc] initWithStoryId:item.storyId andHeader:NO] animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if (contentOffsetY < 0) {
        self.navBar.top = self.view.top;
        self.navBar.height = MIN(164, 64 - contentOffsetY);
        self.tableView.contentOffset = CGPointMake(0, MAX(-100, contentOffsetY));
        
    }
}

- (ZDThemeModel *)model {
    if (!_model) {
        _model = [ZDThemeModel new];
        _model.sectionNubmer = 0;
    }
    return _model;
}

- (ZDThemeDataSource *)ds {
    if (!_ds) {
        _ds = [ZDThemeDataSource new];
    }
    return _ds;
}

- (ZDThemeDelegate *)dl {
    if (!_dl) {
        _dl = [ZDThemeDelegate new];
    }
    return _dl;
}

- (ZDThemeNavBarView *)navBar {
    if (!_navBar) {
        _navBar = [[ZDThemeNavBarView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 64)];
    }
    return _navBar;
}



@end
