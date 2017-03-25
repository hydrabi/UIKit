//
//  YQLeadingIconTableViewCell.h
//  Pods
//
//  Created by Hydra on 2017/3/7.
//
//

#import <UIKit/UIKit.h>
#import "YQSeparatorTableViewCell.h"

@interface YQLeadingIconTableViewCell : YQSeparatorTableViewCell
/**
 *  顶部的图片
 */
@property (weak, nonatomic) IBOutlet UILabel *leadingIconLabel;
/**
 *  每一个分栏的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  尾部的v型图片
 */
@property (weak, nonatomic) IBOutlet UILabel *indicatorLabel;
@end
