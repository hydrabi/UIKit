//
//  LeftSideTableViewCell.m
//  YQTrack
//
//  Created by 毕志锋 on 15/7/25.
//  Copyright (c) 2015年 17track. All rights reserved.
//

#import "LeftSideTableViewCell.h"
#import "NSString+CommonIconFont.h"
#import "YQResourceLib.h"
@implementation LeftSideTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];

    self.leadingIconLabel.font = [UIFont fontWithName:iconFontName size:24];
    self.leadingIconLabel.textColor = [UIColor whiteColor];
    
    self.indicatorLabel.textColor = [UIColor whiteColor];
    self.indicatorLabel.font = [UIFont fontWithName:iconFontName size:24.0f];
    self.indicatorLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"F602"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)resetValueWithIndexPath:(NSIndexPath*)indexPath{
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
                self.leadingIconLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"F02F"];
                self.titleLabel.text = [[ResV5AppWord __main_funHome] get];
                break;
            case 1:
                self.leadingIconLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"F006"];
                self.titleLabel.text = [[ResV5AppWord __main_funHelp] get];
                break;
            case 2:
                self.leadingIconLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"F002"];
                self.titleLabel.text = [[ResV5AppWord __main_funAbout] get];
                break;
            case 3:
                self.leadingIconLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"F02D"];
                self.titleLabel.text = [[ResV5AppWord __main_funSetting] get];
                break;
            default:
                break;
        }
    }
}

@end
