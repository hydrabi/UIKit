//
//  SharePopSelectView.h
//  YQTrack
//
//  Created by 毕志锋 on 15/9/10.
//  Copyright (c) 2015年 17track. All rights reserved.
//  点击share按钮弹出的分享页面

#import <UIKit/UIKit.h>
#import "SharePopSelectViewDelegate.h"
#import "YQResourceLib.h"
#import "TrackRecordManager.h"

@interface SharePopSelectView : UIView<UITableViewDataSource,UITableViewDelegate>

/**
 *  SharePopSelectView的回调委托
 */
@property (weak,nonatomic)id<SharePopSelectViewDelegate> delegate;

/**
 *  创建share展示页实例
 *
 *  @param parent 在那个视图上展示
 *
 *  @param model 单号模型
 *
 *  @return share展示页实例
 */
+(instancetype)instanceSharePopSelectViewWithParentView:(UIView*)parent model:(TrackRecordModel*)model tableViewType:(SharePopSelectTableViewType)tableViewType;

/**
 *  初始化的时候配置
 */
-(void)configSelectView;

/**
 *  展示sharePopView
 */
-(void)showSharePopView;

/**
 *  隐藏sharePopView
 */
-(void)hideSharePopView;

/**
 *  配置UI
 */
-(void)configUI;

@end
