//
//  SharePopSelectViewUIParameter.m
//  YQTrack
//
//  Created by 毕志锋 on 15/9/10.
//  Copyright (c) 2015年 17track. All rights reserved.
//

#import "SharePopSelectViewUIParameter.h"
#import "UIColor+Addition.h"
@implementation SharePopSelectViewUIParameter
SINGLETON_FOR_CLASS(SharePopSelectViewUIParameter)

-(instancetype)init{
    self = [super init];
    if(self){
        //SharePopSelectView
        _sharePopSelectView_width                    = 180.0f;
        _sharePopSelectView_aboutWidth               = 230.0f;
        _sharePopSelectView_trailPadding             = 8.0f;
        _sharePopSelectView_topPadding               = 28.0f;
        _sharePopSelectView_oringX                   = [[UIScreen mainScreen] bounds].size.width -_sharePopSelectView_width-_sharePopSelectView_trailPadding;
        _sharePopSelectView_oringY                   = DEVICE_IS_IPAD?_sharePopSelectView_topPadding-20: _sharePopSelectView_topPadding;
        _sharePopSelectView_topAndBottomPadding      = 10;
        
        //tableView
        _tableView_rowHeight                         = 44.0f;
        _tableView_backGroundColor                   = [UIColor colorWithHexString:@"efeff4" alpha:1];

        //tableViewCell
        _tableViewCell_titleLabelFont                = [UIFont systemFontOfSize:16];
        _tableViewCell_titleLabelTextColor           = [UIColor colorWithHexString:@"#000000" alpha:0.87];
        _tableViewCell_titleLabelLeadingImageOpacity = 0.54;
        _tableViewCell_separaterLineInset            = 10;

        
    }
    return self;
}

@end
