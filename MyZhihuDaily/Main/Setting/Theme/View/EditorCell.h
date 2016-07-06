//
//  EditorCell.h
//  zhihuDaily
//
//  Created by niceDay on 15/9/8.
//  Copyright (c) 2015年 computer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditorModel.h"

@interface EditorCell : UITableViewCell
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *detailLabel;
@property (strong, nonatomic) UIImageView *editorImageView;

@property (nonatomic, strong) EditorModel *model;
@end
