//
//  YQEditRecordTableViewCell.m
//  Pods
//
//  Created by Hydra on 2017/3/17.
//
//

#import "YQEditRecordTableViewCell.h"
#import "YQUIDefinitions.h"
#import "NUIRenderer.h"
#import "NSString+CommonIconFont.h"
#import "YQResourceUIHelper.h"

@implementation YQEditRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.logoLabel.textColor = [YQUIDefinitions getColor:@"@Color_White"];
    self.logoLabel.clipsToBounds = YES;
    self.logoLabel.layer.cornerRadius = [YQUIDefinitions getFloat:@"@CornerRadius_2"];
    self.logoLabel.font = [UIFont fontWithName:iconFontName
                                          size:[YQUIDefinitions getFloat:@"@FontSize_24"]];
    
    
    [NUIRenderer renderLabel:self.nameLabel
                   withClass:@"Label_Large_87"];
    [NUIRenderer renderLabel:self.carrierLabel
                   withClass:@"Label_Normal_54"];
    
    
    self.lineView.backgroundColor = [YQUIDefinitions getColor:@"@Color_Dark_12"];
    [self.checkBox setCheckBoxType:YQCheckBoxTypeCircle];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:NO];

    // Configure the view for the selected state
}

@end
