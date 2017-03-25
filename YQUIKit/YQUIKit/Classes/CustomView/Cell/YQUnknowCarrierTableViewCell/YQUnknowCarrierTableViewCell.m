//
//  YQUnknowCarrierTableViewCell.m
//  Pods
//
//  Created by Hydra on 2017/3/3.
//
//

#import "YQUnknowCarrierTableViewCell.h"
#import "YQUIDefinitions.h"
#import "NUIRenderer.h"
#import "NSString+CommonIconFont.h"
#import "YQResourceUIHelper.h"
@interface YQUnknowCarrierTableViewCell()

@end

@implementation YQUnknowCarrierTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [NUIRenderer renderLabel:self.firstLineLabel
                   withClass:@"Label_Large_87"];
    [NUIRenderer renderLabel:self.secondLienLabel
                   withClass:@"Label_Normal_54"];
    [NUIRenderer renderLabel:self.iconLabel
                   withClass:@"Label_Icon"];
    
    self.statusButton.titleLabel.font = [UIFont fontWithName:iconFontName size:[YQUIDefinitions getFloat:@"@FontSize_24"]];
    [self.statusButton setTitleColor:[YQUIDefinitions getColor:@"@Color_Dark_54"]
                            forState:UIControlStateNormal];
    [self.statusButton setTitle:[YQResourceUIHelper iconFontWithCommonState:@"F001"] forState:UIControlStateNormal];
    
    self.lineView.backgroundColor = [YQUIDefinitions getColor:@"@Color_Dark_12"];
    
    self.iconLabel.layer.cornerRadius = [YQUIDefinitions getFloat:@"@CornerRadius_2"];
    self.iconLabel.clipsToBounds = YES;
    self.iconLabel.textColor = [YQUIDefinitions getColor:@"@Color_Dark_54"];
    [self showFloorLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
