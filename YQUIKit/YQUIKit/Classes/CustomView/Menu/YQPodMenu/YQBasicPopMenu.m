//
//  YQBasicPodMenu.m
//  Pods
//
//  Created by Hydra on 2017/3/1.
//
//

#import "YQBasicPopMenu.h"
#import "ReactiveCocoa.h"
#import "UIColor+Addition.h"
#import "YQUIDefinitions.h"
#ifdef __OBJC__
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#endif
@interface YQBasicPopMenu()
//点击消失视图
@property (nonatomic,strong)UIView *tapView;
/**
 *  隐藏动画
 */
@property (strong,nonatomic) CAAnimationGroup *hideGroup;
/**
 *  展示动画
 */
@property (strong,nonatomic) CAAnimationGroup *showGroup;
@end

@implementation YQBasicPopMenu

+(instancetype)menuWithParentView:(UIView*)parentView
                         topRight:(CGPoint)topRight
                      bottomRight:(CGPoint)bottomRight
                        menuTypes:(NSArray*)menuTypes
                            width:(CGFloat)width
                         callback:(PopMenuCallback)callback{

    return [[self alloc] initWithParentView:parentView
                           topRight:topRight
                        bottomRight:bottomRight
                          menuTypes:menuTypes
                              width:width
                           callback:callback];
}

-(instancetype)initWithParentView:(UIView*)parentView
                         topRight:(CGPoint)topRight
                      bottomRight:(CGPoint)bottomRight
                        menuTypes:(NSArray*)menuTypes
                            width:(CGFloat)width
                         callback:(PopMenuCallback)callback{
    self = [super init];
    if(self){
        NSAssert(parentView, NULL);
        self.parentView = parentView;
        self.topRight = topRight;
        self.bottomRight = bottomRight;
        self.menuTypesArr = menuTypes;
        self.width = width;
        self.callback = callback;
        [self UIConfig];
        
    }
    return self;
}

-(void)setTopRight:(CGPoint)topRight{
    if(!CGPointEqualToPoint(topRight, CGPointZero)){
        self.layer.anchorPoint = CGPointMake(1, 0);
        self.center = topRight;
    }
    _topRight = topRight;
}

-(void)setBottomRight:(CGPoint)bottomRight{
    if(!CGPointEqualToPoint(bottomRight, CGPointZero)){
        self.layer.anchorPoint = CGPointMake(1, 1);
        self.center = bottomRight;
    }
    _bottomRight = bottomRight;
}

#pragma mark - UI
-(void)UIConfig{
    [self attributeConfig];
    [self tapViewConfig];
    [self tableViewConfig];
    [self animationConfig];
}

-(void)attributeConfig{
    self.backgroundColor = [UIColor colorWithHexString:@"efeff4" alpha:1];
    self.frame = CGRectMake(0,
                            0,
                            self.width,
                            [YQUIDefinitions getFloat:@"@Normal_Height_44"] * self.menuTypesArr.count);
    
    self.layer.shadowColor = [YQUIDefinitions getColor:@"@Color_Dark_54"].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowOpacity = 1.0f;
    
    if(CGPointEqualToPoint(self.topRight, CGPointZero)){
        self.center = self.bottomRight;
    }
    else{
        self.center = self.topRight;
    }
    
}

-(void)tapViewConfig{
    if(!self.tapView){
        self.tapView = [[UIView alloc] init];
        self.tapView.userInteractionEnabled = YES;
        self.tapView.backgroundColor = [UIColor clearColor];
        self.tapView.frame = self.parentView.frame;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(tapAction:)];
        [self.tapView addGestureRecognizer:tap];
    }
}

-(void)tableViewConfig{
    if(!self.tableView){
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                      style:UITableViewStylePlain];
        self.tableView.scrollEnabled = NO;
        self.tableView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.tableView];
        @weakify(self)
        [self.tableView makeConstraints:^(MASConstraintMaker *make){
            @strongify(self)
            make.left.and.right.equalTo(self);
            make.top.equalTo(self.top);
            make.bottom.equalTo(self.bottom);
        }];
    }
}

-(void)tapAction:(UITapGestureRecognizer*)tap{
    [self hidePopView];
}

#pragma mark - 创建动画
/**
 *  创建动画
 */
-(void)animationConfig{
    [self configHideAniamtion];
    [self configShowAnimation];
}
/**
 *  隐藏动画
 */
-(void)configHideAniamtion{
    if(!self.hideGroup){
        CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [scale setFromValue:@(1.0)];
        [scale setToValue:@(0.0)];
        
        CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
        [opacity setFromValue:@(1.0)];
        [opacity setToValue:@(0.0)];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = 0.2;
        [group setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [group setAnimations:@[scale,opacity]];
        self.hideGroup = group;
        [group setValue:@"hide" forKey:@"hide"];
        self.hideGroup.delegate = self;
    }
}
/**
 *  展示动画
 */
-(void)configShowAnimation{
    if(!self.showGroup){
        CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [scale setFromValue:@(0.0)];
        [scale setToValue:@(1.0)];
        scale.removedOnCompletion = NO;
        scale.fillMode = kCAFillModeForwards;
        
        CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
        [opacity setFromValue:@(0.0)];
        [opacity setToValue:@(1.0)];
        opacity.removedOnCompletion = NO;
        opacity.fillMode = kCAFillModeForwards;
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = 0.2;
        [group setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [group setAnimations:@[scale,opacity]];
        [group setValue:@"show" forKey:@"show"];
        self.showGroup = group;
    }
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if(self.superview!=nil){
        [self removeFromSuperview];
    }
}

#pragma mark - 展示sharePopView
//展示sharePopView
-(void)showPopView{
    if(!self.superview){
        if(!self.tapView.superview){
            [self.parentView addSubview:self.tapView];
        }
        [self.parentView addSubview:self];
        [self.layer addAnimation:self.showGroup forKey:@"start"];
        self.layer.opacity = 1.0;
    }
    else{
        [self hidePopView];
    }
}

-(void)hidePopView{
    if(self.superview){
        [self.layer addAnimation:self.hideGroup forKey:@"end"];
        self.layer.opacity = 0.0;
        if(self.tapView.superview){
            [self.tapView removeFromSuperview];
        }
    }
}

@end
