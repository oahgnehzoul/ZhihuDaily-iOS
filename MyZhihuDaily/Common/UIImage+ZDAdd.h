//
//  UIImage+ZDBlur.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/27.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZDAdd)

- (UIImage *)getBlurImageWith:(CGFloat)blurLevel;

- (UIImage *)cirleImage;

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius;

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius corners:(UIRectCorner)corners borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor borderLineJoin:(CGLineJoin)borderLineJoin;

@end
