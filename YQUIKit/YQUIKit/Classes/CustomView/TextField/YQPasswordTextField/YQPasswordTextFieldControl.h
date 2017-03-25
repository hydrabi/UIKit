//
//  YQPasswordTextFieldControl.h
//  Pods
//
//  Created by Hydra on 2017/3/2.
//
//

#import <YQUIKit/YQUIKit.h>
#import "YQBasicTextFieldControl.h"
#import "YQCustomHightLightButton.h"
@interface YQPasswordTextFieldControl : YQBasicTextFieldControl
@property (nonatomic,strong)UILabel *indicatorLabel;
/**
 清除按钮与密码按钮的分割线
 */
@property (nonatomic,strong)UIView *verticalLine;

/**
 密码按钮
 */
@property (nonatomic,strong)YQCustomHightLightButton *secureTextEntryButton;
-(void)setIndicatorIcon:(NSString*)icon;
@end
