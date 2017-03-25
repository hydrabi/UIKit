//
//  YQIndicatorTabelViewCell.h
//  Pods
//
//  Created by Hydra on 2017/3/7.
//
//

#import <UIKit/UIKit.h>
#import "YQSeparatorTableViewCell.h"

@interface YQIndicatorTabelViewCell : YQSeparatorTableViewCell
/**
 *  每一个分栏的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  尾部的v型图片
 */
@property (weak, nonatomic) IBOutlet UILabel *indicatorLabel;
@end
