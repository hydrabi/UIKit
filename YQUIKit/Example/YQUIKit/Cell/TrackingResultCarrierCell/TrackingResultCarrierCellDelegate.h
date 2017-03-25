//
//  TrackingResultCarrierCellDelegate.h
//  YQTrack
//
//  Created by 毕志锋 on 15/8/31.
//  Copyright (c) 2015年 17track. All rights reserved.
//

@protocol TrackingResultCarrierCellDelegate <NSObject>

@optional

/**
 *  点击转态图标触发的事件
 *
 *  @param isDestination 是否目的地事件
 */
-(void)statusLabelRegionClickWithIsDestination:(BOOL)isDestination;

/**
 *  跳转到指定的运输商网站
 *
 *  @param url 运输商网站url
 */
-(void)informationImageRegionClickWithUrl:(NSString*)url carrierCode:(NSInteger)code;

@end
