//
//  SBTableViewCell.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/9/15.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "SBTableViewCell.h"

@implementation SBTableViewCell

+ (CGFloat)tableView:(UITableView *)tableView variantRowHeightForItem:(SBTableViewItem *)item AtIndex:(NSIndexPath *)indexPath {
    return 44.f;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"[%@==>dealloc]",[self class]);
}




@end
