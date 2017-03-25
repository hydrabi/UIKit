//
//  YQRefreshControl.m
//  YQUIKit
//
//  Created by Hydra on 2017/2/16.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import "YQRefreshControl.h"
#import "YQRefreshAnimationView.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#define DEGREES_TO_RADIANS(x) (x)/180.0*M_PI
#define RADIANS_TO_DEGREES(x) (x)/M_PI*180.0

/**下拉刷新默认高度*/
const static CGFloat refreshControlHeight = 72.0f;

@implementation UIScrollView(YQRefreshControl)
- (YQRefreshControl *)addRefreshControlWithVerticalOffset:(CGFloat)verticalOffset
                                            actionHandler:(void (^)(YQRefreshControl *v))handler{
    for(UIView *v in self.subviews){
        //遍历子View，如果已存在RefreshControl，则不重复添加
        if([v isKindOfClass:[YQRefreshControl class]]){
            return (YQRefreshControl*)v;
        }
    }
    
    //构造下拉刷新控制并添加
    YQRefreshControl *view = [[YQRefreshControl alloc] initWithFrame:CGRectMake(0,
                                                                                -refreshControlHeight+verticalOffset,
                                                                                [UIScreen mainScreen].bounds.size.width,
                                                                                refreshControlHeight)];
    view.refreshHandler = handler;
    view.scrollView = self;
    view.originalInsetTop = self.contentInset.top;
    view.showPullToRefresh = YES;
    view.vertificalOffset = verticalOffset;
    [self addSubview:view];
    return view;
}

-(CGFloat)getRefreshControlHeight{
    return refreshControlHeight;
}
@end

@interface YQRefreshControl()
/**是否由用户触发*/
@property (nonatomic,assign)BOOL isUserAction;

/**
 当前刷新状态
 */
@property (nonatomic,assign)RefreshState state;
/**当前下拉百分比*/
@property (nonatomic,assign)double progress;
/**上一次下拉百分比*/
@property (nonatomic,assign)double prevProgress;

/**
 正在刷新View
 */
@property (nonatomic,strong)YQRefreshAnimationView *loadingView;
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
    //构造动画播放View并添加
    self.loadingView = [[YQRefreshAnimationView alloc] init];
    [self addSubview:self.loadingView];
    
    //使View与自身位置相同
    __weak typeof(self)weakSelf = self;
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(weakSelf.mas_leading).offset(0);
        make.trailing.equalTo(weakSelf.mas_trailing).offset(0);
        make.top.equalTo(weakSelf.mas_top).offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(0);
    }];
}

#pragma mark - 属性初始化
-(void)setShowPullToRefresh:(BOOL)showPullToRefresh{
    self.hidden = !showPullToRefresh;
    if(showPullToRefresh){
        //添加下拉监听
        if(!self.isObserving){
            @weakify(self)
            [[RACObserve(self.scrollView, contentOffset)
              deliverOnMainThread]
             subscribeNext:^(NSValue *pointValue){
                 @strongify(self)
                 CGPoint contentOffset = [pointValue CGPointValue];
                 
                 CGFloat yOffset = contentOffset.y;
                 if(yOffset < -refreshControlHeight){
                     //下拉高度小于整个refreshControl的高度，调整高度位置

                     CGRect rect = [self originalFrame];
                     rect.origin.y = yOffset+_vertificalOffset;
                     self.frame = rect;
                 }
                 else{
                     //下拉高度超过原有refreshControl高度，不再下拉
                     self.frame = [self originalFrame];
                 }

                 //设置当前下拉百分比
                 self.progress = ((yOffset + self.originalInsetTop)/(-self.threshold));
                 switch (self.state) {
                     case RefreshStateNormal:
                     {
                         if(self.isUserAction &&
                            !self.scrollView.dragging  &&
                            !self.scrollView.isZooming &&
                            self.prevProgress > 0.99f){
                             //上一次下拉由用户触发，当前不是（也就是下拉后松手），并且上一次下拉百分比超过99，触发刷新
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
    //当父类移除移除屏幕时，停止刷新动画
    if(self.superview && newSuperview == nil){
        if(self.isObserving){
            self.showPullToRefresh = NO;
        }
    }
}

-(BOOL)showPullToRefresh{
    return !self.hidden;
}


/**
 设置当前下拉百分比，同时保存前一次的百分比

 @param progress 当前百分比
 */
-(void)setProgress:(double)progress{
    if(progress > 1.0){
        progress = 1.0;
    }
    self.prevProgress = self.progress;
    _progress = progress;
}


/**
 默认Frame位置

 @return  默认Frame位置
 */
-(CGRect)originalFrame{
    return CGRectMake(0,
                      -refreshControlHeight+_vertificalOffset,
                      [UIScreen mainScreen].bounds.size.width,
                      refreshControlHeight);
}

#pragma mark - 触发loading状态


/**
 触发刷新

 @param triggered 是否触发回调
 */
-(void)actionTriggeredState:(BOOL)triggered{
    self.state = RefreshStateLoading;
    //调整scrollView inset 固定显示刷新View
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.top = refreshControlHeight;
    CGPoint point = self.scrollView.contentOffset;
    
    //设置offset，防止有时候动画导致容器过度上弹
    [self.scrollView setContentOffset:point];
    
    //触发动画
    [self.loadingView performAniamtion];


    [self setUpScrollViewContentInset:currentInsets
                              handler:nil];
    //设置offset，防止有时候动画导致容器过度上弹
    [self.scrollView setContentOffset:CGPointMake(0, -refreshControlHeight)];
    if(self.refreshHandler && triggered){
        self.refreshHandler(self);
    }
}

#pragma mark - 停止loading状态

/**
 触发停止
 */
-(void)actionStopState{
    
    [self resetScrollViewContentInset:^{
        self.state = RefreshStateNormal;
        self.frame = [self originalFrame];
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
    //还原scrollView inset
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
    if(self.state != RefreshStateLoading){
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, -refreshControlHeight);
        
        [self actionTriggeredState:triggered];

    }
    
}

@end
