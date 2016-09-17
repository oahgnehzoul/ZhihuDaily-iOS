//
//  SBTableViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "SBTableViewController.h"
#import "SBTableViewDataSource.h"
#import "SBTableViewDelegate.h"
#import "SBTableViewFactory.h"
@interface SBTableViewController ()

@property(nonatomic,strong) UIView* footerViewNoResult;
@property(nonatomic,strong) UIView* footerViewLoading;
@property(nonatomic,strong) UIView* footerViewComplete;
@property(nonatomic,strong) UIView* footerViewError;

@end
@implementation SBTableViewController
@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;
- (instancetype)init {
    if (self = [super init]) {
        _bNeedLoadMore = NO;
        _bNeedPullRefresh = NO;
        _clearItemsWhenModelReload = NO;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.footerViewNoResult = [SBTableViewFactory getNormalFooterView:CGRectMake(0, 0, self.view.frame.size.width, 44) Text:@"空空如也"];
    self.footerViewLoading = [SBTableViewFactory getLoadingFooterView:CGRectMake(0, 0, self.view.frame.size.width, 44) Text:nil];
    self.footerViewError   = [SBTableViewFactory getErrorFooterView:CGRectMake(0, 0, self.view.frame.size.width, 44) Text:@"加载失败"];
    self.footerViewComplete = [SBTableViewFactory getNormalFooterView:CGRectMake(0, 0, self.view.frame.size.width, 1) Text:@""];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (void)setDataSource:(SBTableViewDataSource *)dataSource {
    _dataSource = dataSource;
    _dataSource.controller = self;
    self.tableView.dataSource = dataSource;
}

- (SBTableViewDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[SBTableViewDataSource alloc] init];
    }
    return _dataSource;
}

- (void)setDelegate:(SBTableViewDelegate*)delegate
{
    _delegate = delegate;
    _delegate.controller = self;
    self.tableView.delegate = delegate;
}
- (SBTableViewDelegate *)delegate {
    if (!_delegate) {
        _delegate = [[SBTableViewDelegate alloc] init];
    }
    return _delegate;
}

- (UITableViewStyle)tableViewStyle {
    return UITableViewStylePlain;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:[self tableViewStyle]];
        _tableView.dataSource = nil;
        _tableView.delegate = nil;
    }
    return _tableView;
}





- (void)load {
    NSAssert(_keyModel, @"至少需要指定一个 keyModel");
    [super load];
}

- (void)loadMore {
    if (self.bNeedLoadMore) {
        if ([self.keyModel hasMore]) {
            if (self.loadMoreAutomatically) {
                [self.keyModel loadMore];
            } else {
                [self showLoadMoreFooterView];
            }
        }
    }
}

- (void)showLoadMoreFooterView {
    self.tableView.tableFooterView = [SBTableViewFactory getClickableFooterView:CGRectMake(0, 0, self.view.frame.size.width, 44) Text:@"点击加载更多" Target: self Action:@selector(onLoadMoreClicked:)];
}

- (void)onLoadMoreClicked:(id)sender {
    [self.keyModel loadMore];
}

- (void)reload {
    if (self.clearItemsWhenModelReload) {
        [self.dataSource removeAllItems];
        [self.tableView reloadData];
    }
    [super reload];
}

- (void)loadModelByKey:(NSString *)key {
    [_modelDictInternal enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull modelKey, SBListModel*  _Nonnull model, BOOL * _Nonnull stop) {
        if ([key isEqualToString:modelKey]) {
            [model load];
        }
    }];
}

- (void)reloadModelByKey:(NSString *)key {
    [_modelDictInternal enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull modelKey, SBListModel*  _Nonnull model, BOOL * _Nonnull stop) {
        if ([key isEqualToString:modelKey]) {
            [model reload];
        }
    }];

}


- (void)beginRefreshing {
    [self.delegate beginRefreshing];
}

- (void)endRefreshing {
    [self.delegate stopRefreshing];
}


- (void)reloadTableView {
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.delegate;
    [self.tableView reloadData];
}

- (void)showLocalModel:(SBListModel *)model {
}

- (void)didLoadModel:(SBListModel *)model {
    [self.dataSource tableViewControllerDidLoadModel:model ForSection:model.sectionNubmer];
}

- (BOOL)canShowModel:(SBListModel *)model {
    return [super canShowModel:model] && model.itemList.count > 0;
}

- (void)showModel:(SBListModel *)model {
    [self endRefreshing];
    [self reloadTableView];
    self.tableView.tableFooterView = self.footerViewComplete;
}

- (void)showEmpty:(SBListModel *)model {
    [self endRefreshing];
    [self showNoResult:model];
}

- (void)showLoading:(SBModel *)model {
    if (model == _keyModel) {
        self.tableView.tableFooterView = self.footerViewLoading;
    }
}

- (void)showNoResult:(SBListModel *)model {
    [self endRefreshing];
    if (model == _keyModel) {
        self.tableView.tableFooterView = self.footerViewNoResult;
    }
}

- (void)showComplete:(SBListModel *)model {
    [self endRefreshing];
    if (model == _keyModel) {
        self.tableView.tableFooterView = self.footerViewComplete;
    }
}

- (void)showError:(NSError *)error withModel:(SBModel *)model {
    [self endRefreshing];
    if (model == _keyModel) {
        self.tableView.tableFooterView = [SBTableViewFactory getErrorFooterView:CGRectMake(0, 0, self.view.width, self.view.height) Text:error.localizedDescription ?:@"加载失败"];
    }
}

#pragma mark - UITableView
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath component:(NSDictionary*)bundle
{
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPat
{
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}
@end
