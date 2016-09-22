//
//  ZDThemeDelegate.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/22.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDThemeDelegate.h"
#import "ZDThemeViewController.h"
#import "ZDThemeModel.h"
#import "ZDThemeItem.h"
@implementation ZDThemeDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 44.f : 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 44)];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"主编";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor hx_colorWithHexRGBAString:@"#717171"];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.centerY.equalTo(view);
    }];
    ZDThemeModel *model = (ZDThemeModel *)self.controller.keyModel;
    ZDThemeItem *item = (ZDThemeItem *)model.item;
    [item.editors enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZDThemeEditorItem *item = (ZDThemeEditorItem *)obj;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((10+22)*idx + 60, 11, 22, 22)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:item.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            UIGraphicsBeginImageContextWithOptions(imageView.size, NO, 0.f);
            [[UIBezierPath bezierPathWithRoundedRect:imageView.bounds cornerRadius:11] addClip];
            [image drawInRect:imageView.bounds];
            imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }];
        [view addSubview:imageView];
    }];
    return view;
}




@end
