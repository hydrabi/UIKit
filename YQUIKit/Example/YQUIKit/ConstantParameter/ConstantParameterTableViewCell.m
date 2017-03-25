//
//  ConstantParameterTableViewCell.m
//  YQUIKit
//
//  Created by Hydra on 2017/3/9.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import "ConstantParameterTableViewCell.h"
#import "YQUIDefinitions.h"
#import "NUIRenderer.h"
#import "YQResourceUIHelper.h"
@implementation ConstantParameterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [NUIRenderer renderLabel:self.titleLabel
                   withClass:@"Label_Large_87"];
    [NUIRenderer renderLabel:self.logoLabel
                   withClass:@"Label_Icon"];
    
    NSString *key = [YQResourceUIHelper packageStateFromInteger:0];
    self.logoLabel.text = [YQResourceUIHelper iconFontWithPackageState:key];
    self.logoLabel.backgroundColor = [YQResourceUIHelper colorWithPackageState:key];
    
    self.titleLabel.numberOfLines = 0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
