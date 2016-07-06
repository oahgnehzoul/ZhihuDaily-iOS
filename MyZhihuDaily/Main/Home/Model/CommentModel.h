//
//  CommentModel.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/11.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property (nonatomic,copy) NSString *author;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSNumber *time;
@property (nonatomic,copy) NSNumber *idStr;
@property (nonatomic,copy) NSNumber *likes;

@end
