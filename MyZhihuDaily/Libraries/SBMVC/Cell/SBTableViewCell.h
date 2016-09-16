//
//  SBTableViewCell.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SBTableViewCellDelegate <NSObject>

@optional

/**
 optional:cell 的 delegate，cell 的 subview 响应事件传递给 delegate 处理。

 @param indexPath cell 的 indexPath
 @param bundle    cell 需要传递给 delegate 的数据
 */
- (void)onCellComponentClickedAtIndex:(NSIndexPath *)indexPath Bundle:(NSDictionary *)bundle;

@end

@class SBTableViewItem;
@interface SBTableViewCell : UITableViewCell
//cell 的 indexPath
@property (nonatomic, strong) NSIndexPath *indexPath;
//cell 绑定的 item 数据
@property (nonatomic, strong) SBTableViewItem *item;
//cell 的 delegate
@property (nonatomic, weak) id<SBTableViewCellDelegate> delegate;

/**
 计算 cell 高度

 @param tableView  cell 所在 tableView
 @param item       cell 对应的数据
 @param indexPath  cell 对应的 indexPath
 */
+ (CGFloat)tableView:(UITableView *)tableView variantRowHeightForItem:(SBTableViewItem *)item AtIndex:(NSIndexPath *)indexPath;
@end
