//
//  YQSelectedCarrierTableViewCell.h
//  Pods
//
//  Created by Hydra on 2017/3/3.
//
//

#import <UIKit/UIKit.h>
#import "YQCustomHightLightButton.h"
#import "YQSeparatorTableViewCell.h"

@interface YQSelectedCarrierTableViewCell : YQSeparatorTableViewCell
/**
 *  运输商名称
 */
@property (weak, nonatomic) IBOutlet UILabel *carrierNameLabel;
/**
 *  icon
 */
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
/**
 *  运输商状态
 */
@property (weak, nonatomic) IBOutlet YQCustomHightLightButton *statusButton;
/**
 *  分割线
 */
@property (weak, nonatomic) IBOutlet UIView *lineView;
@end
