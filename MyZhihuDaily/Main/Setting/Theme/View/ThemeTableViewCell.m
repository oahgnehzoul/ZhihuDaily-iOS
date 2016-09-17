//
//  ThemeTableViewCell.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/7.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "ThemeTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ThemeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _createSubViews];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _createSubViews];
    }
    return self;
}


- (void)_createSubViews {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.numberOfLines = 0;
//    _titleLabel.textColor =
  
    _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_imgView];
}

- (void)setModel:(ThemeModel *)model {
    _model = model;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.model.images == nil) {
        self.textLabel.frame = CGRectMake(20, 10, kMainScreenWidth-40, 60);
        self.textLabel.numberOfLines = 0;
//        self.textLabel.font = [UIFont fontWithName:@"Helvetica-Blod" size:14];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }else {
        self.textLabel.frame = CGRectMake(20, 10, kMainScreenWidth-140, 60);
        self.textLabel.numberOfLines = 0;
        self.textLabel.font = [UIFont systemFontOfSize:16];
        self.imgView.frame = CGRectMake(kMainScreenWidth-95, 10, 80, 60);
        NSURL *url = [NSURL URLWithString:self.model.images[0]];
        [self.imgView sd_setImageWithURL:url];
    }
    self.textLabel.text = self.model.title;
//    self.textLabel.font = [UIFont systemFontOfSize:14];
//    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
    self.titleLabel.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
