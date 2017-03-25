//
//  SharePopSelectViewDelegate.h
//  YQTrack
//
//  Created by 毕志锋 on 15/9/10.
//  Copyright (c) 2015年 17track. All rights reserved.
//

typedef NS_ENUM(NSInteger, SharePopSelectTableViewCellType){
    SharePopSelectTableViewCellType_activation = 0, /**<激活编辑栏*/
    SharePopSelectTableViewCellType_achive,         /**<归档编辑栏*/
    SharePopSelectTableViewCellType_favorites,      /**<归档编辑栏*/
    SharePopSelectTableViewCellType_send,
    SharePopSelectTableViewCellType_share,          /**<分享*/
    SharePopSelectTableViewCellType_copyTrackNo,    /**复制单号*/
    SharePopSelectTableViewCellType_copyEditAlias,  /**编辑备注*/
    SharePopSelectTableViewCellType_copyDetails,    /**复制详情*/
    
    SharePopSelectTableViewCellType_about17Track,
    SharePopSelectTableViewCellType_aboutDisclaimer,
    SharePopSelectTableViewCellType_aboutConditions,
    SharePopSelectTableViewCellType_aboutPrivacy,
};

typedef NS_ENUM(NSInteger,SharePopSelectTableViewType) {
    SharePopSelectTableViewType_result,             /**<结果页弹出的菜单*/
    SharePopSelectTableViewType_about,              /**<about页弹出的菜单*/
};

@protocol SharePopSelectViewDelegate <NSObject>

@optional
/**
 *  通知委托点击了的cell的类型
 *
 *  @param cellType SharePopSelectTableViewCellType
 */
-(void)didSelectWithCellType:(SharePopSelectTableViewCellType)cellType;

@end