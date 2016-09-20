//
//  ZDThemeViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/18.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDThemeViewController.h"
#import "ZDLaunchAdvertiseView.h"
@interface ZDThemeViewController ()

@property (nonatomic, copy) NSString *themeId;
@end

@implementation ZDThemeViewController

- (id)initWithRouterParams:(NSDictionary *)params {
    if (self = [super init]) {
        
    }
    return self;
}

- (id)initWithThemeId:(NSString *)themeId {
    if (self = [super init]) {
        self.themeId = themeId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"主题页面";
    
//    ZDLaunchAdvertiseView *launchView = [[ZDLaunchAdvertiseView alloc] initWithFrame:self.view.bounds];
//    [launchView startLaunch];
    
}

@end
