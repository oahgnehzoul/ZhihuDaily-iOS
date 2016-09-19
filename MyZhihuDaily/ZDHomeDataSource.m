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
@implementation ZDHomeDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (Class)cellClassForItem:(SBTableViewItem *)item AtIndex:(NSIndexPath *)indexPath {
    return [ZDHomeTableViewCell class];
}



@end
