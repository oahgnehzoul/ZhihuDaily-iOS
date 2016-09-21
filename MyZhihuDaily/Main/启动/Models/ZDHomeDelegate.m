//
//  ZDHomeDelegate.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/21.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDHomeDelegate.h"
#import "ZDHomeDataSource.h"
#import "ZDHomeStoryModel.h"
@implementation ZDHomeDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0.f : 38;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 38)];
    view.backgroundColor = [UIColor hx_colorWithHexRGBAString:kZDHomeNavDefaultColor];
    UILabel *dateLabel = [UILabel new];
//    ZDHomeDataSource *ds = (ZDHomeDataSource *)self.controller.dataSource;
    ZDHomeStoryModel *model = (ZDHomeStoryModel *)self.controller.keyModel;
    dateLabel.text = [model.dateStr mutableCopy];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
    }];
    if (section == 0) {
        return nil;
    } else {
        return view;
    }
}



@end
