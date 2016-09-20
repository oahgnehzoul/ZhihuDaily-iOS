//
//  ZDStoryItem.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/20.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "SBItem.h"

@interface ZDStoryItem : SBItem
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *imageSource;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSArray *js;
@property (nonatomic, copy) NSString *ga_prefix;
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *storyId;
@property (nonatomic, copy) NSArray *css;


@end
