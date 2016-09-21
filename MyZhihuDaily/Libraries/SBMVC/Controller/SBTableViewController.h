//
//  SBTableViewController.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "SBViewController.h"

@class SBTableViewDataSource,SBTableViewDelegate,SBListModel;
@interface SBTableViewController : SBViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SBTableViewDelegate *delegate;
@property (nonatomic, strong) SBTableViewDataSource *dataSource;
@property (nonatomic, strong) SBListModel *keyModel;
@property (nonatomic, assign) BOOL bNeedLoadMore;
@property (nonatomic, assign) BOOL bNeedPullRefresh;
@property (nonatomic, assign) BOOL loadMoreAutomatically;
@property (nonatomic, assign) BOOL clearItemsWhenModelReload;

- (void)loadModelByKey:(NSString *)key;
- (void)reloadModelByKey:(NSString *)key;
- (void)beginRefreshing;
- (void)endRefreshing;

- (void)showLocalModel:(SBListModel *)model;

- (UITableViewStyle)tableViewStyle;

@end

@interface SBTableViewController (UITableView)

#pragma mark datasource
/**
 * tableview cell的点击事件
 */
- (void)tableView:(UITableView *)tableView  didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 * tableview cell的UI组件点击，bunlde中存放了自定义的参数
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath component:(NSDictionary*)bundle;
/**
 * tableview cell的编辑事件
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;


#pragma delegate
/**
 * scrollview的滚动回调
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
/**
 * scrollview拖拽释放后的回调
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
/**
 * scrollview拖拽事件回调
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView ;
/**
 * scrollview停止滚动回调
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView ;

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section;

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section;


@end

@interface SBTableViewController (Subclassing)

- (void)showNoResult:(SBListModel *)model;
- (void)showComplete:(SBListModel *)model;

@end
