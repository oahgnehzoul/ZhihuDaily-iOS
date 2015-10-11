//
//  HomeTableView.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/9/7.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableView : UITableView<UITableViewDataSource,UITableViewDelegate>


//@property (nonatomic,strong) NSArray *storyModelArray;


//@property (nonatomic,strong) NSArray *dateArray;

//@property (nonatomic,strong) NSDictionary *dataDic;
@property (nonatomic,strong) NSArray *dataDicArray;

@property (nonatomic,assign) BOOL isNight;
@end
