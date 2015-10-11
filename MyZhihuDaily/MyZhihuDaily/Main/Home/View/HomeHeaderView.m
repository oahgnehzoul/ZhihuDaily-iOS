//
//  HomeHeaderView.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/6.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "HomeHeaderView.h"
#import "UIImageView+WebCache.h"
#import "HomeHeaderViewCell.h"
#import "storyModel.h"
#import "DetailViewController.h"
#import "HomeViewController.h"

@implementation HomeHeaderView
{
    UIImageView *_imgView;
}


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self _createHeaderView];
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)_createHeaderView {
    self.dataSource = self;
    self.delegate = self;
//    NSLog(@"%f",self.frame.size.height);
    [self registerClass:[HomeHeaderViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (void)setStoryModelArray:(NSArray *)storyModelArray {
    _storyModelArray = storyModelArray;
    [self reloadData];
}

#pragma mark - UICollectionViewDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.storyModelArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeHeaderViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.storyModelArray[indexPath.row];
    cell.pageControl.currentPage = indexPath.row;
//#warning 加了颜色
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
#pragma mark - UICollectionViewDelegate 
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeViewController *homeVC = (HomeViewController *)self.nextResponder.nextResponder.nextResponder;
    
    DetailViewController *vc = [[DetailViewController alloc] init];
    storyModel *model = self.storyModelArray[indexPath.row];
    vc.newsId = model.idStr;
    [homeVC presentViewController:vc animated:YES completion:nil];
}
@end
