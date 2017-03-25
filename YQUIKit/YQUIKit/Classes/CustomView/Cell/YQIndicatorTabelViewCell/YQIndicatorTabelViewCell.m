//
//  YQIndicatorTabelViewCell.m
//  Pods
//
//  Created by Hydra on 2017/3/7.
//
//

#import "YQIndicatorTabelViewCell.h"
#import "YQUIDefinitions.h"
#import "NUIRenderer.h"
#import "NSString+CommonIconFont.h"
#import "YQResourceUIHelper.h"
@implementation YQIndicatorTabelViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [NUIRenderer renderLabel:self.indicatorLabel
                   withClass:@"Label_Icon"];
    [NUIRenderer renderLabel:self.titleLabel
                   withClass:@"Label_Large_87"];
    
    self.indicatorLabel.textColor = [YQUIDefinitions getColor:@"@Color_Dark_54"];
    self.indicatorLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"F602"];
    [self showFloorLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
