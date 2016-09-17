//
//  ThemeTableView.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/7.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "ThemeTableView.h"
#import "ThemeTableViewCell.h"
#import "DetailViewController.h"
#import "ThemeViewController.h"
#import "storyModel.h"
#import "UIImageView+WebCache.h"
#import "EditorModel.h"
#import "EditorViewController.h"
#import "BaseNavController.h"
#import "UIView+UIViewController.h"
@implementation ThemeTableView
{
    UIView *view;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initViews];
    }
    return self;
}

- (void)_initViews {
    self.delegate = self;
    self.dataSource = self;
   
    [self registerClass:[ThemeTableViewCell class] forCellReuseIdentifier:@"cell"];
   
}

- (void)setThemeModelArray:(NSArray *)themeModelArray {
    _themeModelArray = themeModelArray;
    [self reloadData];
}
- (void)setEditorModelArray:(NSArray *)editorModelArray {
    _editorModelArray = editorModelArray;
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.themeModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    ThemeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (cell == nil) {
//        cell = [[ThemeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
    ThemeTableViewCell *cell = [[ThemeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.model = self.themeModelArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ThemeModel *model = self.themeModelArray[indexPath.row];
    NSLog(@"%@",model.idStr);
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.newsId = model.idStr;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (storyModel *model in self.themeModelArray) {
        NSString *newsId = model.idStr;
        [array addObject:newsId];
    }
    vc.newsIdArray = array;
    vc.index = indexPath.row;
    ThemeViewController *themeVc = (ThemeViewController *)self.nextResponder.nextResponder;
    [themeVc presentViewController:vc animated:YES completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 30)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 30, 20)];
    label.text = @"主编";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:12];
    [view addSubview:label];
    UIImageView *rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenWidth-40, 10, 20, 20)];
    rightImage.image = [UIImage imageNamed:@"Home_Arrow@2x"];
    [view addSubview:rightImage];
    
    for (int i = 0; i < _editorModelArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*35+60, 10, 20, 20)];
        imageView.image = [UIImage imageNamed:@"Menu_Avatar@2x"];
        imageView.layer.cornerRadius = 10;
        imageView.layer.masksToBounds = YES;
        EditorModel *model = _editorModelArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
        [view addSubview:imageView];
    }
    UIButton *headButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 30)];
    [headButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:headButton];
    return view;
    
}
- (void)buttonAction{
    
    EditorViewController *vc = [[EditorViewController alloc] init];
    vc.editorModelArray = self.editorModelArray;
    BaseNavController *nav = [[BaseNavController alloc] initWithRootViewController:vc];
    [self.viewController presentViewController:nav animated:YES completion:nil];
//    NSLog(@"1");
    
}


@end
