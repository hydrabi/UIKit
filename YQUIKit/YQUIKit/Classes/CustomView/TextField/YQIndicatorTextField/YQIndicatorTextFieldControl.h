//
//  YQIndicatorTextFieldControl.h
//  Pods
//
//  Created by Hydra on 2017/3/2.
//
//

#import <YQUIKit/YQUIKit.h>
#import "YQBasicTextFieldControl.h"
@interface YQIndicatorTextFieldControl : YQBasicTextFieldControl
@property (nonatomic,strong)UILabel *indicatorLabel;
-(void)setIndicatorIcon:(NSString*)icon;
@end
