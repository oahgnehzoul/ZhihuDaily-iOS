//
//  ZDLeftViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/17.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDLeftViewController.h"
#import "ZDGetThemeModel.h"
#import "ZDLeftTableViewCell.h"
#import "ZDLeftThemeItem.h"
#import "ZDLeftBackView.h"
#import "ZDHomeViewController.h"
#import "ZDRootViewController.h"
#import "ZDThemeViewController.h"
@interface ZDLeftViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) ZDGetThemeModel *themeModel;

@property (nonatomic, strong) ZDLeftBackView *topView;
@end

@implementation ZDLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    @weakify(self);
    [self.themeModel loadWithCompletion:^(SBModel *model, NSError *error) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ZDLeftTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (ZDGetThemeModel *)themeModel {
    if (!_themeModel) {
        _themeModel = [[ZDGetThemeModel alloc] init];
    }
    return _themeModel;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.themeModel.itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setItem:self.themeModel.itemList.array[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.themeModel.itemList.array enumerateObjectsUsingBlock:^(ZDLeftThemeItem *  _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        item.isSelected = (idx == indexPath.row) ? YES : NO;
        [self.tableView reloadData];
    }];
    if (indexPath.row == 0) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ZDHomeViewController alloc] init]];
        [self.mmDraw setCenterViewController:nav withCloseAnimation:YES completion:nil];
    } else {
        ZDLeftThemeItem *item = self.themeModel.itemList.array[indexPath.row];
        [self.mmDraw setCenterViewController:[[ZDThemeViewController alloc] initWithThemeId:item.themeId] withCloseAnimation:YES completion:nil];
    }
    
}





@end
