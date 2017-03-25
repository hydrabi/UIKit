//
//  YQCheckBoxViewController.m
//  YQUIKit
//
//  Created by Hydra on 2017/2/28.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import "YQCheckBoxViewController.h"
#import "YQUIDefinitions.h"
@interface YQCheckBoxViewController ()

@end

@implementation YQCheckBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.squreCheckBox.checkBoxType = YQCheckBoxTypeSquare;
    self.mySwitch.onTintColor = [YQUIDefinitions getColor:@"@Color_Oriange"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
