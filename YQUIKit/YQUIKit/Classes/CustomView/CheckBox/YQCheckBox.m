//
//  YQCheckBox.m
//  Pods
//
//  Created by Hydra on 2017/2/28.
//
//

#import "YQCheckBox.h"
#import "YQResourceLib.h"
#import "YQUIDefinitions.h"
#import "NSString+CommonIconFont.h"
#import "ReactiveCocoa.h"
#ifdef __OBJC__
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#endif

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_9_3
@interface YQCheckBox() <CAAnimationDelegate>
#else
@interface YQCheckBox()
#endif

/**
 选中时显示的label
 */
@property (nonatomic,strong)UILabel *aboveLabel;

/**
 未被选中时的label
 */
@property (nonatomic,strong)UILabel *belowLabel;

/**
 动画持续时间
 */
@property (nonatomic,assign)CGFloat animationDuration;
@end

@implementation YQCheckBox

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

#pragma mark - UI
-(void)UIConfig{
    _on = NO;
    _onFillColor = [YQUIDefinitions getColor:@"@Color_Oriange"];
    _offStrokeColor = [YQUIDefinitions getColor:@"@Color_Dark_54"];
    _animationDuration = 0.3;
    _belowLabelFontSize = 24.0f;
    _aboveLabelFontSize = 24.0f;
    self.backgroundColor = [UIColor clearColor];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                       action:@selector(checkBoxClick:)]];
    [self createBelowLabel];
    self.checkBoxType = YQCheckBoxTypeCircle;
}

-(void)createBelowLabel{
    if(self.belowLabel == nil){
        self.belowLabel = [[UILabel alloc] init];
        self.belowLabel.textAlignment = NSTextAlignmentCenter;
        self.belowLabel.font = [UIFont fontWithName:iconFontName
                                               size:self.belowLabelFontSize];
        self.belowLabel.textColor = self.offStrokeColor;
        
        [self addSubview:self.belowLabel];
        @weakify(self)
        [self.belowLabel makeConstraints:^(MASConstraintMaker *make){
            @strongify(self)
            make.edges.equalTo(self);
        }];
    }
}

-(void)createAboveLabel{
    [self.aboveLabel removeFromSuperview];
    self.aboveLabel = nil;
    self.aboveLabel = [[UILabel alloc] init];
    self.aboveLabel.textAlignment = NSTextAlignmentCenter;
    self.aboveLabel.font = [UIFont fontWithName:iconFontName
                                           size:self.aboveLabelFontSize];
    self.aboveLabel.textColor = self.onFillColor;
    if(self.checkBoxType == YQCheckBoxTypeCircle){
        self.aboveLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"F00F"];
    }
    else{
        self.aboveLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"f408"];
    }
    [self addSubview:self.aboveLabel];
    
    @weakify(self)
    [self.aboveLabel makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.edges.equalTo(self);
    }];
    
}

#pragma mark - 事件
-(void)checkBoxClick:(UITapGestureRecognizer *)recognizer{
    [self setOn:!self.on animated:YES];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void)setOn:(BOOL)on animated:(BOOL)animated{
    _on = on;
    
    if(on){
        [self createAboveLabel];
        if(animated){
            [self addOnAniamtion];
        }
    }
    else{
        if(animated){
            [self addOffAnimation];
        }
        else{
            [self.aboveLabel removeFromSuperview];
        }
    }
}

#pragma mark - 属性
-(void)setOn:(BOOL)on{
    [self setOn:on animated:NO];
    
}

-(void)setCheckBoxType:(YQCheckBoxType)checkBoxType{
    _checkBoxType = checkBoxType;
    if(self.checkBoxType == YQCheckBoxTypeCircle){
        self.belowLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"F403"];
        self.aboveLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"F00F"];
    }
    else{
        self.belowLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"f405"];
        self.aboveLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"f408"];
    }
}

-(void)setAboveLabelFontSize:(CGFloat)aboveLabelFontSize{
    _aboveLabelFontSize = aboveLabelFontSize;
    self.aboveLabel.font = [UIFont fontWithName:iconFontName
                                           size:aboveLabelFontSize];
}

-(void)setBelowLabelFontSize:(CGFloat)belowLabelFontSize{
    _belowLabelFontSize = belowLabelFontSize;
    self.belowLabel = [UIFont fontWithName:iconFontName
                                      size:belowLabelFontSize];
}

-(void)setOnFillColor:(UIColor *)onFillColor{
    _onFillColor = onFillColor;
    self.aboveLabel.textColor = onFillColor;
}

-(void)setOffStrokeColor:(UIColor *)offStrokeColor{
    _offStrokeColor = offStrokeColor;
    self.belowLabel.textColor = offStrokeColor;
}

#pragma mark - Aniamtion
-(void)addOnAniamtion{
    CAKeyframeAnimation *bounceAnimation = [self keyFrameAniamtionWithBounces:1
                                                                    amplitude:0.2
                                                                      reverse:NO];
    bounceAnimation.delegate = self;
    CABasicAnimation *opacityAnimation = [self opacityAnimationReverse:NO];
//    opacityAnimation.delegate = self;
//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    group.animations = @[bounceAnimation,opacityAnimation];
//    group.delegate = self;
//    group.duration = self.animationDuration;
    [self.aboveLabel.layer addAnimation:bounceAnimation
                                 forKey:@"group"];
    [self.aboveLabel.layer addAnimation:opacityAnimation
                                 forKey:@"opacity"];
}

-(void)addOffAnimation{
    CAKeyframeAnimation *bounceAnimation = [self keyFrameAniamtionWithBounces:1
                                                                    amplitude:0.2
                                                                      reverse:YES];
    bounceAnimation.delegate = self;
    CABasicAnimation *opacityAnimation = [self opacityAnimationReverse:YES];
//    opacityAnimation.delegate = self;
//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    group.animations = @[bounceAnimation,opacityAnimation];
//    group.delegate = self;
//    group.duration = self.animationDuration;
    [self.aboveLabel.layer addAnimation:bounceAnimation
                                 forKey:@"group"];
    [self.aboveLabel.layer addAnimation:opacityAnimation
                                 forKey:@"opacity"];
}

-(CAKeyframeAnimation*)keyFrameAniamtionWithBounces:(NSUInteger)bounces amplitude:(CGFloat)amplitude reverse:(BOOL)reverse{
    NSMutableArray *values = @[].mutableCopy;
    NSMutableArray *keyTimes = @[].mutableCopy;
    if(reverse){
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]];
    }
    else{
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 0)]];
    }
    [keyTimes addObject:@0.0];
    
    for(NSUInteger i = 1;i<=bounces;i++){
        CGFloat scale = (i % 2)? (1+amplitude/i):(1-amplitude/i);
        CGFloat time = i * 1.0 /(bounces+1);
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, scale)]];
        [keyTimes addObject:@(time)];
    }
    
    if(reverse){
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0001, 0.0001, 0.0001)]];
    }
    else{
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]];
    }
    [keyTimes addObject:@1.0];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = values;
    animation.keyTimes = keyTimes;
    animation.duration = self.animationDuration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return animation;
}

-(CABasicAnimation*)opacityAnimationReverse:(BOOL)reverse{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    if(reverse){
        animation.fromValue = @(1.0);
        animation.toValue = @(0.0);
    }
    else{
        animation.fromValue = @(0.0);
        animation.toValue = @(1.0);
    }
    animation.duration = self.animationDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

#pragma mark - Animation Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag == YES) {
        if (self.on == NO) {
            [self.aboveLabel removeFromSuperview];
        }
    }
}
@end
