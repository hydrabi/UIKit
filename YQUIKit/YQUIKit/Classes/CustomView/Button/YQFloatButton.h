//
//  YQFloatButton.h
//  Pods
//
//  Created by Hydra on 2017/2/24.
//
//

#import <UIKit/UIKit.h>
#import "YQCustomHightLightButton.h"

/**
 首页悬浮按钮，用于进入单号输入页面
 */
@interface YQFloatButton : YQCustomHightLightButton


/**
 首页悬浮按钮初始化方法

 @param scrollView 底部如果是scrollView，用于实现滑动时隐藏的功能（暂未实现）
 @return YQFloatButton
 */
-(instancetype)initWithScrollView:(UIScrollView*)scrollView;
@end
