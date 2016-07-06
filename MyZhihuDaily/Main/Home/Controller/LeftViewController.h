//
//  LeftViewController.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/5.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "BaseViewController.h"
#import "HeaderView.h"
#import "BottomView.h"
@interface LeftViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    HeaderView *_headerView;
    BottomView *_bottomView;
    UITableView *_tableView;
}
@end
