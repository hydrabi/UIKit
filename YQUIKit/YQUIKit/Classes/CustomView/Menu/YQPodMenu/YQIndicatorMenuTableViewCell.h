//
//  YQIndicatorMenuTableViewCell.h
//  Pods
//
//  Created by Hydra on 2017/3/1.
//
//

#import <UIKit/UIKit.h>
#import "YQMenuManager.h"
@interface YQIndicatorMenuTableViewCell : UITableViewCell
/**
 *  顶部的图片
 */
@property (weak, nonatomic) IBOutlet UILabel *leadingLabel;
/**
 *  每一个分栏的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

-(void)resetValueWithMenuType:(YQMenuType)type;
@end
