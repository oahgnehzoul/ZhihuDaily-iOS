//
//  SettingViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/8/27.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "SettingViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "SDImageCache.h"
@interface SettingViewController ()
{
    NSArray *_nameArray;
    SDImageCache *_cache;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self setRootNavItem];
    [self _createTableView];
}

- (void)_createTableView {
    _nameArray = @[@"oahgnehzoul",@"自动离线下载",@"移动网络不下载图片",@"大字号",@"消息推送",@"点评分享到微博",@"去好评",@"去吐槽",@"清除缓存"];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

#pragma mark - UItableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2||section == 3|| section == 4) {
        return 2;
    }else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UISwitch *cellSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(KWidth-70, 5, 60, 30)];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.section == 0) {
        
//        cell.imageView.frame = CGRectMake(0, 0, 25, 25);
        cell.imageView.image = [UIImage imageNamed:@"IMG_1779.jpg"];
        cell.imageView.layer.cornerRadius = 20;
        cell.imageView.layer.masksToBounds = YES;
        cell.textLabel.text = @"oagnehzoul";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.section == 1) {
        cell.textLabel.text = _nameArray[indexPath.row + 1];
        [cell.contentView addSubview:cellSwitch];
    }else if (indexPath.section == 2) {
        cell.textLabel.text = _nameArray[indexPath.row + 2];
        [cell.contentView addSubview:cellSwitch];
    }else if (indexPath.section == 3) {
        cell.textLabel.text = _nameArray[indexPath.row + 4];
        [cell.contentView addSubview:cellSwitch];
    }else if (indexPath.section == 4) {
        cell.textLabel.text = _nameArray[indexPath.row + 6];
        [cell.contentView addSubview:cellSwitch];
    }else {
        cell.textLabel.text = _nameArray[8];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:16];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark - UITableViewDelegate 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 43;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 20;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section <= 5) {
//        return 20;
//    }
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [UIView animateWithDuration:1 animations:^{
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            MainViewController *vc = delegate.mainVC;
            vc.selectIndex = 1;
        }];
       
    }else if (indexPath.section == 5) {
        NSLog(@"清除缓存");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认清除缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];
    }else if (indexPath.section == 4) {
        NSLog(@"%@",_nameArray[indexPath.row + 6]);
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        _cache = [SDImageCache sharedImageCache];
        [_cache clearDisk];
//        [_tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
