//
//  storyModel.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/6.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "BaseModel.h"

@interface storyModel : BaseModel
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *idStr;
@property (nonatomic,copy) NSString *ga_prefix;
@property (nonatomic,copy) NSString *title;
@end
