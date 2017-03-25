//
//  TrackingResultCarrierCell.h
//  YQTrack
//
//  Created by 毕志锋 on 15/7/21.
//  Copyright (c) 2015年 17track. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrackingResultCarrierCellDelegate.h"
#import "UITabelViewSeparatorView.h"

@class TrackRecordModel;
/**
 *  显示运输商和状态的cell
 */
@interface TrackingResultCarrierCell : UITabelViewSeparatorView

/**
 *  当前是否多运输商
 */
@property (nonatomic,assign)BOOL isMutableCarrier;
/**
 *  是否应该展示information图标
 */
@property (nonatomic,assign)BOOL shouldShouldInformation;
/**
 *  carrier的委托
 */
@property (nonatomic,weak)id<TrackingResultCarrierCellDelegate> delegate;

/**
 *  根据单号模型重置属性
 *
 *  @param recordModel   单号模型
 *  @param isDestination yes为目的地，否则为发件地
 */
-(void)resetValueWithRecordModel:(TrackRecordModel*)recordModel isDestination:(BOOL)isDestination;

/**
 *  多运输商事件中，传单运输商代号重置属性
 *
 *  @param number 运输商代号Number
 */
-(void)resetValueWithCarrierNumber:(NSNumber*)number;

/**
 *  是否隐藏分隔线条
 *
 *  @param shouldHide yes 隐藏，否则显示
 */
-(void)hideLineViewWithShouldHide:(BOOL)shouldHide;

/**
 *  在选择运输商的页面不需要特殊处理selectBackGroundView
 */
-(void)hideCustomSelectBackGroundView;

/**
 *  展示官网信息图标
 *
 *  @param number 运输商key
 */
-(void)showOfficialInformationWithCarrierNumber:(NSNumber*)number;
@end
