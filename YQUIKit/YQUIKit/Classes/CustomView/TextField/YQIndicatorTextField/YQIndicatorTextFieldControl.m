//
//  YQIndicatorTextFieldControl.m
//  Pods
//
//  Created by Hydra on 2017/3/2.
//
//

#import "YQIndicatorTextFieldControl.h"
#import "YQUIDefinitions.h"
#import "ReactiveCocoa.h"
#import "NUIRenderer.h"
#import "NSString+CommonIconFont.h"
#import "YQResourceLib.h"
#ifdef __OBJC__
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#endif
@implementation YQIndicatorTextFieldControl

#pragma mark - 配置UI
-(void)UIConfig{
    [super UIConfig];
    [self createIndicatorLabel];
}

-(void)makeConstraints{
    [super makeConstraints];
    [self makeIndicatorLabelConstraints];
}

-(void)createIndicatorLabel{
    if(self.indicatorLabel == nil){
        self.indicatorLabel = [[UILabel alloc] init];
        self.indicatorLabel.font = [UIFont fontWithName:iconFontName
                                                           size:[YQUIDefinitions getFloat:@"@FontSize_24"]];
        self.indicatorLabel.textColor = [YQUIDefinitions getColor:@"@Color_Dark_12"];
        self.indicatorLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"F023"];
        [self addSubview:self.indicatorLabel];
    }
}

-(void)setIndicatorIcon:(NSString*)icon{
    self.indicatorLabel.text = [YQResourceUIHelper iconFontWithCommonState:icon];
}

#pragma mark - 约束
-(void)makeTextFieldConstraints{
    @weakify(self)
    [self.textField makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.equalTo(self.indicatorLabel.trailing).offset([YQUIDefinitions getFloat:@"@Leading_11"]);
        make.trailing.equalTo(self.clearButton.leading).offset(-[YQUIDefinitions getFloat:@"@Leading_14"]);
        make.centerY.equalTo(self.centerY);
        make.height.equalTo([YQUIDefinitions getFloat:@"@Normal_Height_22"]);
    }];
}

-(void)makeIndicatorLabelConstraints{
    @weakify(self)
    [self.indicatorLabel makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.top.and.leading.equalTo(self);
        make.width.and.height.equalTo([YQUIDefinitions getFloat:@"@Normal_Height_48"]);
    }];
}

-(void)makeClearButtonConstraints{
    @weakify(self)
    [self.clearButton makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.trailing.equalTo(self.trailing);
        make.centerY.equalTo(self.centerY);
        make.width.and.height.equalTo([YQUIDefinitions getFloat:@"@Normal_Height_36"]);
    }];
}

-(void)makeLineViewConstraints{
    @weakify(self)
    [self.lineView makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.left.and.right.equalTo(self);
        make.bottom.equalTo(self.bottom);
        make.height.equalTo([YQUIDefinitions getFloat:@"@Normal_Height_1"]);
    }];
}

@end
