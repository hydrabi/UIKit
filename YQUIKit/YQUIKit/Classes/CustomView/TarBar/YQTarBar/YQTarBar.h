//
//  YQTarBar.h
//  Pods
//
//  Created by Hydra on 2017/2/22.
//
//

#import <UIKit/UIKit.h>

typedef void (^TabBarCallback) (NSInteger index);

@interface YQTarBar : UIView
@property (nonatomic,assign)NSInteger selectedIndex;

-(void)resetNormalContentWithTitles:(NSArray*)titles callback:(TabBarCallback)callback;
-(void)resetContentWithTitles:(NSArray*)titles backgroundColor:(UIColor*)backgroundColor selectedButtonColor:(UIColor*)selectedButtonColor unSelectedButtonColor:(UIColor*)unSelectedButtonColor lineColor:(UIColor*)lineColor callback:(TabBarCallback)callback;

-(void)resetButtonTitleWithNewTitleArr:(NSArray *)titlesArr;
-(void)showShadow;
-(void)hideShadow;
@end
