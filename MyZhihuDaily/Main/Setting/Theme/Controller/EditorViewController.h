//
//  EditorViewController.h
//  zhihuDaily
//
//  Created by niceDay on 15/9/8.
//  Copyright (c) 2015年 computer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "EditorModel.h"

@interface EditorViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}

@property (nonatomic,strong) NSArray *editorModelArray;

@end
