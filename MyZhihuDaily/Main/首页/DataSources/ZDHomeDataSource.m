//
//  ZDHomeDataSource.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/18.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDHomeDataSource.h"
#import "ZDHomeTableViewCell.h"
#import "ZDHomeStoryItem.h"
#import "ZDHomeStoryModel.h"
@implementation ZDHomeDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    ZDHomeStoryModel *model = (ZDHomeStoryModel *)self.controller.keyModel;
    return (model.currentPageIndex + 1);
}

- (Class)cellClassForItem:(SBTableViewItem *)item AtIndex:(NSIndexPath *)indexPath {
    return [ZDHomeTableViewCell class];
}

- (void)tableViewControllerDidLoadModel:(SBListModel *)model ForSection:(NSInteger)section {
    NSLog(@"%ld",model.sectionNubmer);
    [self setItems:model.itemList.array ForSection:model.sectionNubmer];
}


@end
