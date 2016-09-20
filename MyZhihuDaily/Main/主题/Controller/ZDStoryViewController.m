//
//  ZDStoryViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/20.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDStoryViewController.h"
#import "ZDStoryBottomBar.h"
#import "ZDStoryModel.h"
@interface ZDStoryViewController ()

@property (nonatomic, strong) ZDStoryBottomBar *bottomBar;
@property (nonatomic, strong) ZDStoryModel *model;
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation ZDStoryViewController

- (id)initWithStoryId:(NSString *)storyId {
    if (self = [super init]) {
        
    }
    return self;
}

- (id)initWithRouterParams:(NSDictionary *)params {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blueColor];
    self.bottomBar = [[[NSBundle mainBundle] loadNibNamed:@"ZDStoryBottomBar" owner:self options:nil] lastObject];
    [self.view addSubview:self.bottomBar];
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
}

- (ZDStoryModel *)model {
    if (!_model) {
        _model = [[ZDStoryModel alloc] init];
    }
    return _model;
}

@end
