//
//  YQPadHomePageViewController.m
//  YQUIKit
//
//  Created by Hydra on 2017/2/22.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import "YQPadHomePageViewController.h"
#import "YQCustomNavigationView.h"
#import "YQPadHomePageCollectionViewCell.h"
#import "UIScreen+IPad.h"
#import "YQTarBar.h"
#import "YQFloatButton.h"
#import "LCActionSheet.h"
#import "YQBottmMenu.h"
static NSString *cellReuseIdentifier = @"cellReuseIdentifier";

@interface YQPadHomePageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,LCActionSheetDelegate>
@property (nonatomic,weak)IBOutlet YQCustomNavigationView *navigationView;
@property (nonatomic,weak)IBOutlet YQTarBar *tabBar;
@property (nonatomic,weak)IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabbarTopConstraint;
@property (nonatomic,weak)YQTarBar *topTabbar;
@end

@implementation YQPadHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    //隐藏导航栏后要把这个关闭，否则会自动调整scrollview的topInset
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.navigationView setHomePageContentsWithParent:self
                                                 isLogin:YES
                                              middleType:NavigationStyleTabBar
                                                 handler:^(NavigationItemStyle style){
                                                     if(style == NavigationStyleMenu){

                                                         YQBottmMenu *menu = [YQBottmMenu homeMenuWithCallback:^(YQMenuType index){
                                                             
                                                         }];
                                                         [menu show];
                                                     }
                                                     else if(style == NavigationStyleHomeNotification){
                                                         [self.navigationController popViewControllerAnimated:YES];
                                                         self.navigationController.navigationBar.hidden = NO;
                                                     }
                                                 }];
    
    if([self.navigationView.middleItem isKindOfClass:[YQTarBar class]]){
        self.topTabbar = (YQTarBar*)self.navigationView.middleItem;
        RACChannelTo(self,tabBar.selectedIndex,@(0)) = RACChannelTo(self.topTabbar,selectedIndex,@(0));
    }
    
    [self.tabBar resetNormalContentWithTitles:@[@"Shipment",
                                                @"Archive"]
                                     callback:^(NSInteger index){
                                         
                                     }];
    
    [self.view sendSubviewToBack:self.collectionView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YQPadHomePageCollectionViewCell class])
                                                    bundle:nil]
          forCellWithReuseIdentifier:cellReuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    if([UIScreen orientationIsPortrait]){
        self.topTabbar.hidden = YES;
        self.tabbarTopConstraint.constant = 0;
        [self.navigationView hideShadow];
        [self.tabBar showShadow];
        
    }
    else{
        self.topTabbar.hidden = NO;
        self.tabbarTopConstraint.constant = -CGRectGetHeight(self.tabBar.frame);
        [self.navigationView showShadow];
        [self.tabBar hideShadow];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YQPadHomePageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier                                                   forIndexPath:indexPath];
    cell.titleLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = CGRectGetWidth(collectionView.frame);
    CGFloat cellWidth = (width-16*3)/2;
    if([UIScreen orientationIsPortrait]){
        return CGSizeMake(cellWidth, 122);
    }
    else{
        return CGSizeMake(375, 122);
    }
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if([UIScreen orientationIsPortrait]){
        return UIEdgeInsetsMake(16, 16, 16, 16);
    }
    else{
        CGFloat leftOffset = (CGRectGetWidth(collectionView.frame)-375*2-16)/2;
        return UIEdgeInsetsMake(16, leftOffset, 16, leftOffset);
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 16.0f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0f;
}


@end
