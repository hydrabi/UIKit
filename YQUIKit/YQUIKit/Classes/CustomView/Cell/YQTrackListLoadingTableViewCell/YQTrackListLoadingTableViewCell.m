//
//  YQTrackListLoadingTableViewCell.m
//  Pods
//
//  Created by Hydra on 2017/3/8.
//
//

#import "YQTrackListLoadingTableViewCell.h"
#import "YQUIDefinitions.h"
#import "NUIRenderer.h"
#import "NSString+CommonIconFont.h"
#import "YQResourceUIHelper.h"
@implementation YQTrackListLoadingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [NUIRenderer renderLabel:self.logoLable
                   withClass:@"Label_Icon"];
    [NUIRenderer renderLabel:self.nameLabel
                   withClass:@"Label_Large_87"];
    
    self.logoLable.backgroundColor = [YQUIDefinitions getColor:@"@Color_Gray_50"];
    self.logoLable.textColor = [YQUIDefinitions getColor:@"@Color_Dark"];
    self.logoLable.clipsToBounds = YES;
    self.logoLable.layer.cornerRadius = [YQUIDefinitions getFloat:@"@CornerRadius_2"];
    self.logoLable.text = [YQResourceUIHelper iconFontWithCommonState:@"F03B"];
    
    self.lineView.backgroundColor = [YQUIDefinitions getColor:@"@Color_Dark_12"];
    
    [self.activityIndicator startAnimating];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
