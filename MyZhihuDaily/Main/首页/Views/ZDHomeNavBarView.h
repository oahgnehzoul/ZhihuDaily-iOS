//
//  ZDHomeNavBarView.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/18.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDHomeNavBarView : UIView

- (void)showLoadingWithBlock:(void(^)())refreshBlock;

- (void)hideLoading;

- (void)hideProgress;

- (void)setLabelAlpha:(CGFloat)alpha;

@property (nonatomic, copy) void (^progressBlock)(CGFloat progerss);

@property (nonatomic, copy) void (^touchBlock)();

//@property (nonatomic, assign) CGFloat alpha;

@property (nonatomic, assign) BOOL isAnimating;

@end
