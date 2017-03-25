//
//  YQSectionHeaderView.m
//  Pods
//
//  Created by Hydra on 2017/3/7.
//
//

#import "YQSectionHeaderView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "YQUIDefinitions.h"
#import "NUIRenderer.h"
#ifdef __OBJC__
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#endif

@implementation YQSectionHeaderView

-(instancetype)init{
    self = [super init];
    if(self){
        [self UIConfig];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self UIConfig];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self UIConfig];
    }
    return self;
}

-(void)UIConfig{
    self.backgroundColor = [YQUIDefinitions getColor:@"@Color_White"];
    
    if(self.titleLabel == nil){
        self.titleLabel = [[UILabel alloc] init];
        [self addSubview:self.titleLabel];
        [NUIRenderer renderLabel:self.titleLabel
                       withClass:@"Label_Normal_30"];
        self.titleLabel.textColor = [YQUIDefinitions getColor:@"@Color_Dark_38"];
        
        @weakify(self)
        [self.titleLabel makeConstraints:^(MASConstraintMaker *make){
            make.leading.equalTo(self.leading).offset([YQUIDefinitions getFloat:@"@Leading_16"]);
            make.trailing.equalTo(self.trailing).offset([YQUIDefinitions getFloat:@"@Trailing_16"]);
            make.centerY.equalTo(self.centerY);
        }];
    }
    
}

@end
