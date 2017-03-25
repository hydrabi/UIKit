//
//  YQPadOrientionChangeViewController.h
//  YQUIKit
//
//  Created by Hydra on 2017/2/17.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQHomePageViewController : UIViewController
@property (nonatomic,weak)IBOutlet UIView *tabBarView;
@property (nonatomic,weak)IBOutlet UIButton *titleButton;
@property (nonatomic,weak)IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@end
