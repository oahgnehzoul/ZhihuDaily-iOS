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
//加上首尾两项
@property (nonatomic, strong) NSMutableArray *sourceItems;

@property (nonatomic, strong) NSTimer *timer;
@end
@implementation ZDHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
        self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.collectionView.scrollsToTop = NO;
        [self addSubview:self.pageControl];
        [self bringSubviewToFront:self.pageControl];
        self.backgroundColor = [UIColor clearColor];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self);
        }];

    }
    return self;
}

- (void)setItems:(NSArray *)items {
    _items = items;
    NSInteger count = _items.count;
    self.sourceItems = @[].mutableCopy;
    [self.sourceItems addObject:_items[count - 1]];
    [self.sourceItems addObjectsFromArray:_items];
    [self.sourceItems addObject:_items[0]];

    [self.collectionView reloadData];
    self.pageControl.numberOfPages = items.count;

    //  5 1 2 3 4 5 1
    // 滚到1
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    [self setPageIndex:indexPath];
    
    @weakify(self);
    if (_timer == nil) {
        _timer = [NSTimer bk_scheduledTimerWithTimeInterval:5 block:^(NSTimer *timer) {
            @strongify(self);
            [self collectionViewScroll];
        } repeats:YES];
    }
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)dealloc {
    
    NSLog(@"[%@-->dealloc]",self.class);
    [self.timer invalidate];
    self.timer = nil;
}

- (void)collectionViewScroll {
    CGPoint point = self.collectionView.contentOffset;
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    NSIndexPath *newPath = [NSIndexPath indexPathForItem:indexPath.row + 1 inSection:indexPath.section];
    [self setPageIndex:newPath];
}

#pragma mark - UICollectionDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sourceItems.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZDHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setItem:self.sourceItems[indexPath.row]];
    return cell;
}
#pragma mark - UICollectionDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZDHomeStoryItem *item = self.sourceItems[indexPath.row];
    if (self.touchBlock) {
        self.touchBlock(item.storyId);
    }
}

#pragma mark - uicollectionflowlayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 边界处理，
    CGFloat contentOffset = self.collectionView.frame.size.width * (self.sourceItems.count - 1);
    //1.当滚动到最后一张，即返回数据的第一张,让 scrollview 滚动到实际的第二张\
      2.滚到第一张， 返回数据的第五张,让 scrollview 滚到实际的倒数第二张
    if (scrollView.contentOffset.x == contentOffset) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    } else if(scrollView.contentOffset.x == 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.sourceItems.count - 2) inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
}



- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSIndexPath *indexPath = [_collectionView indexPathForItemAtPoint:*targetContentOffset];
    [self setPageIndex:indexPath];
}

//   加入 count 为  5  加上之后 变成  7
//  indexPath.row   0  1  2  3  4  5  6
//  currentPage     4  0  1  2  3  4  0

- (void)setPageIndex:(NSIndexPath *)indexPath {
    NSInteger count = self.sourceItems.count;
    if (indexPath.row == (count - 1)) {
        _pageControl.currentPage = 0;
    } else if (indexPath.row == 0) {
        _pageControl.currentPage = count - 3;
    } else {
        _pageControl.currentPage = indexPath.row - 1;
    }
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
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
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [_collectionView registerClass:[ZDHeaderCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    }
    return _collectionView;
}
//// !!!collectionView 的UI是从 collectionViewLayout 获取，需要强制更新。
- (void)setFrame:(CGRect)frame {
    if (self.height != frame.size.height) {
        //!!
        [self.collectionView.collectionViewLayout invalidateLayout];
    }
    [super setFrame:frame];
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPageIndicatorTintColor = [UIColor hx_colorWithHexRGBAString:@"#ffffff"];
        _pageControl.pageIndicatorTintColor = [UIColor hx_colorWithHexRGBAString:@"#ffffff" alpha:0.5];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _pageControl;
}


@end
