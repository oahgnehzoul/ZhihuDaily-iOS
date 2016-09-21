//
//  SBTableViewDelegate.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SBTableViewDelegate <UITableViewDelegate>

//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section;
//
//- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section;

@end

@protocol SBListPullToRefreshViewDelegate <NSObject>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)startRefreshing;
- (void)stopRefreshing;

@end


@interface SBTableViewDelegate : NSObject<SBTableViewDelegate,SBTableViewCellDelegate>

@property (nonatomic, weak) SBTableViewController *controller;

@property (nonatomic, strong) id<SBListPullToRefreshViewDelegate> pullRefreshView;

- (void)beginRefreshing;
- (void)stopRefreshing;

@end
