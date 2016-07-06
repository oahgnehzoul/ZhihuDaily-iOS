//
//  BottomView.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/5.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomView : UIView

@property (nonatomic,assign) BOOL isDark;
@property (weak, nonatomic) IBOutlet UIImageView *themeImage;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
@property (weak, nonatomic) IBOutlet UILabel *loadLabel;

@end
