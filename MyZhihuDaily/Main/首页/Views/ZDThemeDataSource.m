//
//  ZDThemeDataSource.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/22.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDThemeDataSource.h"
#import "ZDHomeTableViewCell.h"
@implementation ZDThemeDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (Class)cellClassForItem:(SBTableViewItem *)item AtIndex:(NSIndexPath *)indexPath {
    return [ZDHomeTableViewCell class];
}




@end
