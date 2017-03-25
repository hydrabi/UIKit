//
//  SharePopSelectViewTableViewCell.m
//  YQTrack
//
//  Created by 毕志锋 on 15/9/10.
//  Copyright (c) 2015年 17track. All rights reserved.
//

#import "SharePopSelectViewTableViewCell.h"
#import "SharePopSelectViewUIParameter.h"
@implementation SharePopSelectViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    SharePopSelectViewUIParameter *UIParameter = [SharePopSelectViewUIParameter sharedSingleton];
    self.titleLabel.textColor                  = [UIParameter tableViewCell_titleLabelTextColor];
    self.titleLabel.font                       = [UIParameter tableViewCell_titleLabelFont];
    
    self.leadingLabel.textColor = [UIColor colorWithHexString:@"000000" alpha:[UIParameter tableViewCell_titleLabelLeadingImageOpacity]];
    self.leadingLabel.font = [UIFont fontWithName:iconFontName size:24.0f];

    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
