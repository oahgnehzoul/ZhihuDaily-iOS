//
//  SBTableViewDelegate.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SBTableViewDelegate <UITableViewDelegate>

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
