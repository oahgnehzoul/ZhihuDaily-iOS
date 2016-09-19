//
//  ZDThemeViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/18.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDThemeViewController.h"

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
    
    self.title = @"用户推荐日报";
    
    
    
}

@end
