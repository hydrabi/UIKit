//
//  YQTrailButtonTextFieldControl.h
//  Pods
//
//  Created by Hydra on 2017/3/3.
//
//

#import <YQUIKit/YQUIKit.h>
#import "YQBasicTextFieldControl.h"
#import "YQCustomHightLightButton.h"
@interface YQTrailButtonTextFieldControl : YQBasicTextFieldControl
@property (nonatomic,strong)UILabel *indicatorLabel;
@property (nonatomic,strong)YQCustomHightLightButton *trailButton;
-(void)setIndicatorIcon:(NSString*)icon;
@end
