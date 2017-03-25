//
//  YQTrailButtonTextFieldControl.m
//  Pods
//
//  Created by Hydra on 2017/3/3.
//
//

#import "YQTrailButtonTextFieldControl.h"
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

@implementation YQTrailButtonTextFieldControl

#pragma mark - 配置UI
-(void)UIConfig{
    [super UIConfig];
    [self createIndicatorLabel];
    [self createTrailButton];
}

-(void)makeConstraints{
    [super makeConstraints];
    [self makeIndicatorLabelConstraints];
    [self makeTrailButtonConstraints];
}

-(void)createIndicatorLabel{
    if(self.indicatorLabel == nil){
        self.indicatorLabel = [[UILabel alloc] init];
        self.indicatorLabel.font = [UIFont fontWithName:iconFontName
                                                   size:[YQUIDefinitions getFloat:@"@FontSize_24"]];
        self.indicatorLabel.textColor = [YQUIDefinitions getColor:@"@Color_Dark_12"];
        self.indicatorLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"F034"];
        [self addSubview:self.indicatorLabel];
    }
}

-(void)createTrailButton{
    if(self.trailButton == nil){
        self.trailButton = [[YQCustomHightLightButton alloc] init];
        self.trailButton.titleLabel.font = [UIFont systemFontOfSize:[YQUIDefinitions getFloat:@"@FontSize_14"]];
        [self setTrailButtonEnable:YES];
        [self setTrailButtonTitle:@"ReSend"];
        [self addSubview:self.trailButton];
    }
}

-(void)setTrailButtonEnable:(BOOL)enable{
    self.trailButton.enabled = enable;
    if(enable){
        [self.trailButton setTitleColor:[YQUIDefinitions getColor:@"@Color_Blue"]
                               forState:UIControlStateNormal];
    }
    else{
        [self.trailButton setTitleColor:[YQUIDefinitions getColor:@"@Color_Dark_38"]
                               forState:UIControlStateNormal];
    }
}

-(void)setTrailButtonTitle:(NSString*)title{
    [self.trailButton setTitle:title
                      forState:UIControlStateNormal];
}

#pragma mark - 约束
-(void)makeTextFieldConstraints{
    @weakify(self)
    [self.textField makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.equalTo(self.indicatorLabel.trailing).offset([YQUIDefinitions getFloat:@"@Leading_11"]);
        make.trailing.equalTo(self.clearButton.leading);
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
        make.trailing.equalTo(self.trailButton.leading).offset(-[YQUIDefinitions getFloat:@"@Trailing_12"]);
        make.centerY.equalTo(self.centerY);
        make.width.and.height.equalTo([YQUIDefinitions getFloat:@"@Normal_Height_44"]);
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

-(void)makeTrailButtonConstraints{
    @weakify(self)
    [self.trailButton makeConstraints:^(MASConstraintMaker *make){
        make.trailing.equalTo(self.trailing);
        make.centerY.equalTo(self.centerY);
        make.height.equalTo([YQUIDefinitions getFloat:@"@Normal_Height_48"]);
    }];
}

@end
