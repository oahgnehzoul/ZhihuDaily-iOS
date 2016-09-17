//
//  ProfileViewController.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/8/27.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "ProfileViewController.h"
#import "DataService.h"
@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRootNavItem];
    // Do any additional setup after loading the view.
    self.title = @"个人主页";
    [self _createSubViews];
}

- (void)_createSubViews {
//    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kMainScreenWidth/2-40), 100, 80, 80)];
//    _iconImageView.image = [UIImage imageNamed:@"IMG_1779.jpg"];
//    _iconImageView.layer.cornerRadius = 40;
//    _iconImageView.layer.masksToBounds = YES;
//    [self.view addSubview:_iconImageView];
    //添加头像
    _iconBtn = [[UIButton alloc] initWithFrame:CGRectMake((kMainScreenWidth/2-40), 100, 80, 80)];
    [_iconBtn setImage:[UIImage imageNamed:@"IMG_1779.jpg"] forState:UIControlStateNormal];
    _iconBtn.layer.cornerRadius = 40;
    _iconBtn.layer.masksToBounds = YES;
    [_iconBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    _iconBtn.tag = 1;
    [self.view addSubview:_iconBtn];
    
    //添加昵称
    _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake((kMainScreenWidth/2-60), 200, 120, 30)];
    _nameTextField.text = @"Oahgnehzoul丶";
    [self.view addSubview:_nameTextField];
    
    UIButton *tencentBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-60, 260, 120, 30)];
//    [tencentBtn setTitle:@"绑定腾讯微博" forState:UIControlStateNormal];
//    tencentBtn.backgroundColor = [UIColor yellowColor];
//    tencentBtn.tintColor = [UIColor blackColor];
//    tencentBtn.titleLabel.tintColor = [UIColor blackColor];
    [tencentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [tencentBtn setFont:[UIFont systemFontOfSize:16]];
    tencentBtn.titleLabel.font = [UIFont systemFontOfSize:17];
//    tencentBtn.titleLabel.text = @"绑定腾讯微博";
    [tencentBtn setTitle:@"绑定腾讯微博" forState:UIControlStateNormal];
    [tencentBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    tencentBtn.tag = 2;
    [self.view addSubview:tencentBtn];
    
    UIButton *sinaBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-60, 310, 120, 30)];
//    sinaBtn.backgroundColor = [UIColor yellowColor];
    [sinaBtn setTitle:@"绑定新浪微博" forState:UIControlStateNormal];
    sinaBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [sinaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sinaBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    sinaBtn.tag = 3;
    [self.view addSubview:sinaBtn];
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-75, kMainScreenHeight-130, 150, 40)];
    loginBtn.layer.cornerRadius = 15;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.borderWidth = 1;
    loginBtn.layer.borderColor = [UIColor grayColor].CGColor;
    [loginBtn setTitle:@"登出" forState:UIControlStateNormal];
    
    [loginBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.tag = 4;
    [self.view addSubview:loginBtn];
    
}


- (void)btnAction:(UIButton *)btn {
    //更改头像
    if (btn.tag == 1) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
        [actionSheet showInView:self.view];
    }else if (btn.tag == 2) {
        NSLog(@"绑定腾讯微博");
    }else if (btn.tag == 3) {
        NSLog(@"绑定新浪微博");
    }else {
        NSLog(@"登陆");

//        NSDictionary *pramas = @{@"source":@"sina",
//                                 @"user":@"3216820023",
//                                 @"expires_in":@(641770),
//                                 @"access_token":@"2.00vp8hVD0K7rDZ37e68e711fFcg_zB",
//                                 @"refresh_token":@"2.00vp8hVD0K7rDZdf2c43c919lGFHIC"};
//        [DataService requestUrl:Login params:pramas httpMethod:@"POST" block:^(id result) {
//            NSLog(@"%@",result);
//            [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"result"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            NSLog(@"%@",NSHomeDirectory());
//        }];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//        [params setValue:@"sina" forKey:@"source"];
//        [params setValue:@"3216820023" forKey:@"user"];
//        [params setValue:@"2.00vp8hVD0K7rDZ37e68e711fFcg_zB" forKey:@"access_token"];
//        [params setValue:@"2.00vp8hVD0K7rDZdf2c43c919lGFHIC" forKey:@"refresh_token"];
//        [params setValue:@(657660) forKey:@"expires_in"];
//        {
//            "source": "tencent",
//            "user": "7941793B8CBD8796764F0663919B684A",
//            "expires_in": 1449982874,
//            "access_token": "49f9c8d81bce0d2885cdd476d3499de4",
//            "refresh_token": "4b761720c520a71761809e6a509ca44a"
//        }
        [params setValue:@"tencent" forKey:@"source"];
        [params setValue:@"7941793B8CBD8796764F0663919B684A" forKey:@"user"];
        [params setValue:@(1449982874) forKey:@"expires_in"];
        [params setValue:@"49f9c8d81bce0d2885cdd476d3499de4" forKey:@"access_token"];
        [params setValue:@"4b761720c520a71761809e6a509ca44a" forKey:@"refresh_token"];
        
//        [DataService requestUrl:Login params:params httpMethod:@"POST" block:^(id result) {
//            NSLog(@"%@",result);
//        }];
        
    }
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    UIImagePickerControllerSourceType sourceType;
    if (buttonIndex == 0) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
        //        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没有摄像头" message:nil delegate:nil
                                                  cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
    }else if(buttonIndex == 1){
        sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }else {
        return;
    }
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
    
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *meidaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([meidaType isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [_iconBtn setImage:image forState:UIControlStateNormal];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
