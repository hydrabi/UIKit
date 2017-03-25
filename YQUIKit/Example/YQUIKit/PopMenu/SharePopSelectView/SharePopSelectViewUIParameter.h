//
//  SharePopSelectViewUIParameter.h
//  YQTrack
//
//  Created by 毕志锋 on 15/9/10.
//  Copyright (c) 2015年 17track. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  SharePopSelectViewUI参数
 */
@interface SharePopSelectViewUIParameter : NSObject
SINGLETON_FOR_HEADER(SharePopSelectViewUIParameter)

#pragma mark - SharePopSelectView
/**
 *  SharePopSelectView的坐标X
 */
@property (nonatomic,assign,readonly)CGFloat sharePopSelectView_oringX;

/**
 *  SharePopSelectView的坐标Y
 */
@property (nonatomic,assign,readonly)CGFloat sharePopSelectView_oringY;

/**
 *  SharePopSelectView的宽度
 */
@property (nonatomic,assign,readonly)CGFloat sharePopSelectView_width;

/**
 *  SharePopSelectView的about类型的宽度
 */
@property (nonatomic,assign,readonly)CGFloat sharePopSelectView_aboutWidth;

/**
 *  SharePopSelectView与屏幕右边的距离
 */
@property (nonatomic,assign,readonly)CGFloat sharePopSelectView_trailPadding;

/**
 *  SharePopSelectView与屏幕顶部的距离
 */
@property (nonatomic,assign,readonly)CGFloat sharePopSelectView_topPadding;

/**
 *  SharePopSelectView中tableView的顶部和底部间距
 */
@property (nonatomic,assign,readonly)CGFloat sharePopSelectView_topAndBottomPadding;

#pragma mark - tableView
/**
 *  每一行的高度
 */
@property (nonatomic,assign,readonly)CGFloat tableView_rowHeight;

/**
 *  tableView背景颜色
 */
@property (nonatomic,strong,readonly)UIColor *tableView_backGroundColor;

#pragma mark - tableViewCell

/**
 *  tableViewcell的字体
 */
@property (nonatomic,strong,readonly) UIFont *tableViewCell_titleLabelFont;

/**
 *  tableViewcell的字体颜色
 */
@property (nonatomic,strong,readonly) UIColor *tableViewCell_titleLabelTextColor;

/**
 *  tableViewcell里面的图片透明度
 */
@property (nonatomic,assign,readonly)CGFloat tableViewCell_titleLabelLeadingImageOpacity;

/**
 *  tableViewCell的分割线的左右边距
 */
@property (nonatomic,assign,readonly) CGFloat tableViewCell_separaterLineInset;

@end
