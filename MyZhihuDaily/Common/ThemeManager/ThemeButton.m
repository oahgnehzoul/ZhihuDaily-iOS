//
//  ThemeButton.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/8/27.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"

@implementation ThemeButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeAction:) name:kThemeDidChangeNofication object:nil];
    }
    return self;

}
- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeAction:) name:kThemeDidChangeNofication object:nil];
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNofication object:nil];
}
- (void)themeDidChangeAction:(NSNotification *)notification {
    
    [self loadImage];
}

- (void)setNomalImageName:(NSString *)nomalImageName {
    if (![self.nomalImageName isEqualToString:nomalImageName]) {
        _nomalImageName = [nomalImageName copy];
        [self loadImage];
    }
}

- (void)loadImage {
    ThemeManager *manger  = [ThemeManager shareInstance];
    UIImage *normalImage = [manger getThemeImage:self.nomalImageName];
   
    if (normalImage != nil) {
        [self setImage:normalImage forState:UIControlStateNormal];
    }
    
}


@end
