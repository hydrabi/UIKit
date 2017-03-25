//
//  YQLeadingIconTableViewCell.m
//  Pods
//
//  Created by Hydra on 2017/3/7.
//
//

#import "YQLeadingIconTableViewCell.h"
#import "YQUIDefinitions.h"
#import "NUIRenderer.h"
#import "NSString+CommonIconFont.h"
#import "YQResourceUIHelper.h"
@implementation YQLeadingIconTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [NUIRenderer renderLabel:self.leadingIconLabel
                   withClass:@"Label_Icon"];
    [NUIRenderer renderLabel:self.indicatorLabel
                   withClass:@"Label_Icon"];
    [NUIRenderer renderLabel:self.titleLabel
                   withClass:@"Label_Large_87"];
    
    self.leadingIconLabel.textColor = [YQUIDefinitions getColor:@"@Color_Dark_54"];
    self.indicatorLabel.textColor = [YQUIDefinitions getColor:@"@Color_Dark_54"];
    self.indicatorLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"F602"];
    [self showFloorLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
