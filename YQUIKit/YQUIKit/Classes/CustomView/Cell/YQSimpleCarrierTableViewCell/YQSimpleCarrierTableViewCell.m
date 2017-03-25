//
//  YQSimpleCarrierTableViewCell.m
//  Pods
//
//  Created by Hydra on 2017/3/3.
//
//

#import "YQSimpleCarrierTableViewCell.h"
#import "YQUIDefinitions.h"
#import "NUIRenderer.h"
@interface YQSimpleCarrierTableViewCell()

@end

@implementation YQSimpleCarrierTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [NUIRenderer renderLabel:self.carrierNameLabel
                   withClass:@"Label_Large_87"];

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
