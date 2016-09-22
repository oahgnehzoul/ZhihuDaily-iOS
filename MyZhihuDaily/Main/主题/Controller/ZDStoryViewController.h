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
@interface ZDStoryViewController : SBViewController

- (id)initWithStoryId:(NSString *)storyId andHeader:(BOOL)has;

@property (nonatomic, strong) ZDHomeViewController *vc;

@end
