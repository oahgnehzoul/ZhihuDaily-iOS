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
#import "HomeHeaderViewCell.h"
#import "DetailViewController.h"
#import "HomeTableViewCell.h"
#import "UINavigationBar+BackgroundColor.h"

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
    

    NSMutableArray *_dataDicArray;
    
    NSMutableArray *_dateArray;
    NSMutableArray *rowArray;
    BOOL _isNight;
//    NSInteger i;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"今日热闻";
    [self _createTableView];
    [self _loadData];
    [self _setNavigation];
}


//添加菜单按钮  此处还有bug,mmDraw open close 与 开关要同步。
- (void)_setNavigation {
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"Home_Icon.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];

    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)btnAction:(UIButton *)btn {
    static BOOL j ;
    if (j == 0) {
        MMDrawerController *mmDraw = self.mm_drawerController;
        [mmDraw openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }else if (j == 1) {
        MMDrawerController *mmDraw = self.mm_drawerController;
        [mmDraw closeDrawerAnimated:YES completion:nil];
    }
    j = !j;
}

- (void)_createTableView {
    //头视图
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(kMainScreenWidth, 220);
    headerView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 220) collectionViewLayout:layout];
    headerView.pagingEnabled = YES;
    _topStoryModelArray = [[NSMutableArray alloc] init];
    _storyModelArray = [[NSMutableArray alloc] init];
    _dateArray = [[NSMutableArray alloc] init];
    
    _tableView = [[HomeTableView alloc] initWithFrame:CGRectMake(0, -64, kMainScreenWidth, kMainScreenHeight+64) style:UITableViewStylePlain];
//    _tableView.dataSource = self;
//    _tableView.delegate = self;
//    [_tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];

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

}
- (void)_loadData {
    //下载网络数据
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [DataService requestAFUrl:LatestNews httpMethod:@"GET" params:nil data:nil block:^(id result) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            todayDate = [result objectForKey:@"date"];
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

//#pragma mark - UITableViewDataSource
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    //    return self.storyModelArray.count;
//    NSArray *array = [_dataDicArray[section] objectForKey:@"array"];
//    return array.count;
//    
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSArray *array = [_dataDicArray[indexPath.section] objectForKey:@"array"];
//    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    
//    cell.model = array[indexPath.row];
//    cell.backgroundColor = [UIColor clearColor];
//    
//    
//    return cell;
//}
//
//#pragma mark - UITableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 80;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    DetailViewController *vc = [[DetailViewController alloc] init];
//    NSArray *modelArray = [_dataDicArray[indexPath.section] objectForKey:@"array"];
//    storyModel *model = modelArray[indexPath.row];
//    vc.newsId = model.idStr;
//    NSLog(@"%@",vc.newsId);
//    //    vc.dataArray = [self.dataDicArray[indexPath.section] objectForKey:@"array"];
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    for (storyModel *model in modelArray) {
//        NSString *newsId = model.idStr;
//        [array addObject:newsId];
//    }
//    vc.newsIdArray = array;
//    vc.index = indexPath.row;
//    //    HomeViewController *homeVC = (HomeViewController *)self.nextResponder.nextResponder;
//    [self presentViewController:vc animated:YES completion:nil];
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    //    if (_dateArray) {
//    //        return _dateArray.count+1;
//    //    }
//    //    return 1;
//    return _dataDicArray.count;
//}
////日期显示
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return nil;
//    }else {
//        UIView *dateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 40)];
//        UILabel *dateLabel = [[UILabel alloc] initWithFrame:dateView.bounds];
//        dateLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mask_titlebar64@2x"]];
//        //        dateLabel.backgroundColor = [UIColor blueColor];
//        NSString *date = [_dataDicArray[section] objectForKey:@"date"];
//        dateLabel.text = [self dateWithString:date];
//        
//        dateLabel.textAlignment = NSTextAlignmentCenter;
//        dateLabel.textColor = [UIColor whiteColor];
//        [dateView addSubview:dateLabel];
//        
//        
//        
//        return dateView;
//    }
//}
//
//
//- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
//    
//    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
//    
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    
//    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
//    
//    [calendar setTimeZone: timeZone];
//    
//    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
//    
//    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
//    
//    return [weekdays objectAtIndex:theComponents.weekday];
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return 0;
//    }else {
//        return 40;
//    }
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0;
//}
//- (NSString *)dateWithString:(NSString *)string{
//    NSString *formatStr = @"yyyyMMdd";
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = formatStr;
//    NSDate *date = [formatter dateFromString:string];
//    //#warning 打印
//    //    NSLog(@"%@",[self weekdayStringFromDate:date]);
//    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
//    [formatter1 setDateFormat:@"MM月dd日"];
//    NSString *dateString = [formatter1 stringFromDate:date];
//    NSString *fullStr = [dateString stringByAppendingString:[self weekdayStringFromDate:date]];
//    return fullStr;
//    
//    
//}
////得到要改变日期的偏移量数组
//- (NSArray *)offYarray{
//    
//    NSInteger offy = 220-64-64;
//    NSMutableArray *offyArray = [[NSMutableArray alloc] init];
//    for (i = 0 ; i< rowArray.count; i++) {
//        offy+= ([rowArray[i] integerValue]*80+40);
//        [offyArray addObject:[NSNumber numberWithInteger:offy]];
//    }
//    
//    return (NSArray *)offyArray;
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat offY = scrollView.contentOffset.y;
//    //    NSLog(@"%f",offY);
//    //    NSLog(@"count:%ld",rowArray.count);
//    //    NSLog(@"array:%@",[self offYarray]);
//    //    NSLog(@"%f",alpha);
//    UIColor *color = [UIColor colorWithRed:0 green: 175/255.0 blue:240/255.0 alpha:1];
//    CGFloat alpha = (offY + 64)/156;
//    [self.navigationController.navigationBar hzl_setBackgourndColor:[color colorWithAlphaComponent:alpha]];
//        if (offY < 0) {
////            imgView.frame = CGRectMake(0, offY, kMainScreenWidth, 200-offY);
//            HomeHeaderViewCell *cell = [headerView cellForItemAtIndexPath:0];
//            UIImageView *imgView = cell.imgView;
//            imgView.frame = CGRectMake(0, offY, kMainScreenWidth, 200-offY);
//        }
//    //    if (offY <= -64) {
//    //        CGFloat newHeight = -offY - 64 +200;
//    ////        self.tableHeaderView.frame = CGRectMake(0, 0, kMainScreenWidth, newHeight);
//    //    }
//    //    self.tableHeaderView.bottom = self.top;
//    //    if (offY <= -64) {
//    //        self.tableHeaderView.frame = CGRectMake(0, 0, kMainScreenWidth, -offY-64+200);
//    //    }
//    //    UIView *view = self.tableHeaderView;
//    //    NSLog(@"%f %f",view.frame.size.width,view.size.height);
//    
//    NSArray *offArray = [self offYarray];
//    if (offArray.count > 1) {
//        
//        for ( i = 0; i < offArray.count - 1; i++) {
//            if (offY >= [offArray[i] integerValue] && offY <= [offArray[i+1] integerValue]) {
//                //                if (offY >= ([offArray[0] integerValue]+[offArray[1] integerValue] )) {
//                //                    [self setNavigationBarTransformProgress:1];
//                //                }
//                NSDictionary *dic = _dataDicArray[i+1];
//                NSString *date = dic[@"date"];
//                NSString *text = [self dateWithString:date];
//                self.navigationItem.title = text;
//            }else if (offY <= [offArray[0] integerValue]) {
//                self.title = @"今日热闻";
//            }
//        }
//        
//        
//    }
//}
//



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
