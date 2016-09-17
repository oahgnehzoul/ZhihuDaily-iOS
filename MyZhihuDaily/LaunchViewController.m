//
//  LaunchViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/11.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "LaunchViewController.h"
#import "DataService.h"
#import "UIImageView+WebCache.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"
#import "MainViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "AppDelegate.h"
@interface LaunchViewController ()
{
    UIImageView *_lauchImageView;
    UIImageView *startImageView;
    NSString *urlString;
    NSString *_text;
}
@property (nonatomic, strong) UIImageView *launchImageView;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    startImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    startImageView.image = [UIImage imageNamed:@"LaunchImage-700-568h@2x"];
    UIImageView *loginImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kMainScreenWidth-120)/2, kMainScreenHeight-100, 120, 60)];
    loginImageView.image = [UIImage imageNamed:@"Login_Logo@2x"];
    [startImageView addSubview:loginImageView];
    [self.view addSubview:startImageView];
    [self performSelector:@selector(_changeImageView) withObject:nil afterDelay:1];
}



- (void)_changeImageView {
    _lauchImageView = [[UIImageView alloc] initWithFrame:self.view.bounds
                       ];
    [self.view addSubview:_lauchImageView];
    NSString *url = [NSString stringWithFormat:@"%@%.f*%.f",Start,kMainScreenWidth * 2,kMainScreenHeight * 2];
    [DataService requestAFUrl:url httpMethod:@"GET" params:nil data:nil block:^(id result) {
        NSString *imgStr = result[@"url"];
        [_lauchImageView sd_setImageWithURL:[NSURL URLWithString:imgStr] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            UIImageView *loginImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kMainScreenWidth-120)/2, kMainScreenHeight-100, 120, 60)];
            loginImageView.image = [UIImage imageNamed:@"Login_Logo@2x"];
            [self.view addSubview:loginImageView];
            [UIView animateWithDuration:1 animations:^{
                _lauchImageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
            } completion:^(BOOL finished) {
                [self _loadController];
            }];
        }];
    }];
}

- (void)_loadController {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    
    MainViewController *MainVC = [[MainViewController alloc] init];

    MMDrawerController *mmDraw = [[MMDrawerController alloc] initWithCenterViewController:MainVC leftDrawerViewController:leftVC];
    
    [mmDraw setMaximumLeftDrawerWidth:220.0];
    [mmDraw setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [mmDraw setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeParallax];
    [mmDraw setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
            block(drawerController,drawerSide,percentVisible);
        }
    }];
    delegate.mainVC = MainVC;
    delegate.window.rootViewController = mmDraw;
    delegate.window.backgroundColor = [UIColor whiteColor];

    
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
