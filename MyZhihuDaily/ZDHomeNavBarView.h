//
//  ZDHomeNavBarView.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/18.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol ZDLeftButtonProtocol <NSObject>
//
//- (void)openMenu;
//
//@end

@interface ZDHomeNavBarView : UIView

- (void)showLoadingWithBlock:(void(^)())refreshBlock;
- (void)hideLoading;

- (void)hideProgress;
@property (nonatomic, copy) void (^progressBlock)(CGFloat progerss);

@property (nonatomic, copy) void (^menuTouchBlock)();

@property (nonatomic, assign) CGFloat alpha;

//@property (nonatomic, weak) id<ZDLeftButtonProtocol> delegate;
@end
