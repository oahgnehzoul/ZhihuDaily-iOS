//
//  LeftViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/5.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "LeftViewController.h"
#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "ThemeCellModel.h"
@interface LeftViewController ()
{
    NSArray *nameArray;
    NSMutableArray *_modelArray;
    BOOL _isNight;
    UITableViewCell *cell;
//    UILabel *cellLabel;
}
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _createSubViews];
    [self _loadData];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modeChangeAction) name:kThemeDidChangeNofication object:nil];
    
}


- (void)modeChangeAction{
    _isNight = !_isNight;
    if (_isNight) {
        _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Dark_News_Text_bg@2x.png"]];

    }
    else{
        _tableView.backgroundColor = [UIColor whiteColor];

    }
    [_tableView reloadData];
    [self preferredStatusBarStyle];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (_isNight) {
        return UIStatusBarStyleLightContent;
    }else {
        return UIStatusBarStyleLightContent;
    }
}
- (void)_loadData {
    [DataService requestAFUrl:ThemeList httpMethod:@"GET" params:nil data:nil block:^(id result) {
        _modelArray = [[NSMutableArray alloc] init];
        NSArray *themeArray = result[@"others"];
        for (NSDictionary *dic in themeArray) {
            ThemeCellModel *model = [[ThemeCellModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_modelArray addObject:model];
        }
        [_tableView reloadData];
    }];
}

- (void)_createSubViews {
//    nameArray = @[@"首页",@"日常心理学",@"用户推荐日报",@"电影日报",@"不许无聊",@"设计日报",@"大公司日报",@"财经日报",@"互联网安全",@"开始游戏",@"音乐日报",@"动漫日报",@"体育日报"];
    NSArray *headerArray = [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    _headerView = [headerArray lastObject];
    _headerView.frame = CGRectMake(0, 0, kMainScreenWidth, 150);
    


   
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, 220, kMainScreenHeight-150-60) style:UITableViewStylePlain];
//    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
//#warning color
//    _tableView.backgroundColor = [UIColor lightGrayColor];
    
     NSArray *bottomArray = [[NSBundle mainBundle] loadNibNamed:@"BottomView" owner:self options:nil];
    _bottomView = [bottomArray lastObject];
    _bottomView.frame = CGRectMake(0, kMainScreenHeight-60, kMainScreenWidth, 60);
    
    [self.view addSubview:_headerView];
    [self.view addSubview:_tableView];
    [self.view addSubview:_bottomView];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modeChangeAction) name:kThemeDidChangeNofication object:nil];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return nameArray.count;
    return _modelArray.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        
//    }
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"Menu_Icon_Home@2x.png"];
//        cell.textLabel.text = nameArray[indexPath.row];
        cell.textLabel.text = @"首页";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }else {
    //    cell.textLabel.text = nameArray[indexPath.row];
        ThemeCellModel *model = _modelArray[indexPath.row-1];
        cell.textLabel.text = model.name;
//        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (_isNight) {
        cell.textLabel.textColor = [UIColor whiteColor];
    }else {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.row == 0) {
//        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//        MainViewController *vc = delegate.mainVC;
//        vc.selectIndex = 0;
//    }else {
//        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//        MainViewController *vc = delegate.mainVC;
//        
//        vc.model = _modelArray[indexPath.row - 1];
////        vc.themeId = [NSString stringWithFormat:@"%ld",indexPath.row+1];
//        vc.selectIndex = 5;
//    }
}

- (void)_loadThemeData {
    //下载主题数据
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
