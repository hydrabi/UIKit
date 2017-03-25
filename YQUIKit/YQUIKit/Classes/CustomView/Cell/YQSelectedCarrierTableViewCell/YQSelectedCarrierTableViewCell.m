//
//  YQSelectedCarrierTableViewCell.m
//  Pods
//
//  Created by Hydra on 2017/3/3.
//
//

#import "YQSelectedCarrierTableViewCell.h"
#import "YQUIDefinitions.h"
#import "NUIRenderer.h"
#import "NSString+CommonIconFont.h"
#import "YQResourceUIHelper.h"
@interface YQSelectedCarrierTableViewCell()

@end

@implementation YQSelectedCarrierTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [NUIRenderer renderLabel:self.carrierNameLabel
                   withClass:@"Label_Large_87"];
    [NUIRenderer renderLabel:self.iconLabel
                   withClass:@"Label_Icon"];
    
    self.statusButton.titleLabel.font = [UIFont fontWithName:iconFontName size:[YQUIDefinitions getFloat:@"@FontSize_24"]];
    [self.statusButton setTitleColor:[YQUIDefinitions getColor:@"@Color_Dark_54"]
                            forState:UIControlStateNormal];
    [self.statusButton setTitle:[YQResourceUIHelper iconFontWithCommonState:@"F059"] forState:UIControlStateNormal];
    
    self.iconLabel.font = [UIFont fontWithName:@"carrier" size:40.0f];
    self.lineView.backgroundColor = [YQUIDefinitions getColor:@"@Color_Dark_12"];
    
    [self showFloorLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
