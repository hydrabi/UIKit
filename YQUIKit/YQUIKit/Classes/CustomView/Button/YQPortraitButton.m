//
//  YQPortraitButton.m
//  Pods
//
//  Created by Hydra on 2017/2/20.
//
//

#import "YQPortraitButton.h"
#import "YQUIDefinitions.h"
@implementation YQPortraitButton

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setImage:[UIImage imageNamed:@"navigationBar_head_Portrait"]
          forState:UIControlStateNormal];
    self.imageView.layer.cornerRadius = [YQUIDefinitions getFloat:@"@Normal_Width_28"]/2;
    self.imageView.clipsToBounds = YES;
}

-(id)init{
    self = [super init];
    if(self){
        [self setImage:[UIImage imageNamed:@"navigationBar_head_Portrait"]
              forState:UIControlStateNormal];
        self.imageView.layer.cornerRadius = [YQUIDefinitions getFloat:@"@Normal_Width_28"]/2;
        self.imageView.clipsToBounds = YES;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat left = (CGRectGetWidth(contentRect) - [YQUIDefinitions getFloat:@"@Normal_Width_28"])/2;
    CGFloat top = (CGRectGetHeight(contentRect) - [YQUIDefinitions getFloat:@"@Normal_Width_28"])/2;
    return CGRectMake(left,
                      top,
                      [YQUIDefinitions getFloat:@"@Normal_Width_28"],
                      [YQUIDefinitions getFloat:@"@Normal_Width_28"]);
}


@end
