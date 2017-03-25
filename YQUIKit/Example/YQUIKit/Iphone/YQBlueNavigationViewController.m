//
//  YQBlueNavigationViewController.m
//  YQUIKit
//
//  Created by Hydra on 2017/2/21.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import "YQBlueNavigationViewController.h"
#import "YQCustomNavigationView.h"
#import "YQWhiteNavigationViewController.h"
@interface YQBlueNavigationViewController ()
@property (nonatomic,weak)IBOutlet YQCustomNavigationView *navigationView;
@end

@implementation YQBlueNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationView setContentWithParent:self
                                          title:@"Title"
                                 leftBtnsType:@[@(NavigationStyleReturn)]
                                     middleType:NavigationStyleEmpty
                                  rightBtnsType:@[@(NavigationStyleMenu),
                                                  @(NavigationStyleShare)]
                                backgroundStyle:NavigationBackgroundStyleBlue
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
    [self.navigationController pushViewController:[[YQWhiteNavigationViewController alloc] initWithNibName:NSStringFromClass([YQWhiteNavigationViewController class])
                                                                                                   bundle:nil]
                                         animated:YES];
}

@end
