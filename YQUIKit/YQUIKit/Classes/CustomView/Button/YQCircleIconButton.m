//
//  YQCircleIconButton.m
//  Pods
//
//  Created by Hydra on 2017/3/13.
//
//

#import "YQCircleIconButton.h"
#import "NSString+CommonIconFont.h"
#import "YQUIDefinitions.h"
@implementation YQCircleIconButton

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.titleLabel.layer.cornerRadius = [YQUIDefinitions getFloat:@"@Normal_Width_28"]/2;
    self.titleLabel.clipsToBounds = YES;
    self.titleLabel.font = [UIFont fontWithName:iconFontName
                                           size:[YQUIDefinitions getFloat:@"@FontSize_24"]];
    self.titleLabel.backgroundColor = [YQUIDefinitions getColor:@"@Color_White"];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
}

-(id)init{
    self = [super init];
    if(self){
        self.titleLabel.layer.cornerRadius = [YQUIDefinitions getFloat:@"@Normal_Width_28"]/2;
        self.titleLabel.clipsToBounds = YES;
        self.titleLabel.font = [UIFont fontWithName:iconFontName
                                               size:[YQUIDefinitions getFloat:@"@FontSize_24"]];
        self.titleLabel.backgroundColor = [YQUIDefinitions getColor:@"@Color_White"];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat left = (CGRectGetWidth(self.frame) - [YQUIDefinitions getFloat:@"@Normal_Width_28"])/2;
    CGFloat top = (CGRectGetHeight(self.frame) - [YQUIDefinitions getFloat:@"@Normal_Width_28"])/2;
    return CGRectMake(left,
                      top,
                      [YQUIDefinitions getFloat:@"@Normal_Width_28"],
                      [YQUIDefinitions getFloat:@"@Normal_Width_28"]);
}

@end
