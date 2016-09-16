//
//  SBListModel.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "SBModel.h"
/**
 *  列表model的翻页模式
 */
typedef NS_OPTIONS(NSUInteger, SBModelPageMode) {
    /**
     *  有数据回来就自动翻页，否则停止翻页
     */
    SBModelPageDefault        = 0,
    /**
     *  没有数据回来 或者 有数据回来且数量小于pagesize，则停止翻页
     *  有数据回来，且数量等于pagesize，则自动翻页
     */
    SBModelPageReturnCount    = 1,
    /**
     *  翻页依据自定义的totalCount，不依赖pagesize
     */
    SBModelPageCustomize      = 2
};
@interface SBListModel : SBModel

@property (nonatomic, readonly) BOOL hasMore;
@property (nonatomic, assign) SBModelPageMode pageMode;
@property (nonatomic, assign) NSUInteger currentPageIndex;
@property (nonatomic, assign) NSUInteger totalCount;
@property (nonatomic, assign) NSUInteger pageSize;
@property (nonatomic, assign) NSUInteger sectionNubmer;

@end
