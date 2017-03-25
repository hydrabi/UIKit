//
//  YQFloatButton.m
//  Pods
//
//  Created by Hydra on 2017/2/24.
//
//

#import "YQFloatButton.h"
#import "UIColor+Addition.h"
#import "YQUIKit.h"
#import "YQResourceUIHelper.h"
#import "NSString+CommonIconFont.h"
@interface YQFloatButton()
@property (nonatomic,weak)UIScrollView *scrollView;
@end

@implementation YQFloatButton

-(instancetype)init{
    self = [super init];
    if(self){
        [self UIConfig];
    }
    return self;
}

-(instancetype)initWithScrollView:(UIScrollView*)scrollView{
    self = [super init];
    if(self){
        self.scrollView = scrollView;
        [self UIConfig];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self UIConfig];
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0,
                      0,
                      [YQUIDefinitions getFloat:@"@Normal_Width_56"],
                      [YQUIDefinitions getFloat:@"@Normal_Width_56"]);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.layer.cornerRadius = MAX(CGRectGetWidth(self.frame),
                                             CGRectGetHeight(self.frame))/2;
}

-(void)UIConfig{
    self.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont fontWithName:iconFontName
                                           size:24.0f];
    [self setTitleColor:[YQUIDefinitions getColor:@"@Color_White"]
               forState:UIControlStateNormal];
    [self setTitle:[YQResourceUIHelper iconFontWithCommonState:@"F00B"]
          forState:UIControlStateNormal];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = [UIColor colorWithHexString:@"#ff8c00"
                                                            alpha:1];
    self.titleLabel.clipsToBounds = YES;
    
    self.layer.shadowColor = [YQUIDefinitions getColor:@"@Color_Dark_54"].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 3);
    self.layer.shadowOpacity = 1.0f;
}

@end
