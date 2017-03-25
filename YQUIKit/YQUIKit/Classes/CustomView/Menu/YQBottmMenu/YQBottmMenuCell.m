//
//  YQBottmMenuCell.m
//  Pods
//
//  Created by Hydra on 2017/2/24.
//
//

#import "YQBottmMenuCell.h"
#import "YQBottmMenu.h"
#import "YQResourceLib.h"
#import "UIColor+Addition.h"
#import "YQMenuManager.h"
@interface YQBottmMenuCell()
@property (nonatomic,weak)IBOutlet UILabel *iconLabel;
@property (nonatomic,weak)IBOutlet UILabel *titleLabel;
@end

@implementation YQBottmMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.iconLabel.textColor = [UIColor colorWithHexString:@"#9f9f9f"
                                                     alpha:1];
    // Configure the view for the selected state
}

-(void)resetValueWithBottomMenuType:(YQMenuType)type{
    self.iconLabel.text = [YQResourceUIHelper iconFontWithCommonState:[YQMenuManager getIconKeyWithType:type]];
    self.titleLabel.text = [YQMenuManager getTitleWithType:type];
}

@end
