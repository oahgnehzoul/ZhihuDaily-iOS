//
//  SBTableViewDataSource.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SBTableViewItem,SBListModel,SBTableViewController;
@protocol SBTableViewDataSource <UITableViewDataSource>

- (Class)cellClassForItem:(SBTableViewItem *)item AtIndex:(NSIndexPath *)indexPath;


- (SBTableViewItem *)itemForCellAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableViewControllerDidLoadModel:(SBListModel *)model ForSection:(NSInteger)section;

@end

@interface SBTableViewDataSource : NSObject<SBTableViewDataSource>

@property (nonatomic, weak) SBTableViewController *controller;

@property (nonatomic, strong) NSDictionary *itemsForSection;
@property (nonatomic, strong) NSDictionary *totalCountForSection;

- (void)setItems:(NSArray *)items ForSection:(NSInteger)section;

- (NSArray *)getItems:(NSInteger)section;

- (void)removeItem:(SBTableViewItem *)item ForSection:(NSInteger)section;
- (void)removeItemsForSection:(NSInteger)section;

- (void)removeAllItems;



@end
