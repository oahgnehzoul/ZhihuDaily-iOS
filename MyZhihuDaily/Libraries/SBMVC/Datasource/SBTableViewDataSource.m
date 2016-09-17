//
//  SBTableViewDataSource.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "SBTableViewDataSource.h"

@interface SBTableViewDataSource ()
{
    NSMutableDictionary *_itemForSectionInternal;
    NSMutableDictionary *_totalCountForSectionInternal;
}

@end

@implementation SBTableViewDataSource

- (NSDictionary *)itemsForSection {
    return [_itemForSectionInternal copy];
}

- (NSDictionary *)totalCountForSection {
    return [_totalCountForSection copy];
}

- (instancetype)init {
    if (self = [super init]) {
        _itemForSectionInternal = @{}.mutableCopy;
        _totalCountForSectionInternal = @{}.mutableCopy;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"[%@-->dealloc]",self.class);
}

- (void)setItems:(NSArray *)items ForSection:(NSInteger)section {
    [_itemForSectionInternal setObject:items.mutableCopy forKey:@(section)];

}

- (NSArray *)getItems:(NSInteger)section {
    return section < _itemForSectionInternal.count ? _itemForSectionInternal[@(section)] : @[];
}

- (void)removeItem:(SBTableViewItem *)item ForSection:(NSInteger)section {
    if (section >= 0 && section < _itemForSectionInternal.count) {
        NSMutableArray *items = [_itemForSectionInternal objectForKey:@(section)];
        for (id obj in items) {
            if ([obj isEqual:item]) {
                [items removeObject:obj];
            }
        }
    }
}

- (void)removeItemsForSection:(NSInteger)section {
    if (section >= 0 && section < _itemForSectionInternal.count) {
        [_itemForSectionInternal removeObjectForKey:@(section)];
    }
}

- (void)removeAllItems {
    [_itemForSectionInternal removeAllObjects];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *items = _itemForSectionInternal[@(section)];
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SBTableViewItem *item = [self itemForCellAtIndexPath:indexPath];
    Class cellClass = [self cellClassForItem:item AtIndex:indexPath];
    NSString *cellIdentifier = NSStringFromClass(cellClass);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if ([cell isKindOfClass:[SBTableViewCell class]]) {
        SBTableViewCell *tableViewcell = (SBTableViewCell *)cell;
        [tableViewcell setItem:item];
        tableViewcell.indexPath = indexPath;
        tableViewcell.delegate = (id<SBTableViewCellDelegate>)tableView.delegate;
    }
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"";
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.controller tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.controller tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

#pragma mark private

- (SBTableViewItem *)itemForCellAtIndexPath:(NSIndexPath *)indexPath {
    SBTableViewItem *ret = nil;
    NSArray *items = _itemForSectionInternal[@(indexPath.section)];
    if (indexPath.row < items.count) {
        ret = items[indexPath.row];
    } else {
        ret = [SBTableViewItem new];
    }
    return ret;
}

- (Class)cellClassForItem:(SBTableViewItem *)item AtIndex:(NSIndexPath *)indexPath {
    return [SBTableViewCell class];
}

- (void)tableViewControllerDidLoadModel:(SBListModel *)model ForSection:(NSInteger)section {
    [_totalCountForSectionInternal setObject:@(model.itemList.count) forKey:@(section)];
    [self setItems:[model.itemList.array mutableCopy] ForSection:section];
}



@end
