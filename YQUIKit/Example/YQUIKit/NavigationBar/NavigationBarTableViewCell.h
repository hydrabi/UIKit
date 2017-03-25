//
//  NavigationBarTableViewCell.h
//  YQUIKit
//
//  Created by Hydra on 2017/3/9.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQCustomNavigationView.h"
@interface NavigationBarTableViewCell : UITableViewCell
@property (nonatomic,weak)IBOutlet YQCustomNavigationView *navigationView;
@end
