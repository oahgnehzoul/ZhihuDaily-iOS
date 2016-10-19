//
//  UIViewController+ZDDealloc.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/10/19.
//  Copyright © 2016年 oahzol. All rights reserved.
//

#import "UIViewController+ZDDealloc.h"

@implementation UIViewController (ZDDealloc)
+ (void)load {
    Method originalDealloc = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
    Method swizzledDealloc = class_getInstanceMethod(self, @selector(zd_dealloc));
    
    method_exchangeImplementations(originalDealloc, swizzledDealloc);
}

- (void)zd_dealloc {
    NSLog(@"[%@ -->dealloc]",self.class);
    [self zd_dealloc];
}
@end
