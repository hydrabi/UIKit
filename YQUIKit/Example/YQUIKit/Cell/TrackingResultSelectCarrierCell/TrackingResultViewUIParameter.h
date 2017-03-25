//
//  TrackingResultViewUIParameter.h
//  YQTrack
//
//  Created by 毕志锋 on 15/7/21.
//  Copyright (c) 2015年 17track. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  结果页UI参数
 */
@interface TrackingResultViewUIParameter : NSObject
SINGLETON_FOR_HEADER(TrackingResultViewUIParameter)

#pragma mark - tableView
/**
 *  tableView背景颜色
 */
@property (nonatomic,strong,readonly)UIColor *tableView_BGColor;

/**
 *  单号别名cell的高度
 */
@property (nonatomic,assign,readonly)CGFloat tableView_trackNoAndAliasCellHeigh;
/**
 *  destination或者origin的cell的高度
 */
@property (nonatomic,assign,readonly)CGFloat tableView_sectionHeaderCellHeigh;

/**
 *  运输商cell的高度
 */
@property (nonatomic,assign,readonly)CGFloat tableView_carrierCellHeigh;

/**
 *  选择运输商cell的高度
 */
@property (nonatomic,assign,readonly)CGFloat tableView_mutableCarrierCellHeigh;

/**
 *  包裹提示cell的高度
 */
@property (nonatomic,assign,readonly)CGFloat tableView_packageTipsCellHeigh;

/**
 *  选择运输商cell的高度
 */
@property (nonatomic,assign,readonly)CGFloat tableView_selectCarrierCellHeigh;

/**
 *  分隔cell的高度
 */
@property (nonatomic,assign,readonly)CGFloat tableView_separaterCellHeigh;

/**
 *  分隔cell的高度 20
 */
@property (nonatomic,assign,readonly)CGFloat tableView_eventSeparaterCellHeigh;

/**
 *  resultView里面的tableView实际上是在那顶上五颜六色的页面之下的，为了不被遮盖，所以首个section与顶层的间隔为那五颜六色的页面的高度，与其它section有区别
 */
@property (nonatomic,assign,readonly)CGFloat tableView_firstSectionOffset;

/**
 *  相当于上面的offset少了别名label的高度
 */
@property (nonatomic,assign,readonly)CGFloat tableView_firstSectionOffsetWithoutAlias;

/**
 *  正常的section之间的间隔
 */
@property (nonatomic,assign,readonly)CGFloat tableView_sectionOffset;

#pragma mark - tableViewHeader 结果页的headerView

/**
 *  状态label的字体 18
 */
@property (nonatomic,strong,readonly)UIFont *tableViewHeader_statusLabelFont;

/**
 *  状态label的字体颜色 白色
 */
@property (nonatomic,strong,readonly)UIColor *tableViewHeader_statusLabelTextColor;

/**
 *  备注label的字体 16
 */
@property (nonatomic,strong,readonly)UIFont *tableViewHeader_remarkLabelFont;

/**
 *  备注label的字体颜色 白色
 */
@property (nonatomic,strong,readonly)UIColor *tableViewHeader_remarkLabelTextColor;

/**
 *  单号label的字体 12
 */
@property (nonatomic,strong,readonly)UIFont *tableViewHeader_trackNOLabelFont;

/**
 *  单号label的字体颜色 白色 54%
 */
@property (nonatomic,strong,readonly)UIColor *tableViewHeader_trackNOLabelTextColor;

/**
 *  单号label的字体颜色,没有别名 白色
 */
@property (nonatomic,strong,readonly)UIColor *tableViewHeader_trackNOLabelNormalTextColor;


#pragma mark - tableViewCell sectionHeader

/**
 *  选择多运输商sectionHeader的字体
 */
@property (nonatomic,strong,readonly)UIFont *tableViewCell_sectionHeader_belongToCarrierFont;

/**
 *  选择多运输商sectionHeader的字体颜色
 */
@property (nonatomic,strong,readonly)UIColor *tableViewCell_sectionHeader_belongToCarrierTextColor;


#pragma mark - tableViewCell unKnowCell
/**
 *  未知cell字体
 */
@property (nonatomic,strong,readonly)UIFont *tableViewCell_unknow_LabelFont;
/**
 *  未知cell字体颜色
 */
@property (nonatomic,strong,readonly)UIColor *tableViewCell_unknow_LabelTextColor;


#pragma mark - TranslaterView 结果页底下的翻译footer
/**
 *  整个翻译footer的背景颜色
 */
@property (nonatomic,strong,readonly)UIColor *translate_backgroundColor;

/**
 *  翻译footer左边Label字体
 */
@property (nonatomic,strong,readonly)UIFont *translate_translateLabelFont;

/**
 *  翻译footer左边Label字体颜色
 */
@property (nonatomic,strong,readonly)UIColor *translate_translateLabelTextColor;

/**
 *  选择语言label字体
 */
@property (nonatomic,strong,readonly)UIFont *translate_aimLanguageLabelFont;

/**
 *  选择语言label字体颜色
 */
@property (nonatomic,strong,readonly)UIColor *translate_aimLanguageLabelTextColor;

/**
 *  分割线颜色
 */
@property (nonatomic,strong,readonly)UIColor *translate_lineImageBackGroundColor;
/**
 *  翻译整体高度
 */
@property (nonatomic,assign,readonly)CGFloat translate_viewHeight;
@end
