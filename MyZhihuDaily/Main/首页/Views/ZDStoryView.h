//
//  ZDStoryView.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/26.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDStoryItem.h"
@protocol ZDStoryViewDelegate <UIWebViewDelegate,UIScrollViewDelegate>

- (void)getNextStoryPage;
- (void)getPreviousStoryPage;

@end
@class ZDStoryViewController;
@interface ZDStoryView : UIView

@property (nonatomic, weak) id<ZDStoryViewDelegate> delegate;

- (void)setItem:(ZDStoryItem *)item;
@property (nonatomic, weak) ZDStoryViewController *vc;

// 显示已经是第一篇了.
@property (nonatomic, assign) BOOL isFirst;

@property (nonatomic, assign) BOOL isGray;
@end
