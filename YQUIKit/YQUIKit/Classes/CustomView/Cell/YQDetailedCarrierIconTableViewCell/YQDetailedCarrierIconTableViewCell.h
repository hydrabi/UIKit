//
//  YQDetailedCarrierIconTableViewCell.h
//  Pods
//
//  Created by Hydra on 2017/3/6.
//
//

#import <UIKit/UIKit.h>
#import "YQCustomHightLightButton.h"
#import "YQSeparatorTableViewCell.h"
/**
 与YQDetailedCarrierTableViewCell一样 不过图标为字体
 */
@interface YQDetailedCarrierIconTableViewCell : YQSeparatorTableViewCell
/**
 *  用字体的时候显示这个
 */
@property (weak, nonatomic) IBOutlet UILabel *carrierLogoLable;
/**
 *  运输商名称
 */
@property (weak, nonatomic) IBOutlet UILabel *carrierNameLabel;

/**
 *  运输商国家
 */
@property (weak, nonatomic) IBOutlet UILabel *carrierCountryLabel;

/**
 *  运输商状态
 */
@property (weak, nonatomic) IBOutlet YQCustomHightLightButton *statusButton;

/**
 *  分割线
 */
@property (weak, nonatomic) IBOutlet UIView *lineView;
@end
