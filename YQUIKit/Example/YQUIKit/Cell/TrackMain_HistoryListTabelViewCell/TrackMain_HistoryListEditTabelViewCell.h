//
//  TrackMain_HistoryListTabelViewCell.h
//  YQTrack
//
//  Created by 毕志锋 on 15/7/30.
//  Copyright (c) 2015年 17track. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQResourceLib.h"
#import "TrackRecordManager.h"
#import "UITabelViewSeparatorView.h"

/**editCell的类型*/
typedef NS_ENUM(NSInteger, EditTabelViewCellType) {
    EditTabelViewCellType_ActivationOrArchived,    /**<激活或者归档*/
    EditTabelViewCellType_Favorites                /**<收藏*/
};
/**
 *  历史编辑tableviewCell
 */
@interface TrackMain_HistoryListEditTabelViewCell : UITabelViewSeparatorView
/**
 *  当有单号别名的时候显示别名，没有的话显示单号
 */
@property (strong, nonatomic) UILabel *trackNOAliasLabel;
/**
 *  当有单号别名的时候显示单号，没有的话隐藏
 */
@property (strong, nonatomic) UILabel *trackNOLabel;
/**
 *  选择按钮
 */
@property (weak, nonatomic) IBOutlet UILabel *selectLabel;
/**
 *  状态logo
 */
@property (weak, nonatomic) IBOutlet UILabel *logoLabel;
/**
 *  当前cell的类型
 */
@property (assign,nonatomic) EditTabelViewCellType currentCellType;
@property (weak, nonatomic) IBOutlet UIView *notificationTapView;

/**
 *  根据model为cell赋值
 *
 *  @param model 单号模型
 */
-(void)resetValueWithModal:(TrackRecordModel*)model;

/**
 *  是否被选择，以此替换图片
 *
 *  @param result 是否被选择
 */
-(void)setButtonSelected:(BOOL)result;

-(void)resetTrackNoAliasLabelContrainWithTrackNOAlias;
@end
