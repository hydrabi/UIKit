//
//  YQTrackListFailTabelViewCell.h
//  Pods
//
//  Created by Hydra on 2017/3/7.
//
//

#import <UIKit/UIKit.h>
#import "YQCustomHightLightButton.h"
@interface YQTrackListFailTabelViewCell : UITableViewCell
//单号或备注名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//运输商（当有备注的时候包含单号）
@property (weak, nonatomic) IBOutlet UILabel *carrierLabel;
//图标
@property (weak, nonatomic) IBOutlet UILabel *logoLabel;
//菜单按钮
@property (weak, nonatomic) IBOutlet YQCustomHightLightButton *menuButton;
//详细时间
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
//底部分割线
@property (weak,nonatomic)IBOutlet UIView *lineView;
@end
