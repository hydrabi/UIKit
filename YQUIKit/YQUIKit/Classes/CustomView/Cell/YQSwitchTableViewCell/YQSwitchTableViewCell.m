//
//  YQSwitchTableViewCell.m
//  Pods
//
//  Created by Hydra on 2017/3/7.
//
//

#import "YQSwitchTableViewCell.h"
#import "YQUIDefinitions.h"
#import "NUIRenderer.h"
#import "NSString+CommonIconFont.h"
#import "YQResourceUIHelper.h"
@implementation YQSwitchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [NUIRenderer renderLabel:self.titleLabel
                   withClass:@"Label_Large_87"];
    self.trailSwitch.onTintColor = [YQUIDefinitions getColor:@"@Color_Oriange"];
    [self showFloorLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
