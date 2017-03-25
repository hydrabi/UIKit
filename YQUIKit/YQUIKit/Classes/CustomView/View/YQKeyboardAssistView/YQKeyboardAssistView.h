//
//  YQKeyboardAssistView.h
//  Pods
//
//  Created by Hydra on 2017/3/15.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,YQKeyboardAssistType) {
    YQKeyboardAssistType_Number,        /**<数字*/
    YQKeyboardAssistType_Alphabet,      /**<字母*/
    YQKeyboardAssistType_Filter,        /**<过滤*/
};

/**
 键盘展示回调
 
 @param keyboardFrame 键盘frame
 */
typedef void (^keyboardShow)(CGRect keyboardFrame);

/**
 键盘隐藏
 */
typedef void (^keyboardHide)();

/**
 点击按钮的枚举

 @param type 枚举类型
 */
typedef void (^clickedCallback)(YQKeyboardAssistType type);

@interface YQKeyboardAssistView : UIView

/**
 设置键盘辅助视图里面的内容

 @param btnTypes 按钮类型队列
 @param keyboardShow 键盘展示
 @param keyboardHide 键盘隐藏
 @param clickCallback 点击事件
 */
-(void)setContentWithBtnTypes:(NSArray*)btnTypes
                 keyboardShow:(keyboardShow)keyboardShow
                 keyboardHide:(keyboardHide)keyboardHide
                clickCallback:(clickedCallback)clickCallback;

/**
 修改键盘辅助视图里面的内容

 @param btnTypes 按钮类型队列
 */
-(void)resetContentWithBtnTypes:(NSArray*)btnTypes;
@end
