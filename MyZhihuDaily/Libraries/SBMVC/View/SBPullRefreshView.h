//
//  SBPullRefreshView.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/17.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SBPullRefreshViewDelegate <NSObject>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end
@interface SBPullRefreshView : UIView

@end
