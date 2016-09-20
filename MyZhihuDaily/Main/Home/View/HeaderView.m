//
//  HeaderView.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/5.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "HeaderView.h"
#import "MainViewController.h"
#import "AppDelegate.h"
@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    self.iconImageView.image = [UIImage imageNamed:@"IMG_1779.jpg"];
    self.iconImageView.layer.cornerRadius = 22.5;
    self.iconImageView.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
//    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Dark_News_Comment_Text_bg@2x.png"]];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modeChangeAction) name:kThemeDidChangeNofication object:nil];
}
- (void)modeChangeAction{
    _isNight = !_isNight;
    if (_isNight) {
        _nameLabel.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Dark_News_Text_bg@2x.png"]];
        _favoLabel.textColor = [UIColor whiteColor];
        _msgLabel.textColor = [UIColor whiteColor];
        _setLabel.textColor = [UIColor whiteColor];
    }
    else{
        _nameLabel.textColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
        _favoLabel.textColor = [UIColor blackColor];
        _msgLabel.textColor = [UIColor blackColor];
        _setLabel.textColor = [UIColor blackColor];
    }
    
}
//- (IBAction)ProfileBtn:(id)sender {
//    NSLog(@"个人页面");
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    MainViewController *vc = delegate.mainVC;
//    UIButton *btn = (UIButton *)sender;
//    vc.selectIndex = btn.tag;
//}
/////Users/oahgnehzoul/Desktop/MyZhihuDaily/MyZhihuDaily/images/Dark_Browser_Navibar@2x.png
//- (IBAction)collectBtn:(id)sender {
//    NSLog(@"收藏页面");
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    MainViewController *vc = delegate.mainVC;
//    UIButton *btn = (UIButton *)sender;
//    vc.selectIndex = btn.tag;
//}
//- (IBAction)MesgBtn:(id)sender {
//    NSLog(@"消息页面");
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    MainViewController *vc = delegate.mainVC;
//    UIButton *btn = (UIButton *)sender;
//    vc.selectIndex = btn.tag;
//}
//- (IBAction)settingBtn:(id)sender {
//    NSLog(@"设置页面");
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    MainViewController *vc = delegate.mainVC;
//    UIButton *btn = (UIButton *)sender;
//    vc.selectIndex = btn.tag;
//}

@end
