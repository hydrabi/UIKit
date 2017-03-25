//
//  YQRefreshControl.h
//  YQUIKit
//
//  Created by Hydra on 2017/2/16.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void (^actionHandler)(void);
typedef  NS_ENUM(NSUInteger,RefreshState){
    RefreshStateNormal = 0,
    RefreshStateStopped,
    RefreshStateLoading,
};

@interface YQRefreshControl : UIView
//原有的inset位置
@property (nonatomic, assign) CGFloat originalInsetTop;
@property (nonatomic, weak) UIScrollView *scrollView;
//block回调
@property (nonatomic, copy) void (^refreshHandler)(YQRefreshControl *v);
//启用时使用KVO观察属性
@property (nonatomic, assign) BOOL isObserving;
//能否使用
@property (nonatomic,assign)BOOL enableToUser;

// user customizable.
@property (nonatomic, assign) BOOL showPullToRefresh;
//阀值，其实就是loading动画的速度
@property (nonatomic, assign) CGFloat threshold;
@property (nonatomic, assign) CGFloat vertificalOffset;

- (void)stopIndicatorAnimation;

/**
 手动触发

 @param triggered 是否触发刷新事件（预留，暂无使用）
 */
- (void)manuallyTriggered:(BOOL)triggered;
@end

@interface UIScrollView(YQRefreshControl)


/**
 为ScrollView添加下拉刷新

 @param verticalOffset 偏移值，即刷新控件距离table的高度差（为header上面的控件隐藏动画预留）
 @param handler 回调
 @return 
 */
- (YQRefreshControl *)addRefreshControlWithVerticalOffset:(CGFloat)verticalOffset
                                actionHandler:(void (^)(YQRefreshControl *v))handler;

/**
 返回刷新控件的高度

 @return 刷新控件的高度
 */
-(CGFloat)getRefreshControlHeight;

@end
