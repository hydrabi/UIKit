//
//  YQBasicPodMenu.h
//  Pods
//
//  Created by Hydra on 2017/3/1.
//
//

#import <UIKit/UIKit.h>
#import "YQMenuManager.h"
typedef void(^PopMenuCallback)(NSInteger index);

@interface YQBasicPopMenu : UIView

/**
 tableview
 */
@property (nonatomic,strong)UITableView *tableView;

/**
 选项类型队列
 */
@property (nonatomic,strong)NSArray *menuTypesArr;

/**
 回调函数
 */
@property (nonatomic,copy)PopMenuCallback callback;

/**
 触发弹出菜单的父视图
 */
@property (nonatomic,weak)UIView *parentView;

/**
 右上角坐标位置
 */
@property (nonatomic,assign)CGPoint topRight;

/**
 右下角坐标位置
 */
@property (nonatomic,assign)CGPoint bottomRight;

/**
 宽度
 */
@property (nonatomic,assign)CGFloat width;

/**
 创建弹出菜单的实例
 
 @param parentView 需要展示弹出菜单的父视图
 @param topRight 菜单右上角的位置，需要自己计算
 @param bottomRight 菜单右下角的位置，需要自己计算，如果遇到需要弹出menu的位置在屏幕较底部，使用这个,不需要的那个设置为CGPointZero
 @param menuTypes 枚举的类型
 @param width 菜单的宽度
 @param callback 回调
 @return 弹出菜单的实例
 */
+(instancetype)menuWithParentView:(UIView*)parentView
                         topRight:(CGPoint)topRight
                      bottomRight:(CGPoint)bottomRight
                        menuTypes:(NSArray*)menuTypes
                            width:(CGFloat)width
                         callback:(PopMenuCallback)callback;

/**
 创建弹出菜单的实例

 @param parentView 需要展示弹出菜单的父视图
 @param topRight 菜单右上角的位置，需要自己计算
 @param bottomRight 菜单右下角的位置，需要自己计算，如果遇到需要弹出menu的位置在屏幕较底部，使用这个，不需要的那个设置为CGPointZero
 @param menuTypes 枚举的类型
 @param width 菜单的宽度
 @param callback 回调
 @return 弹出菜单的实例
 */
-(instancetype)initWithParentView:(UIView*)parentView
                         topRight:(CGPoint)topRight
                      bottomRight:(CGPoint)bottomRight
                        menuTypes:(NSArray*)menuTypes
                            width:(CGFloat)width
                         callback:(PopMenuCallback)callback;

/**
 展示菜单
 */
-(void)showPopView;

/**
 隐藏菜单
 */
-(void)hidePopView;

/**
 配置UI
 */
-(void)UIConfig;

@end
