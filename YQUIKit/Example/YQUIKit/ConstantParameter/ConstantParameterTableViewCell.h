//
//  ConstantParameterTableViewCell.h
//  YQUIKit
//
//  Created by Hydra on 2017/3/9.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConstantParameterTableViewCell : UITableViewCell

@property (nonatomic,weak)IBOutlet UILabel *logoLabel;
@property (nonatomic,weak)IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;
@end
