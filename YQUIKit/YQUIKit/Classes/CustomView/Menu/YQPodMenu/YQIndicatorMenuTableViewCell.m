//
//  YQIndicatorMenuTableViewCell.m
//  Pods
//
//  Created by Hydra on 2017/3/1.
//
//

#import "YQIndicatorMenuTableViewCell.h"
#import "YQUIDefinitions.h"
#import "NUIRenderer.h"
#import "YQResourceLib.h"
#import "UIColor+Addition.h"
@implementation YQIndicatorMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [NUIRenderer renderLabel:self.leadingLabel withClass:@"Label_Icon_Normal"];
    [NUIRenderer renderLabel:self.titleLabel withClass:@"Label_Large_87"];
    self.leadingLabel.textColor = [UIColor colorWithHexString:@"#9f9f9f"
                                                     alpha:1];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

-(void)resetValueWithMenuType:(YQMenuType)type{
    self.leadingLabel.text = [YQResourceUIHelper iconFontWithCommonState:[YQMenuManager getIconKeyWithType:type]];
    self.titleLabel.text = [YQMenuManager getTitleWithType:type];
}

@end
