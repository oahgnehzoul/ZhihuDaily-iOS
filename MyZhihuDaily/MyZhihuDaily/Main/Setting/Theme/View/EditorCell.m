//
//  EditorCell.m
//  zhihuDaily
//
//  Created by niceDay on 15/9/8.
//  Copyright (c) 2015年 computer. All rights reserved.
//

#import "EditorCell.h"
#import "common.h"
#import "UIImageView+WebCache.h"

@implementation EditorCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self _createSubviews];
        
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _createSubviews];
            }
    return self;
}
- (void)_createSubviews{
    self.backgroundColor = [UIColor clearColor];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLabel];
   
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _detailLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_detailLabel];
    
    _editorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    _editorImageView.contentMode = UIViewContentModeScaleAspectFill;
    _editorImageView.backgroundColor = [UIColor clearColor];
    _editorImageView.layer.cornerRadius = 5;
    _editorImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_editorImageView];
    
}

- (void)setModel:(EditorModel *)model{
    if (model) {
        _model = model;
        [self setNeedsLayout];
    }
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(60, 5, 100, 20);
    self.titleLabel.text = self.model.name;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    
    _detailLabel.frame = CGRectMake(60, 30, 200, 20);
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.font = [UIFont systemFontOfSize:13];
    self.detailLabel.text = _model.bio;
    [self.editorImageView sd_setImageWithURL:[NSURL URLWithString:_model.avatar]];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
