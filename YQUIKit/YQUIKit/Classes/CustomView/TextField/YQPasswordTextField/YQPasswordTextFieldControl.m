//
//  YQPasswordTextFieldControl.m
//  Pods
//
//  Created by Hydra on 2017/3/2.
//
//

#import "YQPasswordTextFieldControl.h"
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
@implementation YQPasswordTextFieldControl

#pragma mark - 配置UI
-(void)UIConfig{
    [super UIConfig];
    [self createIndicatorLabel];
    [self createVerticalLine];
    [self createSecureTextEntryButton];
}

-(void)makeConstraints{
    [super makeConstraints];
    [self makeIndicatorLabelConstraints];
    [self makeSecureButtonConstraints];
    [self makeVerticalLineConstraints];
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

-(void)createVerticalLine{
    if(self.verticalLine == nil){
        self.verticalLine = [[UIView alloc] init];
        self.verticalLine.backgroundColor = [YQUIDefinitions getColor:@"@Color_Dark_12"];
        [self addSubview:self.verticalLine];
        
        @weakify(self)
        [[RACObserve(self.clearButton, hidden)
          deliverOnMainThread]
         subscribeNext:^(NSNumber *hidden){
            @strongify(self)
             BOOL isHidden = [hidden boolValue];
             if(isHidden){
                 self.verticalLine.hidden = YES;
             }
             else{
                 self.verticalLine.hidden = NO;
             }
        }];
    }
}

-(void)createSecureTextEntryButton{
    if(self.secureTextEntryButton == nil){
        self.secureTextEntryButton = [[YQCustomHightLightButton alloc] init];
        self.secureTextEntryButton.titleLabel.font = [UIFont fontWithName:iconFontName
                                                                     size:[YQUIDefinitions getFloat:@"@FontSize_16"]];
        [self.secureTextEntryButton setTitleColor:[YQUIDefinitions getColor:@"@Color_Dark_12"]
                                         forState:UIControlStateNormal];
        self.secureTextEntryButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.secureTextEntryButton.contentVerticalAlignment   = UIControlContentVerticalAlignmentCenter;
        [self.secureTextEntryButton setTitle:[YQResourceUIHelper iconFontWithCommonState:@"F049"]
                                    forState:UIControlStateNormal];
        [self addSubview:self.secureTextEntryButton];
        self.textField.secureTextEntry = YES;
        
        @weakify(self)
        //是否隐藏密码
        [[[self.secureTextEntryButton
          rac_signalForControlEvents:UIControlEventTouchUpInside]
          doNext:^(id button){
              
          }]
         subscribeNext:^(id _){
             @strongify(self)
             self.textField.secureTextEntry = !self.textField.secureTextEntry;
             
             if(self.textField.secureTextEntry){
                 [self.secureTextEntryButton setTitleColor:[YQUIDefinitions getColor:@"@Color_Dark_12"]
                                                  forState:UIControlStateNormal];
             }
             else{
                 [self.secureTextEntryButton setTitleColor:[YQUIDefinitions getColor:@"@Color_Dark_87"]
                                                  forState:UIControlStateNormal];
             }
         }];
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
        make.trailing.equalTo(self.verticalLine.leading).offset(-[YQUIDefinitions getFloat:@"@Trailing_6"]);
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

-(void)makeSecureButtonConstraints{
    @weakify(self)
    [self.secureTextEntryButton makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.trailing.equalTo(self.trailing);
        make.centerY.equalTo(self.centerY);
        make.width.and.height.equalTo([YQUIDefinitions getFloat:@"@Normal_Height_44"]);
    }];
}

-(void)makeVerticalLineConstraints{
    @weakify(self)
    [self.verticalLine makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.width.equalTo([YQUIDefinitions getFloat:@"@Normal_Width_1"]);
        make.height.equalTo([YQUIDefinitions getFloat:@"@Normal_Height_24"]);
        make.centerY.equalTo(self.centerY);
        make.trailing.equalTo(self.secureTextEntryButton.leading).offset(-[YQUIDefinitions getFloat:@"@Trailing_6"]);
    }];
}

@end
