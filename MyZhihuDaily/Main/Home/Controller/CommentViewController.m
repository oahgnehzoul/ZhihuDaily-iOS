//
//  CommentViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/11.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentTableView.h"
#import "DataService.h"
#import "CommentModel.h"
@interface CommentViewController ()
{
    CommentTableView *_tableView;
    NSMutableArray *commentDicArray;
}
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"点评页面";
    self.title = [NSString stringWithFormat:@"%@条点评",self.commentNum];
    self.navigationController.navigationBar.translucent = YES;
    [self _createTableView];
    [self _loadCommentData];
    [self _createBottomView];
}

//底部视图
- (void)_createBottomView {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, KHeight-40, KWidth, 40)];
    bottomView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Dark_Comment_Bottom_Bg@2x.png"]];
    [self.view addSubview:bottomView];
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"Dark_Comment_Icon_Back@2x.png"] forState:UIControlStateNormal];
    backBtn.tag = 0;
    [backBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:backBtn];
//    /Users/oahgnehzoul/Desktop/MyZhihuDaily/MyZhihuDaily/images/Comment_Icon_Compose@2x.png
    UIButton *commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(KWidth/2-50, 0, 100, 40)];
    [commentBtn setImage:[UIImage imageNamed:@"Comment_Icon_Compose@2x.png"] forState:UIControlStateNormal];
    [commentBtn setTitle:@"写点评" forState:UIControlStateNormal];
    [commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commentBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    commentBtn.tag = 1;
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [bottomView addSubview:commentBtn];
}
- (void)_createTableView {
//    _tableView = [[CommentTableView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight-40)] ;
    _tableView = [[CommentTableView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight-40) style:UITableViewStyleGrouped];
    _tableView.sectionFooterHeight = 0;
    _tableView.sectionHeaderHeight = 0;
    [self.view addSubview:_tableView];
}

- (void)_loadCommentData {
    //获取长评论
    commentDicArray = [[NSMutableArray alloc] init];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@/%@",Comment,self.newsId,@"long-comments"];
    [DataService requestAFUrl:urlStr httpMethod:@"GET" params:nil data:nil block:^(id result) {
//        NSLog(@"%@",result);
        
        NSArray *commentArray = result[@"comments"];
        NSMutableArray *longArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in commentArray) {
            CommentModel *model = [[CommentModel alloc] init];
            model.author = [dic objectForKey:@"author"];
            model.content = dic[@"content"];
            model.avatar = dic[@"avatar"];
            model.time = dic[@"time"];
            model.likes = dic[@"likes"];
            [longArray addObject:model];
        }
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        NSString  *count = [NSString stringWithFormat:@"%ld",(unsigned long)commentArray.count];
        [dic setValue:longArray forKey:@"array"];
        [dic setValue:count forKey:@"count"];
        
        [commentDicArray addObject:dic];
    }];
    //获取短评论
    NSString *shortStr = [NSString stringWithFormat:@"%@%@/%@",Comment,self.newsId,@"short-comments"];
    [DataService requestAFUrl:shortStr httpMethod:@"GET" params:nil data:nil block:^(id result) {
//        NSLog(@"%@",result);
        NSArray *commentArray = result[@"comments"];
        NSMutableArray *shortArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in commentArray) {
            CommentModel *model = [[CommentModel alloc] init];
            model.author = [dic objectForKey:@"author"];
            model.content = dic[@"content"];
            model.avatar = dic[@"avatar"];
            model.time = dic[@"time"];
            model.likes = dic[@"likes"];
            [shortArray addObject:model];
        }
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        NSString  *count = [NSString stringWithFormat:@"%lu",(unsigned long)commentArray.count];
        [dic setValue:shortArray forKey:@"array"];
        [dic setValue:count forKey:@"count"];
        
        [commentDicArray addObject:dic];
        
        _tableView.commentDicArray = commentDicArray;
        [_tableView reloadData];
    }];
}

- (void)btnAction:(UIButton *)btn {
    if (btn.tag == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (btn.tag == 1) {
        NSLog(@"写点评");
    }
}


@end
