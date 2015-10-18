//
//  DetailViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/7.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "DetailViewController.h"
#import "DataService.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "CommentViewController.h"
#import "BaseNavController.h"
#import "MJRefresh.h"
#import "storyModel.h"
#import "UMSocial.h"
@interface DetailViewController ()
{
    UIView *_topView;
    UIImageView *_imgView;
    UIWebView *_webView;
    UIView *_bottomBar;
    UIImage *_image;
    UILabel *_titleLabel;
    UILabel *_sourceLabel;
    UIButton *_recomBtn;
   
    UILabel *btnLabel1;
    UILabel *btnLabel2;
    BOOL isLiked;
}
@end
@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setRootNavItem];

    
   
//    [self _loadWebView];
    [self _createSubViews];
    [self _createBottomBar];
     [self LoadBottomData];
    [self _loadView];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}



//- (void)_loadWebView {
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight-49)];
//    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
//    [self.view addSubview:webView];
//    [webView loadRequest:request];
//}

- (void)_createSubViews {
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight/2)];
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight/2-80)];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, KHeight/2-120-20, KWidth-40, 50)];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.textColor = [UIColor whiteColor];
    
    _sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth-140, KHeight/2-15-60-20, 130, 10)];
    _sourceLabel.font = [UIFont systemFontOfSize:9];
    _sourceLabel.textColor = [UIColor whiteColor];
    [_imgView addSubview:_titleLabel];
    [_imgView addSubview:_sourceLabel];
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, KHeight/2-60, KWidth, 60)];
    centerView.backgroundColor = [UIColor redColor];
    UILabel *recommender = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 40)];
    recommender.font = [UIFont systemFontOfSize:13];
    recommender.text = @"推荐者";
    _recomBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 10, 40, 40)];
    [_recomBtn setBackgroundImage:_image forState:UIControlStateNormal];
    [centerView addSubview:recommender];
    [centerView addSubview:_recomBtn];
//    [_topView addSubview:centerView]; //加的view 位置不对,待修改
    [_topView addSubview:_imgView];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight)];
    _webView.backgroundColor = [UIColor whiteColor];
//    _webView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_webView];
    self.view.backgroundColor = [UIColor whiteColor];
    [_webView.scrollView addSubview:_topView];
    //添加 左滑手势
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe)]; swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [_webView addGestureRecognizer:swipeGesture];
    
    
    MJRefreshNormalHeader* header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    
    [header setTitle:@"载入上一篇" forState:MJRefreshStateRefreshing];
    [header setTitle:@"载入上一篇" forState:MJRefreshStateIdle];
    [header setTitle:@"载入上一篇" forState:MJRefreshStatePulling];
    _webView.scrollView.header = header;
    MJRefreshAutoNormalFooter* footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    [footer setTitle:@"载入下一篇" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"载入下一篇" forState:MJRefreshStateIdle];
    [footer setTitle:@"载入下一篇" forState:MJRefreshStatePulling];
    _webView.scrollView.footer = footer;

}

- (void)headRefresh{
//    if (self.index >0) {
//        self.index -= 1;
//        storyModel *model = self.dataArray[self.index];
//        self.newsId = model.idStr;
////        [self viewDidLoad];
//        
//    }
    if (self.index > 0) {
        self.index --;
        self.newsId = self.newsIdArray[self.index];
        [self _loadView];
        [self LoadBottomData];

    }
    [_webView.scrollView.header endRefreshing];
    
}


