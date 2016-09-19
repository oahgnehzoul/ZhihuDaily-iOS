//
//  ZDRootViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/17.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDRootViewController.h"
#import "ZDLeftViewController.h"
#import "ZDHomeViewController.h"
@interface ZDRootViewController ()

@end

@implementation ZDRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ZDLeftViewController *leftMenuVc = [[ZDLeftViewController alloc] init];
    leftMenuVc.mmDraw = self;

    ZDHomeViewController *homeVc = [[ZDHomeViewController alloc] init];
    homeVc.mmDraw = self;
    
    self.leftDrawerViewController = leftMenuVc;
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeVc];
    self.centerViewController = nav;
    
    [self setMaximumLeftDrawerWidth:kZDLeftViewControllerWidth];
    [self setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    //滑动到最大距离不能再向右
    [self setShouldStretchDrawer:NO];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    

}
@end
