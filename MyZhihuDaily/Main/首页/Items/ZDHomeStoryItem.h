//
//  ZDHomeStoryItem.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/18.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "SBTableViewItem.h"

@interface ZDHomeStoryItem : SBTableViewItem

@property (nonatomic, copy) NSString *storyId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, copy) NSString *ga_prefix;
@property (nonatomic, copy) NSString *image;

@end
