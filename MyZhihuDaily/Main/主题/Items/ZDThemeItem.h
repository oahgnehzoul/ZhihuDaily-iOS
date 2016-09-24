//
//  ZDThemeItem.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/20.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "SBTableViewItem.h"
#import "ZDHomeStoryItem.h"

SB_ARRAY_TYPE(ZDThemeEditorItem)
SB_ARRAY_TYPE(ZDHomeStoryItem)

@interface ZDThemeEditorItem : SBTableViewItem

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *bio;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *name;

@end

@interface ZDThemeItem : SBTableViewItem

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray<ZDThemeEditorItem> *editors;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *background;
@property (nonatomic, copy) NSArray<ZDHomeStoryItem> *stories;
@property (nonatomic, assign) BOOL subscribed;

@end
