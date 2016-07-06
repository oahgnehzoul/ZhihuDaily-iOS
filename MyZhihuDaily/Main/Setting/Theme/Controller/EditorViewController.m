//
//  EditorViewController.m
//  zhihuDaily
//
//  Created by niceDay on 15/9/8.
//  Copyright (c) 2015年 computer. All rights reserved.
//

#import "EditorViewController.h"
#import "UIImageView+WebCache.h"
#import "EditorCell.h"

@interface EditorViewController ()

@end

@implementation EditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createSubViews];
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    self.navigationItem.title = @"主编";
}

- (void)_createSubViews{
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"Back_White"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[EditorCell class] forCellReuseIdentifier:@"kCell"];
    [self.view addSubview:_tableView];
    
    //添加 左滑手势
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe)]; swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [_tableView addGestureRecognizer:swipeGesture];
    
}
- (void)swipe{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)btnAction{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)setEditorModelArray:(NSMutableArray *)editorModelArray{
    
    if (editorModelArray) {
        _editorModelArray = editorModelArray;
        [_tableView reloadData];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _editorModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EditorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    EditorModel *model = _editorModelArray[indexPath.row];
    cell.model = model;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
