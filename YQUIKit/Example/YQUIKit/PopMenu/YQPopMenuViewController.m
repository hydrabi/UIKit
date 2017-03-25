//
//  YQPopMenuViewController.m
//  NUITest
//
//  Created by Hydra on 2017/1/17.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "YQPopMenuViewController.h"
#import "YQIndicatorPopMenu.h"
#import "YQResourceLib.h"
#import "YQBottmMenu.h"
@interface YQPopMenuViewController ()
@end

@implementation YQPopMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self UIConfig];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)UIConfig{
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.button1 addTarget:self
                     action:@selector(showMenu)
           forControlEvents:UIControlEventTouchUpInside];
    self.button1.titleLabel.font = [UIFont fontWithName:iconFontName size:24.0f];
    [self.button1 setTitle: [YQResourceUIHelper iconFontWithCommonState:@"F02C"]
                      forState:UIControlStateNormal];
    
    self.button2.titleLabel.font = [UIFont fontWithName:iconFontName size:24.0f];
    [self.button2 setTitle: [YQResourceUIHelper iconFontWithCommonState:@"F02C"]
                  forState:UIControlStateNormal];
    
}

-(void)showMenu{
    
    YQBottmMenu *menu = [YQBottmMenu homeMenuWithCallback:^(YQMenuType index){
        
    }];
    [menu show];
    
}

-(IBAction)showMenu1:(UIButton*)button{
    CGPoint point = CGPointMake(CGRectGetMaxX(button.frame),
                                CGRectGetMinY(button.frame));
    CGPoint anotherPoint = [button.superview convertPoint:point
                                            toView:self.navigationController.view];
    YQIndicatorPopMenu *pop = [[YQIndicatorPopMenu alloc] initWithParentView:self.navigationController.view
                                                            topRight:anotherPoint
                                                                 bottomRight:CGPointZero
                                                                   menuTypes:@[@(YQMenuTypeCancel),                       @(YQMenuTypeEdit),                             @(YQMenuTypeScan),                            @(YQMenuTypeDonate),]
                                                               width:180
                                                            callback:^(NSInteger index){
                                                                
                                                            }];
    [pop showPopView];
}

@end
