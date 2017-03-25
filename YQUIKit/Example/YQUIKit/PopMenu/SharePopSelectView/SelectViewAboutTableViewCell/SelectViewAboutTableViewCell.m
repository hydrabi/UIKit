//
//  SelectViewAboutTableViewCell.m
//  YQTrack
//
//  Created by Hydra on 16/8/22.
//  Copyright © 2016年 17track. All rights reserved.
//

#import "SelectViewAboutTableViewCell.h"
#import "SharePopSelectViewUIParameter.h"

@implementation SelectViewAboutTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    SharePopSelectViewUIParameter *UIParameter = [SharePopSelectViewUIParameter sharedSingleton];
    self.titleLabel.textColor                  = [UIParameter tableViewCell_titleLabelTextColor];
    self.titleLabel.font                       = [UIParameter tableViewCell_titleLabelFont];
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
