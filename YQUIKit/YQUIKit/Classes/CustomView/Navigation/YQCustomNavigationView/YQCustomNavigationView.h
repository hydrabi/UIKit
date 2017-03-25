//
//  YQCustomNavigationView.h
//  Pods
//
//  Created by Hydra on 2017/2/20.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NavigationItemStyle){
    NavigationStyleEmpty,
    NavigationStyleSidebar,                 /**<侧边栏*/
    NavigationStyleSidebarWithRetDot,       /**<带红点的侧边栏*/
    NavigationStyleShare,                   /**<分享*/
    NavigationStyleSearch,                  /**<搜索*/
    NavigationStyleEdit,                    /**<编辑*/
    NavigationStyleQRCode,                  /**<二维码*/
    NavigationStyleReturn,                  /**<返回*/
    NavigationStyleMenu,                    /**<菜单*/
    NavigationStyleUnSelect,                /**<编辑页面反全选*/
    NavigationStyleSelect,                  /**<编辑页面全选*/
    NavigationStyleEditAliasFinsh,          /**<单号别名编辑完成*/
    NavigationStyleEditAliasCancel,         /**<单号别名编辑取消*/
    NavigationStyleDismiss,                 /**<ipad用dismiss掉页面*/
    NavigationStyleIpadEditAlias,           /**<ipad用编辑单号*/
    NavigationStyleIpadShare,               /**<ipad用分享*/
    NavigationStyleIpadMenu,                /**<ipad用菜单(横向点点点)*/
    NavigationStyleHomeLogo,                /**<首页logo*/
    NavigationStyleHomePortrait,            /**<首页用户头像*/
    NavigationStyleHomeUnLogin,             /**<首页用户未登录*/
    NavigationStyleHomeNotification,        /**<首页推送铃铛*/
    NavigationStyleTitle,                   /**<页面标题*/
    NavigationStyleTabBar,                  /**<tabbar*/
    NavigationStyleCircleCheckBox,          /**<编辑处使用的CheckBox*/
    NavigationStyleAlbum,                   /**<选择图片*/
};

typedef NS_ENUM(NSInteger,NavigationBackgroundStyle) {
    NavigationBackgroundStyleBlue,          /**<蓝色背景风格*/
    NavigationBackgroundStyleWhite          /**<白色背景风格*/
};

//点击回调
typedef void (^NavigationCallBack)(NavigationItemStyle style);

@interface YQCustomNavigationView : UIView
//标题
@property (nonatomic,strong)NSString *title;
//居中的item
@property (nonatomic,strong)UIView *middleItem;
//导航栏图层
@property (nonatomic,strong)UIView *navigationBarView;
//首页导航栏设置
-(void)setHomePageContentsWithParent:(UIViewController*)parent
                               isLogin:(BOOL)isLogin
                            middleType:(NavigationItemStyle)middleType
                               handler:(NavigationCallBack)handler;
//其他页面导航栏设置
-(void)setContentWithParent:(UIViewController*)parent
                        title:(NSString*)title
               leftBtnsType:(NSArray*)leftBtnsType
                   middleType:(NavigationItemStyle)middleType
                rightBtnsType:(NSArray<NSNumber*>*)rightBtnsType
              backgroundStyle:(NavigationBackgroundStyle)backgroundStyle
                      handler:(NavigationCallBack)handler;

/**
 展示阴影
 */
-(void)showShadow;

/**
 隐藏阴影
 */
-(void)hideShadow;

/**
 为导航栏的按钮添加红点

 @param type 按钮的枚举类型
 @param isLeft 是否左边的按钮
 @param withBorder 是否带有border
 @param borderWidth border的宽度
 @param borderColor border的颜色
 @param offset 红点的偏移量 不需要时传入CGPointZero
 @param key 红点的key
 */
-(void)showRedDotWithType:(NavigationItemStyle)type
                   isLeft:(BOOL)isLeft
               withBorder:(BOOL)withBorder
              borderWidth:(CGFloat)borderWidth
              borderColor:(UIColor*)borderColor
                   offset:(CGPoint)offset;

/**
 重新设置左右两边的内容
 
 @param leftBtnsType 左边按钮的枚举
 @param rightBtnsType 右边按钮的枚举
 @param middleStyle 中间视图的枚举
 @param backgroundStyle 背景风格
 */
-(void)resetContentsWithLeftBtnsType:(NSArray*)leftBtnsType
                           rightBtns:(NSArray*)rightBtnsType
                         middleStyle:(NavigationItemStyle)middleStyle
                     backgroundStyle:(NavigationBackgroundStyle)backgroundStyle;

/**
 获取指定枚举类型的item

 @param style 枚举类型
 @param isLeft 左边还是右边的item队列
 @return 指定枚举类型的item
 */
-(UIView*)getItemWithStyle:(NavigationItemStyle)style isLeft:(BOOL)isLeft;
@end
