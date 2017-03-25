//
//  YQWhiteNavigationViewController.m
//  YQUIKit
//
//  Created by Hydra on 2017/2/21.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import "YQWhiteNavigationViewController.h"
#import "YQCustomNavigationView.h"
#import "YQLoadingViewController.h"
@interface YQWhiteNavigationViewController ()
@property (nonatomic,weak)IBOutlet YQCustomNavigationView *navigationView;
@end

@implementation YQWhiteNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationView setContentWithParent:self
                                          title:@"Title"
                                 leftBtnsType:@[@(NavigationStyleReturn)]
                                     middleType:NavigationStyleEmpty
                                  rightBtnsType:@[@(NavigationStyleMenu),
                                                  @(NavigationStyleEdit)]
                                backgroundStyle:NavigationBackgroundStyleWhite
                                        handler:^(NavigationItemStyle style){
                                            if(style == NavigationStyleReturn){
                                                [self.navigationController popViewControllerAnimated:YES];
                                            }
                                        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)nextPageAction:(id)sender{
    [self.navigationController pushViewController:[[YQLoadingViewController alloc] initWithNibName:NSStringFromClass([YQLoadingViewController class])
                                                                                                    bundle:nil]
                                         animated:YES];
}

@end
