//
//  YQRaiseButtonCell.m
//  YQUIKit
//
//  Created by Hydra on 2017/2/27.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import "YQRaiseButtonCell.h"

@implementation YQRaiseButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.button setTitle:@"Button"
                 forState:UIControlStateNormal];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
