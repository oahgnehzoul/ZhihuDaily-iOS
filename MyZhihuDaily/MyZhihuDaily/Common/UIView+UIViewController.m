//
//  UIView+UIViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/9.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "UIView+UIViewController.h"

@implementation UIView (UIViewController)

- (UIViewController *)viewController {
    UIResponder *next = self.nextResponder;
    while (next) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }else {
            next = next.nextResponder;
        }
    }
    return nil;
}

@end
