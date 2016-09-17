//
//  SBTableViewDelegate.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "SBTableViewDelegate.h"

@implementation SBTableViewDelegate

- (void)setPullRefreshView:(id<SBListPullToRefreshViewDelegate>)pullRefreshView {
    _pullRefreshView = pullRefreshView;
    [self.controller.tableView addSubview:(UIView *)_pullRefreshView];
}

- (void)dealloc {
    NSLog(@"[%@-->dealloc]",self.class);
}

- (void)beginRefreshing {
    
}

- (void)stopRefreshing {

}

- (void)onCellComponentClickedAtIndex:(NSIndexPath *)indexPath Bundle:(NSDictionary *)bundle {
    if (bundle) {
        [self.controller tableView:self.controller.tableView didSelectRowAtIndexPath:indexPath component:bundle];
    } else {
        [self.controller tableView:self.controller.tableView didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    SBTableViewDataSource *ds = (SBTableViewDataSource *)tableView.dataSource;
    NSInteger sectionCount = [ds numberOfSectionsInTableView:tableView];
    if (indexPath.section == (sectionCount - 1)) {
        NSArray *items = ds.itemsForSection[@(indexPath.section)];
        if (indexPath.row == (items.count - 1)) {
            [self.controller loadMore];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SBTableViewDataSource *ds = (SBTableViewDataSource *)tableView.dataSource;
    SBTableViewItem *item = [ds itemForCellAtIndexPath:indexPath];
    if (item.itemHeight > 0) {
        return item.itemHeight;
    } else {
        SBTableViewCell *cell = (SBTableViewCell *)[ds cellClassForItem:item AtIndex:indexPath];
        return [cell.class tableView:tableView variantRowHeightForItem:item AtIndex:indexPath];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.controller tableView:tableView didSelectRowAtIndexPath:indexPath];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.controller.isEditing) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleNone;
    }
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
}

                              


@end
