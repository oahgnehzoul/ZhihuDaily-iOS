//
//  HomeHeaderView.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/6.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeHeaderView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSArray *storyModelArray;
@end
