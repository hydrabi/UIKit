//
//  ColorViewController.m
//  NUITest
//
//  Created by Hydra on 2017/1/10.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "YQColorViewController.h"
#import "YQColorView.h"
@interface YQColorViewController ()
@property (nonatomic,strong)IBOutlet UIScrollView *scrollView;
@end

@implementation YQColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIConfig];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)UIConfig{
    NSArray *color1 = @[@"@Color_Blue_900",
                                @"@Color_Blue_800",
                                @"@Color_Blue_700",
                                @"@Color_Blue_600",
                                @"@Color_Blue_500",
                                @"@Color_Blue_400",
                                @"@Color_Blue_300",
                                @"@Color_Blue_200",
                                @"@Color_Blue_100",
                                @"@Color_Blue_50",
                                @"@Color_Blue_A100",
                                @"@Color_Blue_A200",
                                @"@Color_Blue_A300",
                                @"@Color_Blue_A400",
                                ];
    NSArray *color2 = @[@"@Color_Green_900",
                                @"@Color_Green_800",
                                @"@Color_Green_700",
                                @"@Color_Green_600",
                                @"@Color_Green_500",
                                @"@Color_Green_400",
                                @"@Color_Green_300",
                                @"@Color_Green_200",
                                @"@Color_Green_100",
                                @"@Color_Green_50",
                                @"@Color_Green_A100",
                                @"@Color_Green_A200",
                                @"@Color_Green_A400",
                                ];
    NSArray *color3 = @[@"@Color_Amber_900",
                                 @"@Color_Amber_800",
                                 @"@Color_Amber_700",
                                 @"@Color_Amber_600",
                                 @"@Color_Amber_500",
                                 @"@Color_Amber_400",
                                 @"@Color_Amber_300",
                                 @"@Color_Amber_200",
                                 @"@Color_Amber_100",
                                 @"@Color_Amber_50",
                                 @"@Color_Amber_A100",
                                 @"@Color_Amber_A200",
                                 @"@Color_Amber_A400",
                                 ];
    NSArray *color4 = @[ @"@Color_Red_900",
                                @"@Color_Red_800",
                                @"@Color_Red_700",
                                @"@Color_Red_600",
                                @"@Color_Red_500",
                                @"@Color_Red_400",
                                @"@Color_Red_300",
                                @"@Color_Red_200",
                                @"@Color_Red_100",
                                @"@Color_Red_50",
                                @"@Color_Red_A100",
                                @"@Color_Red_A200",
                                @"@Color_Red_A400",
                                ];
    NSArray *color5 = @[ @"@Color_Gray_900",
                                @"@Color_Gray_800",
                                @"@Color_Gray_700",
                                @"@Color_Gray_600",
                                @"@Color_Gray_500",
                                @"@Color_Gray_400",
                                @"@Color_Gray_300",
                                @"@Color_Gray_200",
                                @"@Color_Gray_100",
                                @"@Color_Gray_50",
                         
                                ];
    NSArray *color6 = @[  @"@Color_BlueGray_900",
                                @"@Color_BlueGray_800",
                                @"@Color_BlueGray_700",
                                @"@Color_BlueGray_600",
                                @"@Color_BlueGray_500",
                                @"@Color_BlueGray_400",
                                @"@Color_BlueGray_300",
                                @"@Color_BlueGray_200",
                                @"@Color_BlueGray_100",
                                @"@Color_BlueGray_50",
                                ];
    
    NSArray *colors = @[color1,
                        color2,
                        color3,
                        color4,
                        color5,
                        color6
                        ];
    
    CGFloat rowHeight = 42.0f;
    CGFloat viewHeight = color1.count * rowHeight;
    CGFloat xOffset = 0;
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width)/2;
    
    self.scrollView.contentSize = CGSizeMake(itemWidth * colors.count,viewHeight);
    self.scrollView.scrollsToTop = NO;
    self.scrollView.clipsToBounds = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    for(NSUInteger i = 0;i<colors.count;i++){
        NSArray *color = colors[i];
        YQColorView *colorView = [[YQColorView alloc] initWithColors:color frame:CGRectMake(xOffset, 0, itemWidth - 16, viewHeight)];
        [self.scrollView addSubview:colorView];
        xOffset += itemWidth;
    }
}

@end
