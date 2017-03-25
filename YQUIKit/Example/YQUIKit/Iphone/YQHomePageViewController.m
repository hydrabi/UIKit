//
//  YQPadOrientionChangeViewController.m
//  YQUIKit
//
//  Created by Hydra on 2017/2/17.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import "YQHomePageViewController.h"
#import "YQCustomNavigationView.h"
#import "YQBlueNavigationViewController.h"
#import "YQUIDefinitions.h"

@interface YQHomePageViewController ()
@property (nonatomic,weak)IBOutlet YQCustomNavigationView *navigationView;
@end

@implementation YQHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景透明并去除分割线
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.hidden = YES;

    [self.navigationView setHomePageContentsWithParent:self
                                               isLogin:YES
                                            middleType:NavigationStyleEmpty handler:^(NavigationItemStyle style){
                                                
                                            }];
    
    [self.navigationView showRedDotWithType:NavigationStyleHomeNotification
                                     isLeft:NO
                                 withBorder:NO
                                borderWidth:0
                                borderColor:nil
                                     offset:CGPointMake(-10, 10)];
    
    [self.navigationView showRedDotWithType:NavigationStyleHomePortrait
                                     isLeft:NO
                                 withBorder:YES
                                borderWidth:1.0f
                                borderColor:[YQUIDefinitions getColor:@"@Color_White"]
                                     offset:CGPointMake(-10, 10)];
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if(orientation == UIInterfaceOrientationPortrait ||
       orientation == UIInterfaceOrientationPortraitUpsideDown){
        self.topConstraint.constant = 64;
        self.titleButton.hidden = YES;
    }
    else{
        self.topConstraint.constant = 0;
        self.titleButton.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)returnAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.hidden = NO;
}

-(IBAction)nextPageAction:(id)sender{
    [self.navigationController pushViewController:[[YQBlueNavigationViewController alloc] initWithNibName:NSStringFromClass([YQBlueNavigationViewController class])
                                                                                                   bundle:nil]
                                         animated:YES];
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if(toInterfaceOrientation == UIInterfaceOrientationPortrait ||
       toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
        self.topConstraint.constant = 64;
        self.titleButton.hidden = YES;
    }
    else{
        self.topConstraint.constant = 0;
        self.titleButton.hidden = NO;
    }
}

@end
