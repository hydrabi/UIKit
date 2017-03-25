//
//  YQDetailedCarrierIconTableViewCell.m
//  Pods
//
//  Created by Hydra on 2017/3/6.
//
//

#import "YQDetailedCarrierIconTableViewCell.h"
#import "YQUIDefinitions.h"
#import "NUIRenderer.h"
#import "NSString+CommonIconFont.h"
#import "YQResourceUIHelper.h"
@interface YQDetailedCarrierIconTableViewCell()

@end

@implementation YQDetailedCarrierIconTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [NUIRenderer renderLabel:self.carrierNameLabel
                   withClass:@"Label_Large_87"];
    [NUIRenderer renderLabel:self.carrierCountryLabel
                   withClass:@"Label_Normal_87"];
    [NUIRenderer renderLabel:self.carrierLogoLable
                   withClass:@"Label_Icon"];
    
    
    self.statusButton.titleLabel.font = [UIFont fontWithName:iconFontName size:[YQUIDefinitions getFloat:@"@FontSize_24"]];
    [self.statusButton setTitleColor:[YQUIDefinitions getColor:@"@Color_Dark_54"]
                            forState:UIControlStateNormal];
    [self.statusButton setTitle:[YQResourceUIHelper iconFontWithCommonState:@"F059"] forState:UIControlStateNormal];
    
    self.carrierLogoLable.font = [UIFont fontWithName:@"carrier" size:40.0f];
    self.carrierLogoLable.layer.cornerRadius = [YQUIDefinitions getFloat:@"@CornerRadius_2"];
    self.carrierLogoLable.clipsToBounds = YES;
    [self showFloorLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
