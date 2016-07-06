//
//  BaseNavController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/8/27.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "BaseNavController.h"

@interface BaseNavController ()

@end

@implementation BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationBar.tintColor = [UIColor whiteColor];
    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationBar.titleTextAttributes = attributes;
    self.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"mask_titlebar64@2x"] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.translucent = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
//      return [self.topViewController preferredStatusBarStyle];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
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
