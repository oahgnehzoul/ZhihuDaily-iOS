//
//  CommentTableViewCell.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/11.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
@interface CommentTableViewCell : UITableViewCell
{
    UIImageView *_iconImgView;
    UILabel *_nameLabel;
    UIButton *_favBtn;
    UILabel *_contentLabel;
    UILabel *_timeLabel;
}

@property (nonatomic,strong) CommentModel *model;
@end
