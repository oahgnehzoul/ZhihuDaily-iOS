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

//- (NSString *)getDateFromStr:(NSString *)str {
//    NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
//    [dateFormate setDateFormat:@"yyyyMMdd"];
//    NSDate *date = [dateFormate dateFromString:str];
//    [dateFormate setDateFormat:@"MM月dd日 EEEE"];
//    return [dateFormate stringFromDate:date];
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
        if (section == 0) {
        return nil;
    } else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 38)];
        view.backgroundColor = [UIColor hx_colorWithHexRGBAString:kZDHomeNavDefaultColor];
        UILabel *dateLabel = [UILabel new];
        ZDHomeStoryModel *model = (ZDHomeStoryModel *)self.controller.keyModel;
//        dateLabel.text = [self getDateFromStr:model.dates[section]];
        dateLabel.text = [ZDUtils dateWithString:model.dates[section]];
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.font = [UIFont systemFontOfSize:14];
        [view addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(view);
        }];
        return view;
    }
}



@end
