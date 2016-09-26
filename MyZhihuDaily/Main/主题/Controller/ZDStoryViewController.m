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
#import "ZDHomeHeaderView.h"
#import "ZDStoryItem.h"
#import "ZDHomeStoryItem.h"
#import "ZDHeaderCollectionViewCell.h"
#import "ZDRootViewController.h"
#import "ZDStoryView.h"
@interface ZDStoryViewController ()<ZDStoryViewDelegate>

@property (strong, nonatomic) IBOutlet ZDStoryBottomBar *bottomBar;
@property (nonatomic, strong) ZDStoryModel *model;
@property (nonatomic, strong) ZDStoryView *containView;
@property (nonatomic, assign) BOOL isFromHome;
@end

@implementation ZDStoryViewController

- (id)initWithStoryId:(NSString *)storyId{
    if (self = [super init]) {
        self.model.storyId = storyId;
    }
    return self;
}

- (id)initWithRouterParams:(NSDictionary *)params {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    ZDRootViewController *root = (ZDRootViewController *)window.rootViewController;
    [root setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}

- (void)dealloc {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    ZDRootViewController *root = (ZDRootViewController *)window.rootViewController;
    [root setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];

}
- (IBAction)bottomBarClicked:(id)sender {
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case 1:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 2:
            [self getNextStoryPage];
            break;
        case 3:
            NSLog(@"点赞");
            break;
        case 4:
            NSLog(@"分享");
            break;
        case 5:
            NSLog(@"讨论");
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFromHome = (self.homeVc != nil);

    self.bottomBar = [[[NSBundle mainBundle] loadNibNamed:@"ZDStoryBottomBar" owner:self options:nil] lastObject];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomBar];
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];

    self.containView.isGray = !self.isFromHome;
    self.containView = [[ZDStoryView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 44)];
    self.containView.delegate = self;
    [self.view addSubview:self.containView];
    
    @weakify(self);
    [self.model loadWithCompletion:^(SBModel *model, NSError *error) {
        @strongify(self);
        ZDStoryItem *item = model.itemList.array[0];
        [self.containView setItem:item];
    }];

}


- (void)getPreviousStoryPage {
    NSString *str = nil;
    if (self.homeVc) {
        str = [self.homeVc getPreviousStoryIdWithCurrentId:self.model.storyId];
    } else {
        str = [self.themeVc getPreviousStoryIdWithCurrentId:self.model.storyId];
    }
    if (str) {
        self.model.storyId = str;
        @weakify(self);
        [self.model loadWithCompletion:^(SBModel *model, NSError *error) {
            @strongify(self);
            ZDStoryView *previous = [[ZDStoryView alloc] initWithFrame:CGRectMake(0, -kMainScreenHeight, kMainScreenWidth, kMainScreenHeight - 44)];
            previous.isGray = !self.isFromHome;
            previous.delegate = self;
            [previous setItem:model.itemList.array[0]];
            [self.view addSubview:previous];
            ZDStoryView *containView = self.containView;
            [self.view insertSubview:previous belowSubview:self.bottomBar];
            [UIView animateWithDuration:0.45 animations:^{
                previous.top = 0;
                containView.top = kMainScreenHeight;
            } completion:^(BOOL finished) {
                [containView removeFromSuperview];
                self.containView = previous;
            }];
        }];
    } else {
        self.containView.isFirst = YES;
    }
    
}

- (void)getNextStoryPage {
    NSString *str = nil;
    if (self.homeVc) {
        str = [self.homeVc getNextStoryIdWithCurrentId:self.model.storyId];
    } else {
        str = [self.themeVc getNextStoryIdWithCurrentId:self.model.storyId];
    }

    if (str) {
        self.model.storyId = str;
        @weakify(self);
        [self.model loadWithCompletion:^(SBModel *model, NSError *error) {
            @strongify(self);
            ZDStoryView *next = [[ZDStoryView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight - 44, kMainScreenWidth, kMainScreenHeight - 44)];
            next.isGray = !self.isFromHome;
            next.delegate = self;
            if ([model.itemList count]) {
                [next setItem:model.itemList.array[0]];
            }
            [self.view addSubview:next];
            ZDStoryView *containView = self.containView;
            self.containView.isFirst = NO;
            [self.view insertSubview:next belowSubview:self.bottomBar];
            [UIView animateWithDuration:0.45 animations:^{
                next.top = 0;
                containView.top = -kMainScreenHeight;
            } completion:^(BOOL finished) {
                [containView removeFromSuperview];
                self.containView = next;
                if (self.isStatusBarStyleDefault) {
                    self.isStatusBarStyleDefault = NO;
                    [self setNeedsStatusBarAppearanceUpdate];
                }
            }];
        }];
    }
}



- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.isStatusBarStyleDefault ? UIStatusBarStyleDefault: UIStatusBarStyleLightContent;
}

- (ZDStoryModel *)model {
    if (!_model) {
        _model = [[ZDStoryModel alloc] init];
    }
    return _model;
}

@end
