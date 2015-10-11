//
//  CommentTableViewCell.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/11.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _createContentView];
    }
    return self;
}

- (void)_createContentView {
    _iconImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _favBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_iconImgView];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_favBtn];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_contentLabel];
}
- (void)setModel:(CommentModel *)model {
    _model = model;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSURL *url = [NSURL URLWithString:self.model.avatar];
    [_iconImgView sd_setImageWithURL:url];
    _iconImgView.frame = CGRectMake(10, 10, 40, 40);
    _iconImgView.layer.cornerRadius = 20;
    _iconImgView.layer.masksToBounds = YES;
    
    _nameLabel.frame = CGRectMake(60, 10, 180, 20);
    _nameLabel.text = self.model.author;
//    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.font = [UIFont boldSystemFontOfSize:14];
    
    _favBtn.frame = CGRectMake(KWidth-50, 10, 40, 20);
//    _favBtn.backgroundColor = [UIColor yellowColor];
    _favBtn.titleLabel.text = self.model.likes.stringValue;
    _favBtn.titleLabel.textColor = [UIColor blackColor];
    UIImage *image = [UIImage imageNamed:@"Comment_Vote@2x.png"];
    [_favBtn setImage:image forState:UIControlStateNormal];
//    _favBtn.imageView.image = [UIImage imageNamed:@"Comment_Vote@2x.png"];
//    UILabel *label = [[UILabel alloc] init];
//    label.text = self.model.likes.stringValue;
    [_favBtn setTitle:self.model.likes.stringValue forState:UIControlStateNormal];
    [_favBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _favBtn.titleLabel.font = [UIFont systemFontOfSize:13];

    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};

    _contentLabel.text = self.model.content;
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:14];
    
    CGSize size = [self.model.content boundingRectWithSize:CGSizeMake(KWidth-80, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    _contentLabel.frame = CGRectMake(60, 30, KWidth-80, size.height+60);
//    _contentLabel.backgroundColor = [UIColor yellowColor];
    _timeLabel.frame = CGRectMake(60, size.height+90, 100, 15);
    _timeLabel.textColor = [UIColor lightGrayColor];
    
    NSString *str = self.model.time.stringValue;
    NSTimeInterval time = [str doubleValue] ;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
//    NSString *currentStr = [formatter stringFromDate:date];
    _timeLabel.text = [formatter stringFromDate:date];
    _timeLabel.font = [UIFont systemFontOfSize:12];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
