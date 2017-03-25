//
//  YQShadowButton.m
//  Pods
//
//  Created by Hydra on 2017/2/27.
//
//

#import "YQShadowButton.h"
#import "YQUIDefinitions.h"
#ifdef __OBJC__
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#endif
#import "ReactiveCocoa.h"
@interface YQShadowButton()
@property (nonatomic,strong)UIView *shadowView;
@end

@implementation YQShadowButton

-(instancetype)init{
    self = [super init];
    if(self){
        [self UIConfig];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self UIConfig];
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)UIConfig{
    self.layer.shadowColor = [YQUIDefinitions getColor:@"@Color_Dark_24"].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 4);
    self.layer.shadowOpacity = 1.0f;
    self.layer.cornerRadius = 2.0f;
    [NUIRenderer renderButton:self
                    withClass:@"Button_Raise"];
}

-(void)showShadow{
    self.layer.shadowOpacity = 1.0f;
    self.layer.shadowColor = [YQUIDefinitions getColor:@"@Color_Dark_24"].CGColor;
}

-(void)hideShadow{
    self.shadowView.layer.shadowOpacity = 0;
    self.shadowView.layer.shadowColor = [UIColor clearColor].CGColor;
}

-(void)setLayerBackgroundColor:(UIColor*)color{
    self.layer.backgroundColor = color.CGColor;
}

@end
