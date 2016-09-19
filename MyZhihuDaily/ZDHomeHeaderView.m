//
//  ZDHomeHeaderView.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/18.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDHomeHeaderView.h"
#import "ZDHomeStoryItem.h"
#import "ZDHeaderCollectionViewCell.h"

@interface ZDHomeHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;


@end
@implementation ZDHomeHeaderView

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *view = [super hitTest:point withEvent:event];
//    NSLog(@"%@:%@",[self class],view);
//    return [super hitTest:point withEvent:event];
//}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
        self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.pageControl];
        [self bringSubviewToFront:self.pageControl];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setItems:(NSArray *)items {
    _items = items;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
    }];
    [self.collectionView reloadData];
    self.pageControl.numberOfPages = items.count;
}
#pragma mark - UICollectionDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZDHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setItem:self.items[indexPath.row]];
    return cell;
}
#pragma mark - UICollectionDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
}

#pragma mark - uicollectionflowlayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSIndexPath *indexPath = [_collectionView indexPathForItemAtPoint:*targetContentOffset];
    self.pageControl.currentPage = indexPath.row;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    NSInteger index = [_collectionView]
}



- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0.f;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ZDHeaderCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    }
    return _collectionView;
}
// !!!collectionView 的UI是从 collectionViewLayout 获取，需要强制更新。
- (void)setFrame:(CGRect)frame {
    if (self.height != frame.size.height) {
        [self.collectionView.collectionViewLayout invalidateLayout];
    }
    [super setFrame:frame];
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor hx_colorWithHexRGBAString:@"#ffffff"];
        _pageControl.pageIndicatorTintColor = [UIColor hx_colorWithHexRGBAString:@"#ffffff" alpha:0.5];
        _pageControl.hidesForSinglePage = YES;
    }
    return _pageControl;
}


@end
