//
//  YQBottmMenu.h
//  Pods
//
//  Created by Hydra on 2017/2/24.
//
//

#import <UIKit/UIKit.h>
#import "YQMenuManager.h"


//选择后的回调
typedef void (^BottomMenuCallback)(NSInteger selectedIndex);

@interface YQBottmMenu : UIView

/**
 展示底部菜单
 */
-(void)show;

/**
 首页底部菜单

 @param callback 点击菜单的某一项返回的回调，参数为BottomMenuType，即选择的类型
 @return YQBottmMenu实例
 */
+(id)homeMenuWithCallback:(BottomMenuCallback)callback;

/**
 自定义底部菜单

 @param callback 点击菜单的某一项返回的回调，参数为BottomMenuType，即选择的类型
 @param types 可选参数，以@(BottomMenuTypeCancel),@(BottomMenuTypeEdit),nil的方式传入
 @return YQBottmMenu实例
 */
+(id)menuWithCallback:(BottomMenuCallback)callback menuTypes:(NSNumber*)types,... NS_REQUIRES_NIL_TERMINATION;

/**
 自定义底部菜单

 @param callback 点击菜单的某一项返回的回调，参数为BottomMenuType，即选择的类型
 @param types 将类型以数组的形式传入
 @return YQBottmMenu实例
 */
-(id)initWithCallback:(BottomMenuCallback)callback menuTypes:(NSMutableArray*)types;
@end
