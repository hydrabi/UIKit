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
@property (nonatomic, assign) CGFloat threshold;
@property (nonatomic, assign) CGFloat vertificalOffset;

- (void)stopIndicatorAnimation;
- (void)manuallyTriggered:(BOOL)triggered;
@end

@interface UIScrollView(YQRefreshControl)
- (YQRefreshControl *)addRefreshControlWithVerticalOffset:(CGFloat)verticalOffset
                                actionHandler:(void (^)(YQRefreshControl *v))handler;

@end
