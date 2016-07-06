//
//  MainViewController.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/5.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "BaseViewController.h"
#import "ThemeCellModel.h"
@interface MainViewController : BaseViewController

@property (nonatomic,assign) NSInteger selectIndex;


@property (nonatomic,strong) ThemeCellModel *model;

@end
