//
//  SBViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "SBViewController.h"
#import <libkern/OSAtomic.h>

@interface SBViewController ()
{
    OSSpinLock _lock;
}
@end

@implementation SBViewController

- (instancetype)init {
    if (self = [super init]) {
        _modelDictionary = @{}.mutableCopy;
        _lock = OS_SPINLOCK_INIT;
        NSLog(@"%@ init",[self class]);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"SBViewController viewDidLoad");
}

- (void)dealloc {
    NSLog(@"[%@-->dealloc]",[self class]);
}

- (void)registerModel:(SBModel *)model {
//    NSAssert(model.k, <#desc, ...#>)
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
