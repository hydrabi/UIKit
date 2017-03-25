//
//  YQBasicTextFieldControl.m
//  Pods
//
//  Created by Hydra on 2017/3/2.
//
//

#import "YQBasicTextFieldControl.h"
#import "YQUIDefinitions.h"
#import "UIColor+Addition.h"
#import "ReactiveCocoa.h"
#import "NUIRenderer.h"
#import "NSString+CommonIconFont.h"
#import "YQResourceLib.h"
#ifdef __OBJC__
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#endif
@implementation YQBasicTextFieldControl
#pragma mark - 实例
-(instancetype)init{
    self = [super init];
    if(self){
        [self UIConfig];
        [self makeConstraints];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self UIConfig];
        [self makeConstraints];
    }
    return self;
}

#pragma mark - 配置UI
-(void)UIConfig{
    [self createTextField];
    [self createLineView];
    [self createClearButton];
}

-(void)createTextField{
    if(self.textField == nil){
        self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.textField.borderStyle = UITextBorderStyleNone;
        self.textField.clearButtonMode = UITextFieldViewModeNever;
        self.textField.textColor = [YQUIDefinitions getColor:@"@Color_Dark_87"];
        self.textField.font = [UIFont systemFontOfSize:[YQUIDefinitions getFloat:@"@FontSize_16"]];
        [self addSubview:self.textField];
    }
}

-(void)createLineView{
    if(self.lineView == nil){
        self.lineView = [[UIView alloc] init];
        [self setLineViewNormal];
        [self addSubview:self.lineView];
    }
}

-(void)createClearButton{
    if(self.clearButton == nil){
        self.clearButton = [[YQCustomHightLightButton alloc] init];
        self.clearButton.titleLabel.font = [UIFont fontWithName:iconFontName
                                                           size:[YQUIDefinitions getFloat:@"@FontSize_16"]];
        [self.clearButton setTitleColor:[YQUIDefinitions getColor:@"@Color_Dark_12"]
                               forState:UIControlStateNormal];
        [self.clearButton setTitle:[YQResourceUIHelper iconFontWithCommonState:@"F00E"]
                          forState:UIControlStateNormal];
        [self addSubview:self.clearButton];
        
        @weakify(self)
        [[[self.clearButton
          rac_signalForControlEvents:UIControlEventTouchUpInside]
          deliverOnMainThread]
         subscribeNext:^(id _){
            @strongify(self)
             self.textField.text = @"";
             self.clearButton.hidden = YES;
        }];
        
        [[self.textField.rac_textSignal
         deliverOnMainThread]
         subscribeNext:^(NSString *text){
             @strongify(self)
             if(text.length>0){
                 self.clearButton.hidden = NO;
             }
             else{
                 self.clearButton.hidden = YES;
             }
         }];
    }
}

-(void)setLineViewNormal{
    self.lineView.backgroundColor = [YQUIDefinitions getColor:@"@Color_Dark_12"];
}

-(void)setLineViewBeResponsed{
    self.lineView.backgroundColor = [YQUIDefinitions getColor:@"@Color_Blue"];
}

-(void)setLineViewErrorStatus{
    self.lineView.backgroundColor = [YQUIDefinitions getColor:@"@Color_Red_500"];
}

#pragma mark - 设置约束
-(void)makeConstraints{
    [self makeTextFieldConstraints];
    [self makeLineViewConstraints];
    [self makeClearButtonConstraints];
}

-(void)makeTextFieldConstraints{
    @weakify(self)
    [self.textField makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.left.equalTo(self.left);
        make.trailing.equalTo(self.clearButton.leading).offset(-[YQUIDefinitions getFloat:@"@Leading_14"]);
        make.top.equalTo(self.top).offset([YQUIDefinitions getFloat:@"@Top_12"]);
        make.height.equalTo([YQUIDefinitions getFloat:@"@Normal_Height_22"]);
    }];
}

-(void)makeLineViewConstraints{
    @weakify(self)
    [self.lineView makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.left.and.right.equalTo(self);
        make.bottom.equalTo(self.bottom).offset(-[YQUIDefinitions getFloat:@"@Bottom_8"]);
        make.height.equalTo([YQUIDefinitions getFloat:@"@Normal_Height_1"]);
    }];
}

-(void)makeClearButtonConstraints{
    @weakify(self)
    [self.clearButton makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.trailing.equalTo(self.trailing);
        make.top.equalTo(self.top).offset([YQUIDefinitions getFloat:@"@Top_12"]);
        make.width.and.height.equalTo([YQUIDefinitions getFloat:@"@Normal_Height_22"]);
    }];
}

#pragma mark - 外部调用
-(void)setPlaceHolderText:(NSString*)placeHolder{
    self.textField.attributedPlaceholder    = [[NSAttributedString alloc] initWithString:placeHolder
                                                                              attributes:@{NSForegroundColorAttributeName: [YQUIDefinitions getColor:@"@Color_Dark_26"]}];
}

@end
