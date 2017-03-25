//
//  YQEditRecordTableViewCell.h
//  Pods
//
//  Created by Hydra on 2017/3/17.
//
//

#import <UIKit/UIKit.h>
#import "YQCheckBox.h"
/**
 编辑单号cell
 */
@interface YQEditRecordTableViewCell : UITableViewCell
//单号或备注名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//运输商（当有备注的时候包含单号）
@property (weak, nonatomic) IBOutlet UILabel *carrierLabel;
//图标
@property (weak, nonatomic) IBOutlet UILabel *logoLabel;
//选择按钮
@property (weak, nonatomic) IBOutlet YQCheckBox *checkBox;
//底部分割线
@property (weak,nonatomic)IBOutlet UIView *lineView;


@end
