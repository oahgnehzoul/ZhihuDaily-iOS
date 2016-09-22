//
//  ZDLeftBackView.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/18.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDLeftBackView : UIView

@property (nonatomic, copy) void (^touchPointBlock)(CGPoint point);

@end
