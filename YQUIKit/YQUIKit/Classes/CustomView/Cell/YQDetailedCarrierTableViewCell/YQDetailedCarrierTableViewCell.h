//
//  YQDetailedCarrierTableViewCell.h
//  Pods
//
//  Created by Hydra on 2017/3/3.
//
//

#import <UIKit/UIKit.h>
#import "YQCustomHightLightButton.h"
#import "YQSeparatorTableViewCell.h"
/**
 与YQDetailedCarrierTableViewCell一样 不过图标为字体
 */
@interface YQDetailedCarrierTableViewCell : YQSeparatorTableViewCell
/**
 *  用图片的时候显示运输商图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *carrierIconImageView;

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
