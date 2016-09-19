//
//  ZDHomeTableViewCell.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/18.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDHomeTableViewCell.h"
#import "ZDHomeStoryItem.h"
static const CGFloat kZDHomeTableViewCellHeight = 90;

static const CGFloat kZDHomeImageHeight = 60;
static const CGFloat kZDHomeImageWidth = 75;

@interface ZDHomeTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *contentImage;

@end
@implementation ZDHomeTableViewCell

+ (CGFloat)tableView:(UITableView *)tableView variantRowHeightForItem:(SBTableViewItem *)item AtIndex:(NSIndexPath *)indexPath {
    return kZDHomeTableViewCellHeight;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentImage];
    }
    return self;
}


- (void)setItem:(ZDHomeStoryItem *)item {
    self.titleLabel.text = item.title;
    [self.contentImage sd_setImageWithURL:[NSURL URLWithString:item.images[0]]];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentImage.mas_left).offset(-25);
    }];
    
    [self.contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kZDHomeImageWidth, kZDHomeImageHeight));
        make.right.equalTo(self.contentView).offset(-25);
        make.centerY.equalTo(self.contentView);
    }];
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor hx_colorWithHexRGBAString:kZDHomeCellDefaultColor];
    }
    return _titleLabel;
}

- (UIImageView *)contentImage {
    if (!_contentImage) {
        _contentImage = [[UIImageView alloc] init];
    }
    return _contentImage;
}



@end
