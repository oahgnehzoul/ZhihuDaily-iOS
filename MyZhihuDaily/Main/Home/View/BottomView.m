//
//  BottomView.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/5.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)loadBtn:(id)sender {
    NSLog(@"下载数据");
}
- (void)awakeFromNib {
   
//    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Dark_News_Text_bg@2x.png"]];
}
//Dark_News_Text_bg@2x
- (IBAction)themeBtn:(id)sender {
    NSLog(@"主题按钮");
    self.isDark = !self.isDark;
    if (self.isDark) {
        self.themeImage.image = [UIImage imageNamed:@"Menu_Day.png"];
        self.themeLabel.text = @"白天";
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Dark_News_Text_bg@2x.png"]];
        self.themeLabel.textColor = [UIColor whiteColor];
        self.loadLabel.textColor = [UIColor whiteColor];
    }else {
        self.themeImage.image = [UIImage imageNamed:@"Menu_Dark.png"];
        self.themeLabel.text = @"夜间";
        self.themeLabel.textColor = [UIColor blackColor];
        self.loadLabel.textColor = [UIColor blackColor];
//        self.backgroundColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNofication object:nil];
}

@end
