//
//  ZDHomeStoryModel.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/18.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDListModel.h"

@interface ZDHomeStoryModel : ZDListModel

@property (nonatomic, copy) NSString *dateStr;


@property (nonatomic, copy) NSArray *stories;

@property (nonatomic, assign) BOOL isLatest;
@end
