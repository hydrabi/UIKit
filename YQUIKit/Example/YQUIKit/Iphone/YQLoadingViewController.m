//
//  YQLoadingViewController.m
//  YQUIKit
//
//  Created by Hydra on 2017/2/21.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import "YQLoadingViewController.h"
#import "YQCustomNavigationView.h"
#import "YQRefreshAnimationView.h"
#import "UIColor+Addition.h"
@interface YQLoadingViewController ()
@property (nonatomic,weak)IBOutlet YQCustomNavigationView *navigationView;
@property (nonatomic,strong)YQRefreshAnimationView *animationView;
@property (nonatomic,weak)IBOutlet UIView *backgroundView;
@end

@implementation YQLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setContentWithParent:self
                                          title:@"Title"
                                 leftBtnsType:@[@(NavigationStyleReturn)]
                                     middleType:NavigationStyleEmpty
                                  rightBtnsType:nil
                                backgroundStyle:NavigationBackgroundStyleWhite
                                        handler:^(NavigationItemStyle style){
                                            if(style == NavigationStyleReturn){
                                                [self.navigationController popViewControllerAnimated:YES];
                                            }
                                        }];
    [self.navigationView showShadow];
    
    [self UIConfig];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)UIConfig{
    self.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#f1f3fa" alpha:1];
    self.animationView = [[YQRefreshAnimationView alloc] init];
    [self.backgroundView addSubview:self.animationView];
    @weakify(self)
    [self.animationView makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.equalTo(self.backgroundView.leading);
        make.trailing.equalTo(self.backgroundView.trailing);
        make.top.equalTo(self.backgroundView.top);
        make.height.equalTo(72.0f);
    }];
    [self.animationView performAniamtion];
}

@end
