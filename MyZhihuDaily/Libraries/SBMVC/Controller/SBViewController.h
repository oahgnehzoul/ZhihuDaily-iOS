//
//  SBViewController.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBModel;
@interface SBViewController : UIViewController{
    NSMutableDictionary *_modelDictInternal;
}

@property (nonatomic, strong, readonly) NSDictionary *modelDictionary;

- (void)registerModel:(SBModel *)model;
- (void)unRegisterModel:(SBModel *)model;
- (void)load;
- (void)reload;
- (void)loadMore;

@end


@interface SBViewController (Subclassing)

- (void)didLoadModel:(SBModel *)model;
- (void)showLoading:(SBModel *)model;
- (BOOL)canShowModel:(SBModel *)model;
- (void)showModel:(SBModel *)model;
- (void)showEmpty:(SBModel *)model;
- (void)showError:(NSError *)error withModel:(SBModel *)model;


@end
