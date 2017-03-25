//
//  YQShadowButton.h
//  Pods
//
//  Created by Hydra on 2017/2/27.
//
//

#import <UIKit/UIKit.h>
#import "YQCustomHightLightButton.h"

/**
 阴影按钮 用于实现需要clipToBounds，又有阴影的按钮
 */
@interface YQShadowButton : YQCustomHightLightButton

/**
 展示阴影
 */
-(void)showShadow;

/**
 隐藏阴影
 */
-(void)hideShadow;
//设置图层颜色
-(void)setLayerBackgroundColor:(UIColor*)color;
@end
