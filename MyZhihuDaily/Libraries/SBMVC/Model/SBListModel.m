//
//  SBListModel.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "SBListModel.h"
#import "SBItemList.h"
@interface SBListModel ()


@end

@implementation SBListModel
@synthesize hasMore = _hasMore;

- (instancetype)init {
    if (self = [super init]) {
        self.pageSize = 20;
    }
    return self;
}

- (void)reload {
    self.currentPageIndex = 0;
    [super reload];
}

- (void)loadMore {
    if (_hasMore) {
        self.currentPageIndex++;
        [super loadMore];
    }
}


#pragma mark - private

- (BOOL)parse:(id)JSON {
    NSError *error = nil;
    if (![self prepareParseResponse:JSON error:&error] && error) {
        _hasMore = NO;
//        [self requestDidFailWithError:error];
        [self performSelector:@selector(requestDidFailWithError:) withObject:error];
        return NO;
    }
    NSArray *list = [self parseResponse:JSON error:&error];
    if (error) {
//        [self requestDidFailWithError:error];
        [self performSelector:@selector(requestDidFailWithError:) withObject:error];
        return NO;
    } else {
        // add 9.21.by oahgnehzoul
        if (self.clearBeforeAdd) {
            [self.itemList removeAlObjects];
        }
        [self.itemList addObjectsFromArray:list];
    }
    switch (self.pageMode) {
        case SBModelPageDefault:
            _hasMore = list.count > 0;
            break;
        case SBModelPageReturnCount:
            _hasMore = list.count >= self.pageSize;
            break;
        case SBModelPageCustomize:
//            _hasMore = self.pageSize
        default:
            break;
    }
    return YES;
}

@end
