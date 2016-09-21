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
#import "ZDLaunchModel.h"
@interface ZDRootViewController ()

@property (nonatomic, strong) ZDLaunchModel *launchModel;
@end

@implementation ZDRootViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    ZDLeftViewController *leftMenuVc = [[ZDLeftViewController alloc] init];
    leftMenuVc.mmDraw = self;

    ZDHomeViewController *homeVc = [[ZDHomeViewController alloc] init];
    homeVc.mmDraw = self;
    
    self.leftDrawerViewController = leftMenuVc;
    
    
    BaseNavController *nav = [[BaseNavController alloc] initWithRootViewController:homeVc];
    self.centerViewController = nav;
    
    [self setMaximumLeftDrawerWidth:kZDLeftViewControllerWidth];
    [self setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    //滑动到最大距离不能再向右
    [self setShouldStretchDrawer:NO];
    
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    @weakify(self);
    [self.launchModel loadWithCompletion:^(SBModel *model, NSError *error) {
        @strongify(self);
        ZDLaunchModel *launchModel = (ZDLaunchModel *)model;
        [[NSUserDefaults standardUserDefaults] setObject:launchModel.text forKey:kZDBootImageAuthor];
        if (launchModel.imageUrl.length > 0) {
            NSString *lastImageUrl = [[NSUserDefaults standardUserDefaults] objectForKey:kZDBootImageUrl];
            if (![lastImageUrl isEqualToString:launchModel.imageUrl]) {
                [self clearImageInfo];
            }
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:launchModel.imageUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                NSLog(@"%ld,%ld",(long)receivedSize,expectedSize);
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                [[NSUserDefaults standardUserDefaults] setObject:launchModel.imageUrl forKey:kZDBootImageUrl];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }];

            
        } else {
            [self clearImageInfo];
        }
    }];
}


- (void)clearImageInfo {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kZDBootImageUrl];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (ZDLaunchModel *)launchModel {
    if (!_launchModel) {
        _launchModel = [[ZDLaunchModel alloc] init];
    }
    return _launchModel;
}
@end
