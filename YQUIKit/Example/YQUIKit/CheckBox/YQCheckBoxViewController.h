//
//  YQCheckBoxViewController.h
//  YQUIKit
//
//  Created by Hydra on 2017/2/28.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQCheckBox.h"
@interface YQCheckBoxViewController : UIViewController
@property (nonatomic,weak)IBOutlet YQCheckBox *circleCheckBox;
@property (nonatomic,weak)IBOutlet YQCheckBox *squreCheckBox;
@property (nonatomic,weak)IBOutlet UISwitch *mySwitch;
@end
