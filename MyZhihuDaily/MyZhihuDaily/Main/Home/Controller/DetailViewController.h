//
//  DetailViewController.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/7.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UMSocial.h"
@interface DetailViewController : BaseViewController<UMSocialUIDelegate>

//@property (nonatomic,strong) NSURL *url;

@property (nonatomic,copy) NSString *newsId;

@property (nonatomic,copy) NSString *comments;
@property (nonatomic,copy) NSString *populatity;

@property (nonatomic, assign) NSInteger index;
//@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSArray *newsIdArray;
@end
