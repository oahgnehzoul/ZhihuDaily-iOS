//
//  ProfileViewController.h
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/8/27.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "BaseViewController.h"

@interface ProfileViewController : BaseViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UIImageView *iconImageView;

@property (nonatomic,strong) UIButton *iconBtn;
@property (nonatomic,strong) UITextField *nameTextField;
@property (nonatomic,strong) UILabel *nameLabel;

@end
