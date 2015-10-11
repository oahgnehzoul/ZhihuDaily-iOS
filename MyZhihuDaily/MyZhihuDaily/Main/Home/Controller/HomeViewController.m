//
//  HomeViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/8/27.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "HomeViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "DataService.h"
#import "storyModel.h"
#import "UIImageView+WebCache.h"
#import "HomeHeaderView.h"
#import "HomeTableView.h"
#import "MJRefresh.h"
@interface HomeViewController ()
{
    NSArray *_topStoriesArray;
    NSArray *_storiesArray;

    HomeHeaderView *headerView;

    HomeTableView *_tableView;
    NSMutableArray *_topStoryModelArray;
    NSMutableArray *_storyModelArray;
    NSString *todayDate;
    NSString *lastDate;
    
//    NSMutableDictionary *_dataDic;
    NSMutableArray *_dataDicArray;
    
//    NSMutableArray *_dataArray;
    NSMutableArray *_dateArray;
    BOOL _isNight;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"今日热闻";
//    self.view.backgroundColor = [UIColor yellowColor];
    
    
    [self _createTableView];
    [self _loadData];
//    [self setRootNavItem];
    [self _setNavigation];
}

//- (void)dealloc{
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNofication object:nil];
//    
//    
//}

//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modeChangeAction) name:kThemeDidChangeNofication object:nil];
//    }
//    return self;
//    
//}
//- (void)modeChangeAction{
//    _isNight = !_isNight;
//    _tableView.isNight = _isNight;
//    if (_isNight) {
//        _tableView.backgroundColor = [UIColor grayColor];
//        
//    }
//    else{
//        _tableView.backgroundColor = [UIColor whiteColor];
//    }
//    
//}

//添加菜单按钮  此处还有bug,mmDraw open close 与 开关要同步。
- (void)_setNavigation {
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"Home_Icon.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    self.navigationController.navigationBar.translucent = YES;
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsCompact];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    self.navigationController.navigationBarHidden = YES;
}
- (void)btnAction:(UIButton *)btn {
    static BOOL i ;
    if (i == 0) {
        MMDrawerController *mmDraw = self.mm_drawerController;
        [mmDraw openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }else if (i == 1) {
        MMDrawerController *mmDraw = self.mm_drawerController;
        [mmDraw closeDrawerAnimated:YES completion:nil];
    }
    i = !i;
}

- (void)_createTableView {
    //头视图
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(KWidth, 200);
    headerView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 200) collectionViewLayout:layout];
    headerView.pagingEnabled = YES;
    _topStoryModelArray = [[NSMutableArray alloc] init];
    _storyModelArray = [[NSMutableArray alloc] init];
    _dateArray = [[NSMutableArray alloc] init];
    
    _tableView = [[HomeTableView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight) style:UITableViewStyleGrouped];
#warning !!!
    _tableView.sectionFooterHeight = 0;
    [self.view addSubview:_tableView];
//#warning 改了背景
//    _tableView.backgroundColor = [UIColor grayColor];
    _tableView.tableHeaderView = headerView;
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];
    

    _dataDicArray = [[NSMutableArray alloc] init];
    
}

- (void)_loadMoreData {
//    NSInteger lastDate = todayDate.integerValue -1;
//    if ((todayDate.integerValue % 10) > 1) {
//        lastDate = [NSString stringWithFormat:@"%ld",todayDate.integerValue];
//        NSLog(@"%@",todayDate);
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",BeforeNews,todayDate];
        [DataService requestAFUrl:urlStr httpMethod:@"GET" params:nil data:nil block:^(id result) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            todayDate = result[@"date"];
            [dic setValue:todayDate forKey:@"date"];
//            [_dateArray addObject:todayDate];
//            _tableView.dateArray = _dateArray;
            _storiesArray = result[@"stories"];
            NSMutableArray *newArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in _storiesArray) {
                storyModel *model = [[storyModel alloc] initWithDataDic:dic];
                NSArray *imagesArray = dic[@"images"];
                model.image = imagesArray[0];
//                [_storyModelArray addObject:model];
                [newArray addObject:model];
            }

            [dic setValue:newArray forKey:@"array"];
            [_dataDicArray addObject:dic];
            _tableView.dataDicArray = _dataDicArray;
//            _tableView.storyModelArray = _storyModelArray;
            [_tableView reloadData];
//#warning 导航栏显示日期
//            self.title = [Utils dateWithString:todayDate];
            [_tableView.footer endRefreshing];
        }];
//    }else {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"不好意思" message:@"只有这个月的新闻" delegate:self cancelButtonTitle:@"喔" otherButtonTitles:nil, nil];
//        [alert show];
//        [_tableView.footer endRefreshing];
//    }
}
- (void)_loadData {
    //下载网络数据
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [DataService requestAFUrl:LatestNews httpMethod:@"GET" params:nil data:nil block:^(id result) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            todayDate = [result objectForKey:@"date"];
//            NSLog(@"%@",todayDate);
            [dic setValue:todayDate forKey:@"date"];
//#warning 打印日期
            _topStoriesArray = [result objectForKey:@"top_stories"];
            for (NSDictionary *dic  in _topStoriesArray) {
                storyModel *model = [[storyModel alloc] initWithDataDic:dic];
                [_topStoryModelArray addObject:model];
            }
            _storiesArray = [result objectForKey:@"stories"];
            for (NSDictionary *dic in _storiesArray) {
                storyModel *model = [[storyModel alloc] initWithDataDic:dic];
                //返回image的value 类型不同，需要处理
                NSArray *imagesArray = dic[@"images"];
                model.image = imagesArray[0];
                [_storyModelArray addObject:model];
            }
            [dic setValue:_storyModelArray forKey:@"array"];
            dispatch_async(dispatch_get_main_queue(), ^{
                headerView.storyModelArray = _topStoryModelArray;
                [headerView reloadData];
//                _tableView.storyModelArray = _storyModelArray;
//                _dataArray = _storyModelArray;
//                _tableView.dataArray = _dataArray;
                [_dataDicArray addObject:dic];
                _tableView.dataDicArray = _dataDicArray;
                [_tableView reloadData];
            });
            
        }];
    });
    

}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated {
    [self setNeedsStatusBarAppearanceUpdate];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
