//
//  NavigationBarTableViewCell.m
//  YQUIKit
//
//  Created by Hydra on 2017/3/9.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import "NavigationBarTableViewCell.h"

@implementation NavigationBarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
