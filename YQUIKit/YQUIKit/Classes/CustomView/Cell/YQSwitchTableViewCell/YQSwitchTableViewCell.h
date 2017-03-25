//
//  YQSwitchTableViewCell.h
//  Pods
//
//  Created by Hydra on 2017/3/7.
//
//

#import <UIKit/UIKit.h>
#import "YQSeparatorTableViewCell.h"

@interface YQSwitchTableViewCell : YQSeparatorTableViewCell
/**
 *  每一个分栏的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  switch
 */
@property (weak, nonatomic) IBOutlet UISwitch *trailSwitch;
@end
