//
//  YQTrackListSuccessCollectionViewCell.m
//  Pods
//
//  Created by Hydra on 2017/3/23.
//
//

#import "YQTrackListSuccessCollectionViewCell.h"
#import "YQUIDefinitions.h"
#import "NUIRenderer.h"
#import "NSString+CommonIconFont.h"
#import "YQResourceUIHelper.h"
@implementation YQTrackListSuccessCollectionViewCell

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
    [NUIRenderer renderLabel:self.eventLabel
                   withClass:@"Label_Normal_54"];
    [NUIRenderer renderLabel:self.detailedTimeLabel
                   withClass:@"Label_Normal_54"];
    
    self.menuButton.titleLabel.font = [UIFont fontWithName:iconFontName
                                                      size:[YQUIDefinitions getFloat:@"@FontSize_24"]];
    [self.menuButton setTitleColor:[YQUIDefinitions getColor:@"@Color_Dark_56"]
                          forState:UIControlStateNormal];
    [self.menuButton setTitle:[YQResourceUIHelper iconFontWithCommonState:@"F02C"]
                     forState:UIControlStateNormal];
    
    self.backgroundColor    = [YQUIDefinitions getColor:@"@Color_White"];
    self.layer.cornerRadius = 1.0f;
    self.layer.borderColor  = [YQUIDefinitions getColor:@"@Color_Dark_24"].CGColor;
    self.layer.borderWidth  = [YQUIDefinitions getFloat:@"@BorderWidth_1"];
    
}

@end
