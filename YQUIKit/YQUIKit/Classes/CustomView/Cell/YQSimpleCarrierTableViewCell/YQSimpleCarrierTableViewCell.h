//
//  YQSimpleCarrierTableViewCell.h
//  Pods
//
//  Created by Hydra on 2017/3/3.
//
//

#import <UIKit/UIKit.h>
#import "YQSeparatorTableViewCell.h"

@interface YQSimpleCarrierTableViewCell : YQSeparatorTableViewCell
/**
 *  用图片的时候显示运输商图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *carrierIconImageView;

/**
 *  运输商名称
 */
@property (weak, nonatomic) IBOutlet UILabel *carrierNameLabel;

/**
 *  分割线
 */
@property (weak, nonatomic) IBOutlet UIView *lineView;
@end
