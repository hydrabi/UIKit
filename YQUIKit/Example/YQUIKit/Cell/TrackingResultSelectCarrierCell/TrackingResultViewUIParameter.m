//
//  TrackingResultViewUIParameter.m
//  YQTrack
//
//  Created by 毕志锋 on 15/7/21.
//  Copyright (c) 2015年 17track. All rights reserved.
//

#import "TrackingResultViewUIParameter.h"
#import "UIColor+Addition.h"

@implementation TrackingResultViewUIParameter
SINGLETON_FOR_CLASS(TrackingResultViewUIParameter)
-(instancetype)init{
    self = [super init];
    if(self){
        
        //tableView
        _tableView_BGColor                                    = [UIColor colorWithHexString:@"efeff4" alpha:1];
        _tableView_trackNoAndAliasCellHeigh                   = 76.0f;
        _tableView_carrierCellHeigh                           = 64.0f;
        _tableView_mutableCarrierCellHeigh                    = _tableView_carrierCellHeigh;
        _tableView_sectionHeaderCellHeigh                     = 32.0f;
        _tableView_selectCarrierCellHeigh                     = 64.0f;
        _tableView_firstSectionOffset                         = 172.0f;
        _tableView_firstSectionOffsetWithoutAlias             = 152.0f;
        _tableView_sectionOffset                              = 16.0f;
        _tableView_packageTipsCellHeigh                       = 66.0f;
        _tableView_separaterCellHeigh                         = 16.0f;
        _tableView_eventSeparaterCellHeigh                    = 20.0f;


        //tableViewHeader 结果页的headerView
        _tableViewHeader_statusLabelFont                      = [UIFont systemFontOfSize:18];
        _tableViewHeader_statusLabelTextColor                 = [UIColor whiteColor];
        _tableViewHeader_remarkLabelFont                      = [UIFont systemFontOfSize:14];
        _tableViewHeader_remarkLabelTextColor                 = [UIColor whiteColor];
        _tableViewHeader_trackNOLabelFont                     = [UIFont systemFontOfSize:16];
        _tableViewHeader_trackNOLabelTextColor                = [UIColor colorWithHexString:@"#ffffff" alpha:1];
        _tableViewHeader_trackNOLabelNormalTextColor          = [UIColor colorWithHexString:@"#ffffff" alpha:1];


        //tableViewCell sectionHeader
        _tableViewCell_sectionHeader_belongToCarrierFont      = [UIFont systemFontOfSize:14];
        _tableViewCell_sectionHeader_belongToCarrierTextColor = [UIColor colorWithHexString:@"#000000" alpha:0.54];

        //tableViewCell unKnowCell
        _tableViewCell_unknow_LabelFont                       = [UIFont systemFontOfSize:14];
        _tableViewCell_unknow_LabelTextColor                  = [UIColor colorWithHexString:@"#000000" alpha:0.87];


        //TranslaterView 结果页底下的翻译footer
        _translate_backgroundColor                            = [UIColor colorWithHexString:@"#efeff4" alpha:1];
        _translate_translateLabelFont                         = [UIFont systemFontOfSize:14];
        _translate_translateLabelTextColor                    = [UIColor colorWithHexString:@"#000000" alpha:0.87];
        _translate_aimLanguageLabelFont                       = [UIFont systemFontOfSize:14];
        _translate_aimLanguageLabelTextColor                  = [UIColor colorWithHexString:@"003a9b" alpha:1];
        _translate_lineImageBackGroundColor                   = [UIColor colorWithHexString:@"#DFDFDF" alpha:1];
        _translate_viewHeight                                 = 44.0f;
    }
    return self;
}
@end
