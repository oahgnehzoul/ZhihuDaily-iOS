//
//  ZDLeftBackView.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/18.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDLeftBackView.h"

@interface ZDLeftBackView ()
@property (nonatomic, strong) UIImageView *touchView;


@end

@implementation ZDLeftBackView
// 遍历 subView寻找 hitView 方法
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    if (self.touchPointBlock) {
//        self.touchPointBlock(point);
//    }
    if ([self pointInside:point withEvent:event]) {
        [self addSubview:self.touchView];
        self.touchView.center = point;
        
        [self.touchView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
    }
    
    return [super hitTest:point withEvent:event];
}

// 响应者才会调用
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

- (UIImageView *)touchView {
    if (!_touchView) {
        _touchView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        _touchView.image = [UIImage imageNamed:@"Field_Button_Highlight_Bg"];
        _touchView.alpha = 0.5;
    }
    return _touchView;
}





@end
