//
//  MainViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/5.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "MainViewController.h"
#import "ProfileViewController.h"
#import "FavoritesViewController.h"
#import "MessageViewController.h"
#import "SettingViewController.h"
#import "HomeViewController.h"
#import "ThemeViewController.h"
#import "BaseNavController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _createViewControllers];
}

//创建子控制器
- (void)_createViewControllers {
    ProfileViewController *vc1 = [[ProfileViewController alloc] init];
    FavoritesViewController *vc2  = [[FavoritesViewController alloc] init];
    MessageViewController *vc3 = [[MessageViewController alloc] init];
    SettingViewController *vc4 = [[SettingViewController alloc] init];
    HomeViewController *vc5 = [[HomeViewController alloc] init];
    ThemeViewController *vc6 = [[ThemeViewController alloc] init];
    
    NSArray *vcArray = @[vc5,vc1,vc2,vc3,vc4,vc6];
    for (int i = 0; i < 6 ; i++) {
        BaseNavController *nav = [[BaseNavController alloc] initWithRootViewController:vcArray[i]];
        [self addChildViewController:nav];
    }
    
    //显示第一个子控制器
    UIViewController *firstVC = self.childViewControllers[0];
    [self.view addSubview:firstVC.view];
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    if (_selectIndex != selectIndex) {
        UIViewController *lastVC = self.childViewControllers[_selectIndex];
        UIViewController *currentVC = self.childViewControllers[selectIndex];
        if (selectIndex == 5) {
            BaseNavController *nav = (BaseNavController *)currentVC;
            ThemeViewController *themeVC = nav.childViewControllers[0];

            themeVC.model = self.model;
            [lastVC.view removeFromSuperview];
            [self.view addSubview:nav.view];
        }
        else {
            [lastVC.view removeFromSuperview];
            [self.view addSubview:currentVC.view];

        }
        _selectIndex = selectIndex;
    }else {
        UIViewController *currentVC = self.childViewControllers[selectIndex];
        BaseNavController *nav = (BaseNavController *)currentVC;
        if ([nav.viewControllers[0] isKindOfClass:[ThemeViewController class]]) {
            ThemeViewController *themeVC = nav.childViewControllers[0];
            themeVC.model = self.model;
        }
        UIViewController *lastVC = self.childViewControllers[_selectIndex];
        [lastVC.view removeFromSuperview];
        [self.view addSubview:nav.view];
    }
    MMDrawerController *mmDraw = self.mm_drawerController;
    [mmDraw closeDrawerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
