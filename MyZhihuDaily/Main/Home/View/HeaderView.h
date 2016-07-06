//
//  HeaderView.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/5.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
@property (weak, nonatomic) IBOutlet UILabel *setLabel;


@property (nonatomic,assign) BOOL isNight;
@end
