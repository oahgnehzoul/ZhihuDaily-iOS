//
//  ZDStoryViewController.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/20.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBViewController.h"
#import "ZDHomeViewController.h"
#import "ZDThemeViewController.h"
@interface ZDStoryViewController : SBViewController

- (id)initWithStoryId:(NSString *)storyId;

@property (nonatomic, weak) ZDHomeViewController *homeVc;
@property (nonatomic, assign) BOOL isStatusBarStyleDefault;
@property (nonatomic, weak) ZDThemeViewController *themeVc;
@end