- (void)footRefresh{
    if (self.index < self.newsIdArray.count-1) {
        self.index ++;
//        storyModel *model = self.dataArray[self.index];
        self.newsId = self.newsIdArray[self.index];
//        [self viewDidLoad];
        [self _loadView];
        [self LoadBottomData];
    }
    [_webView.scrollView.footer endRefreshing];
    
}
- (void)swipe{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)_loadView {

    NSString *urlStr = [NSString stringWithFormat:@"%@%@",Detail,self.newsId];
    [DataService requestAFUrl:urlStr httpMethod:@"GET" params:nil data:nil block:^(id result) {
//#warning 要修改，theme Detail 并没有头视图
        [_imgView sd_setImageWithURL:[NSURL URLWithString:result[@"image"]]];
        NSArray *reArray = [result objectForKey:@"recommenders"];
        NSDictionary *dic = reArray[0];
        NSURL *url = [NSURL URLWithString:dic[@"avatar"]];
        [_recomBtn sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
        if (result[@"image"]) {
            _titleLabel.text = result[@"title"];
            _sourceLabel.text = [NSString stringWithFormat:@"图片:%@",result[@"image_source"]] ;
        }
        
        NSString *body = result[@"body"];
//        NSLog(@"%@",body);
        NSString *cssUrl = result[@"css"][0];
        NSString *linkString = [NSString stringWithFormat:@"<link rel=\"Stylesheet\" type=\"text/css\" href=\"%@\" />", cssUrl];
        NSString *htmlString = [NSString stringWithFormat:@"%@%@", linkString, body];
        [_webView loadHTMLString:htmlString baseURL:nil];
        
    }];
}
- (void)_createBottomBar{
    
    _bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, KHeight-49, KWidth, 49)];
    _bottomBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomBar];
    
    _bottomBar.layer.shadowColor = [UIColor grayColor].CGColor;
    _bottomBar.layer.shadowOffset = CGSizeMake(0, 2);
    _bottomBar.layer.shadowOpacity = 1;
    NSArray *imageName = @[@"News_Navigation_Arrow@2x",@"News_Navigation_Next@2x",@"News_Navigation_Vote@2x",@"News_Navigation_Share_Highlight@2x",@"News_Navigation_Comment@2x"];
    
    
    for (int i = 0; i < 5; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*KWidth/5, 0, KWidth/5, 49)];
        button.tag = i;
        UIImage *bgImage = [UIImage imageNamed:imageName[i]];
        [button setImage:bgImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btnLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(KWidth/5*3-27, 11, 30, 10)];
        btnLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(KWidth-33, 11, 21, 10)];
        if (button.tag == 2) {
            [button addSubview:btnLabel1];
            btnLabel1.text = self.populatity;
//            btnLabel1.font = [UIFont systemFontOfSize:5];
//            btnLabel1.backgroundColor = [UIColor redColor];
            btnLabel1.textColor = [UIColor grayColor];
            btnLabel1.textAlignment = NSTextAlignmentCenter;
        }else if (button.tag == 4) {
            [button addSubview:btnLabel2];
            btnLabel2.text = self.comments;
            btnLabel2.font = [UIFont systemFontOfSize:8];
//            btnLabel2.backgroundColor = [UIColor blueColor];
            btnLabel2.textColor = [UIColor whiteColor];
            btnLabel2.textAlignment = NSTextAlignmentCenter;
        }
        btnLabel1.font = [UIFont systemFontOfSize:8];
        [_bottomBar addSubview:button];
        [_bottomBar addSubview:btnLabel1];
        [_bottomBar addSubview:btnLabel2];
    }
    
}


- (void)btnAction:(UIButton *)btn{
    if (btn.tag == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (btn.tag == 3) {
        NSLog(@"分享按钮");
        [UMSocialSnsService presentSnsIconSheetView:self appKey:UMAPPKEY shareText:@"bonjour" shareImage:[UIImage imageNamed:@"Menu_Icon_Collect.png"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatTimeline,UMShareToWechatSession, nil] delegate:self];
//        [UMSocialSnsService presentSnsController:self appKey:UMAPPKEY shareText:@"hzl" shareImage:[UIImage imageNamed:@"AppIcon29x29@3x.png"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,UMShareToQzone,UMShareToEmail,UMShareToSms, nil] delegate:self];
    }else if (btn.tag == 4) {
        NSLog(@"进入点评页面");
        CommentViewController *vc = [[CommentViewController alloc] init];
        vc.newsId = self.newsId;
        vc.commentNum = self.comments;
        BaseNavController *nav = [[BaseNavController alloc] initWithRootViewController:vc];
        
        [self presentViewController:nav animated:YES completion:nil];
    }else if (btn.tag == 2) {
       
        isLiked = !isLiked;
        if (isLiked) {
            btnLabel1.text = [NSString stringWithFormat:@"%ld",self.populatity.integerValue+1];
             NSLog(@"点赞");
        }else {
            btnLabel1.text = self.populatity;
            NSLog(@"取消点赞");
        }
    }else if (btn.tag == 1) {
        NSLog(@"下一个新闻");
        if (self.index < self.newsIdArray.count-1) {
            self.index+=1;
            self.newsId = self.newsIdArray[self.index];
            [self _loadView];
            [self LoadBottomData];
            
        }
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return  UIStatusBarStyleLightContent;

}
- (void)LoadBottomData {
    //在点赞按钮上 显示点赞数目 评论按钮上显示评论数
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",Story_extra,self.newsId];

            [DataService requestAFUrl:urlStr httpMethod:@"GET" params:nil data:nil block:^(id result) {
                self.populatity = [result[@"popularity"] stringValue];;
                self.comments = [result[@"comments"] stringValue];

                btnLabel1.text = self.populatity;
                btnLabel2.text = self.comments;
//                NSLog(@"111  %@",self.populatity);
//                NSLog(@"222  %@",btnLabel1.text);
            
            }];
}


@end
