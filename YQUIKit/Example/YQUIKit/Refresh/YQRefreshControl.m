//
//  YQRefreshControl.m
//  YQUIKit
//
//  Created by Hydra on 2017/2/16.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import "YQRefreshControl.h"
#import "AnimationView.h"
#define DEGREES_TO_RADIANS(x) (x)/180.0*M_PI
#define RADIANS_TO_DEGREES(x) (x)/M_PI*180.0

const static CGFloat refreshControlHeight = 72.0f;

@implementation UIScrollView(YQRefreshControl)
- (YQRefreshControl *)addRefreshControlWithVerticalOffset:(CGFloat)verticalOffset
                                            actionHandler:(void (^)(YQRefreshControl *v))handler{
    for(UIView *v in self.subviews){
        if([v isKindOfClass:[YQRefreshControl class]]){
            return (YQRefreshControl*)v;
        }
    }
    
    YQRefreshControl *view = [[YQRefreshControl alloc] initWithFrame:CGRectMake(0,
                                                                                -refreshControlHeight,
                                                                                [UIScreen mainScreen].bounds.size.width,
                                                                                refreshControlHeight)];
    view.refreshHandler = handler;
    view.scrollView = self;
    view.originalInsetTop = self.contentInset.top;
    view.showPullToRefresh = YES;
    [self addSubview:view];
    return view;
}
@end

@interface YQRefreshControl()
@property (nonatomic,assign)BOOL isUserAction;
@property (nonatomic,assign)RefreshState state;
@property (nonatomic,assign)double progress;
@property (nonatomic,assign)double prevProgress;
@property (nonatomic,strong)AnimationView *loadingView;
@end

@implementation YQRefreshControl

#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initialize];
    }
    return self;
}

-(void)initialize{
    self.threshold = refreshControlHeight;
    self.enableToUser = YES;
    self.loadingView = [[AnimationView alloc] init];
    [self addSubview:self.loadingView];
    
    __weak typeof(self)weakSelf = self;
    [self.loadingView makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(weakSelf.leading).offset(0);
        make.trailing.equalTo(weakSelf.trailing).offset(0);
        make.top.equalTo(weakSelf.top).offset(0);
        make.bottom.equalTo(weakSelf.bottom).offset(0);
    }];
}

#pragma mark - 属性初始化
-(void)setShowPullToRefresh:(BOOL)showPullToRefresh{
    self.hidden = !showPullToRefresh;
    if(showPullToRefresh){
        if(!self.isObserving){
            @weakify(self)
            [[RACObserve(self.scrollView, contentOffset)
              deliverOnMainThread]
             subscribeNext:^(NSValue *pointValue){
                 @strongify(self)
                 CGPoint contentOffset = [pointValue CGPointValue];
                 
                 CGFloat yOffset = contentOffset.y;
                 
                 if(yOffset<-refreshControlHeight){
                     self.frame = CGRectMake(0,
                                             -refreshControlHeight+(refreshControlHeight+yOffset),
                                             [UIScreen mainScreen].bounds.size.width,
                                             refreshControlHeight);
                 }
                 else{
                     self.frame = CGRectMake(0,
                                             -refreshControlHeight,
                                             [UIScreen mainScreen].bounds.size.width,
                                             refreshControlHeight);
                 }

                 
                 self.progress = ((yOffset + self.originalInsetTop)/(-self.threshold));
                 NSLog(@"y = %f",self.progress);
                 NSLog(@"userAction = %d",self.isUserAction);
                 NSLog(@"isDragging = %d",self.scrollView.dragging);
                 switch (self.state) {
                     case RefreshStateNormal:
                     {
                         if(self.isUserAction &&
                            !self.scrollView.dragging  &&
                            self.prevProgress > 0.99f){
                             [self actionTriggeredState:YES];
                         }
                     }
                         break;
                     case RefreshStateLoading:
                     case RefreshStateStopped:
                         break;
                     default:
                         break;
                 }
                 
                 self.isUserAction = (self.scrollView.dragging) ? YES : NO;
             }];
            
            [[RACObserve(self.scrollView, contentSize)
             deliverOnMainThread]
             subscribeNext:^(id _){
                 @strongify(self)
                 [self setNeedsLayout];
                 [self setNeedsDisplay];
             }];
            
            [[RACObserve(self.scrollView, frame)
              deliverOnMainThread]
             subscribeNext:^(id _){
                 @strongify(self)
                 [self setNeedsLayout];
                 [self setNeedsDisplay];
             }];

            self.isObserving = YES;
        }
        else{
            if(self.isObserving){
                self.isObserving = NO;
            }
        }
    }
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    if(self.superview && newSuperview == nil){
        if(self.isObserving){
            self.showPullToRefresh = NO;
        }
    }
}

-(BOOL)showPullToRefresh{
    return !self.hidden;
}

-(void)setProgress:(double)progress{
    if(progress > 1.0){
        progress = 1.0;
    }
    self.prevProgress = self.progress;
    _progress = progress;
}

#pragma mark - 触发loading状态
-(void)actionTriggeredState:(BOOL)triggered{
    self.state = RefreshStateLoading;
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.top = refreshControlHeight;

    [self.loadingView performAniamtion];
    [self setUpScrollViewContentInset:currentInsets
                              handler:nil];
    if(self.refreshHandler){
        self.refreshHandler(self);
    }
}

#pragma mark - 停止loading状态
-(void)actionStopState{
    
    [self resetScrollViewContentInset:^{
        self.state = RefreshStateNormal;
        self.frame = CGRectMake(0,
                                -refreshControlHeight,
                                [UIScreen mainScreen].bounds.size.width,
                                refreshControlHeight);
        [self.loadingView stopAniamtion];
    }];
    
}

#pragma mark - 设置ContentInset
-(void)setUpScrollViewContentInset:(UIEdgeInsets)contentInset handler:(actionHandler)handler{
    self.scrollView.contentInset = contentInset;
    if (handler)
        handler();
}

//重置ContentInset
- (void)resetScrollViewContentInset:(actionHandler)handler
{
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.top = self.originalInsetTop;
    [self setUpScrollViewContentInset:currentInsets handler:handler];
}

#pragma mark - 外部调用
- (void)stopIndicatorAnimation
{
    [self actionStopState];
}

- (void)manuallyTriggered:(BOOL)triggered
{
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if(DEVICE_IS_IPAD){
            self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, -refreshControlHeight);
        }
        else{
            self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, -refreshControlHeight);
        }
        
    } completion:^(BOOL finished) {
        [self actionTriggeredState:triggered];
    }];
}

@end
