//
//  YQCheckBox.h
//  Pods
//
//  Created by Hydra on 2017/2/28.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,YQCheckBoxType) {
    YQCheckBoxTypeCircle,   /**<圆形风格的checkBox*/
    YQCheckBoxTypeSquare    /**<矩形风格的checkBox*/
};

@interface YQCheckBox : UIControl

/**
 是否被选中
 */
@property (nonatomic,assign) BOOL on;
/**
 选中字体大小
 */
@property (nonatomic,assign) CGFloat aboveLabelFontSize;
/**
 未被选中字体大小
 */
@property (nonatomic,assign) CGFloat belowLabelFontSize;
/**
 checkBox的风格
 */
@property (nonatomic,assign) YQCheckBoxType checkBoxType;

/**
 选中时填充的字体颜色
 */
@property (nonatomic,strong) UIColor *onFillColor;

/**
 未被选中时边框字体颜色
 */
@property (nonatomic,strong) UIColor *offStrokeColor;

/**
 控制CheckBox状态改变

 @param on 选中与否
 @param animated 是否使用动画
 */
-(void)setOn:(BOOL)on animated:(BOOL)animated;

@end
