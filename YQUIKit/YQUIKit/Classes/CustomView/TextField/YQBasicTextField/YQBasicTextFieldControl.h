//
//  YQBasicTextFieldControl.h
//  Pods
//
//  Created by Hydra on 2017/3/2.
//
//

#import <UIKit/UIKit.h>
#import "YQCustomHightLightButton.h"
@interface YQBasicTextFieldControl : UIView
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)YQCustomHightLightButton *clearButton;

/**
 配置UI,继承时调用父类，可设置textField和lineView
 */
-(void)UIConfig;

/**
 设置占位符文本

 @param placeHolder 占位符文本
 */
-(void)setPlaceHolderText:(NSString*)placeHolder;

/**
 底部线条灰色
 */
-(void)setLineViewNormal;

/**
 底部线条蓝色，被选中
 */
-(void)setLineViewBeResponsed;

/**
 底部线条红色，出现错误
 */
-(void)setLineViewErrorStatus;

/**
 设置整体的约束，有额外添加的话，继承此约束并添加
 */
-(void)makeConstraints;
/**
 对textField创建约束
 */
-(void)makeTextFieldConstraints;

/**
 对底部线条创建约束
 */
-(void)makeLineViewConstraints;

/**
 清除按钮约束
 */
-(void)makeClearButtonConstraints;
@end
