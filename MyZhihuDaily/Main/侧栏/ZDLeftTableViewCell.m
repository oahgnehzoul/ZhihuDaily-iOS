//
//  ZDLeftTableViewCell.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/18.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDLeftTableViewCell.h"
#import "ZDLeftThemeItem.h"
@interface ZDLeftTableViewCell ()

@property (nonatomic, strong) UILabel *themeLabel;
//@property (nonatomic, strong) UILabel *arrow;
//@property (nonatomic, strong) UIButton *plus;
@property (nonatomic, strong) UIButton *subcribeButton;

@property (nonatomic, strong) UIImageView *homeView;

@end
@implementation ZDLeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.themeLabel];
        [self.contentView addSubview:self.subcribeButton];
//        self.selectedBackgroundView.backgroundColor = [UIColor hx_colorWithHexRGBAString:kZDLeftCellSelectedColor];
        
//        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Dark_Account_Cell_1_Highlight"]];
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
//        self.selectedBackgroundView.backgroundColor = [UIColor hx_colorWithHexRGBAString:kZDLeftCellSelectedColor];

//Dark_Account_Cell_2_Highlight@2x.png
        
    }
    return self;
}

- (UIImageView *)homeView {
    if (!_homeView) {
        _homeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Dark_Menu_Icon_Home"]];
    }
    return _homeView;
}

- (UILabel *)themeLabel {
    if (!_themeLabel) {
        _themeLabel = [UILabel new];
        if (_themeLabel.highlighted) {
            _themeLabel.font = [UIFont boldSystemFontOfSize:14];
        } else {
            _themeLabel.font = [UIFont systemFontOfSize:14];
        }
//        _themeLabel.textColor = [UIColor hx_colorWithHexRGBAString:kZDLeftCellLabelDefaultTextColor];
//        _themeLabel.highlightedTextColor = [UIColor hx_colorWithHexRGBAString:kZDLeftCellLabelSelectedTextColor];
        
    }
    return _themeLabel;
}
// Menu_Enter
//Dark_Menu_Enter@2x.png
// Menu_Follow
//Dark_Menu_Follow@2x.png
- (UIButton *)subcribeButton {
    if (!_subcribeButton) {
        _subcribeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_subcribeButton setImage:[UIImage imageNamed:@"Menu_Enter"] forState:UIControlStateDisabled];
//        [_subcribeButton setImage:[UIImage imageNamed:@"Menu_Follow"] forState:UIControlStateNormal];
    }
    return _subcribeButton;
}
//Dark_Menu_Icon_Home@2x.png
- (void)setItem:(ZDLeftThemeItem *)item {
//    self.selected = item.isSelected;
    self.backgroundColor = item.isSelected ? [UIColor hx_colorWithHexRGBAString:kZDLeftCellSelectedColor]:[UIColor clearColor];
    self.themeLabel.text = item.themeName;
    self.subcribeButton.enabled = item.isSubcribed;
    self.themeLabel.textColor = item.isSelected ? [UIColor hx_colorWithHexRGBAString:kZDLeftCellLabelSelectedTextColor]:[UIColor hx_colorWithHexRGBAString:kZDLeftCellLabelDefaultTextColor];
    self.themeLabel.font = item.isSelected ? [UIFont boldSystemFontOfSize:14]:[UIFont systemFontOfSize:14];
    NSString *imageName = item.isSubcribed ? @"Menu_Enter":@"Menu_Follow";
    
    [_subcribeButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
//    [_subcribeButton setImage:[UIImage imageNamed:@"Menu_Enter"] forState:UIControlStateDisabled];
//    [_subcribeButton setImage:[UIImage imageNamed:@"Menu_Follow"] forState:UIControlStateNormal];
    [self.themeLabel sizeToFit];
    if (item.index == 0) {
        [self.contentView addSubview:self.homeView];
        self.homeView.frame = CGRectMake(15, 15, 20, 20);
        self.themeLabel.frame = CGRectMake(self.homeView.right + 10, 15, 0, 0);
        [self.themeLabel sizeToFit];
    } else {
        [self.homeView removeFromSuperview];
        self.themeLabel.left = 15;
    }
    self.themeLabel.centerY = self.contentView.centerY;
    self.subcribeButton.frame = CGRectMake(self.contentView.width - 50, 15, 20, 20);
}

@end
