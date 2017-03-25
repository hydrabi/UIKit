//
//  YQDetailedCarrierTableViewCell.m
//  Pods
//
//  Created by Hydra on 2017/3/3.
//
//

#import "YQDetailedCarrierTableViewCell.h"
#import "YQUIDefinitions.h"
#import "NUIRenderer.h"
#import "NSString+CommonIconFont.h"
#import "YQResourceUIHelper.h"
@interface YQDetailedCarrierTableViewCell()

@end

@implementation YQDetailedCarrierTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [NUIRenderer renderLabel:self.carrierNameLabel
                   withClass:@"Label_Large_87"];
    [NUIRenderer renderLabel:self.carrierCountryLabel
                   withClass:@"Label_Normal_87"];
    
    self.statusButton.titleLabel.font = [UIFont fontWithName:iconFontName size:[YQUIDefinitions getFloat:@"@FontSize_24"]];
    [self.statusButton setTitleColor:[YQUIDefinitions getColor:@"@Color_Dark_54"]
                            forState:UIControlStateNormal];
    [self.statusButton setTitle:[YQResourceUIHelper iconFontWithCommonState:@"F059"] forState:UIControlStateNormal];
    
    self.lineView.backgroundColor = [YQUIDefinitions getColor:@"@Color_Dark_12"];
    self.carrierIconImageView.layer.cornerRadius = [YQUIDefinitions getFloat:@"@CornerRadius_2"];
    self.carrierIconImageView.clipsToBounds = YES;
    
    [self showFloorLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
