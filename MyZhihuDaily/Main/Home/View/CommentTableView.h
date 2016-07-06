//
//  CommentTableView.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/11.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableView : UITableView<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) NSMutableArray *commentDicArray;
@end
