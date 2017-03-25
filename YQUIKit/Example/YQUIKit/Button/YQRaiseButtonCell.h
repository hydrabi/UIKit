//
//  YQRaiseButtonCell.h
//  YQUIKit
//
//  Created by Hydra on 2017/2/27.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQShadowButton.h"
@interface YQRaiseButtonCell : UITableViewCell
@property (nonatomic,weak)IBOutlet UILabel *titleLabel;
@property (nonatomic,weak)IBOutlet YQShadowButton *button;
@end
