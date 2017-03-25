//
//  YQMenuManager.m
//  Pods
//
//  Created by Hydra on 2017/3/1.
//
//

#import "YQMenuManager.h"
#import "YQResourceLib.h"
@implementation YQMenuManager

#pragma mark - 响应indexpath的图片或者文字
//返回特定行的图片
+(NSString*)getIconKeyWithType:(YQMenuType)type{
    NSString *result = @"";
    
    switch (type) {
        case YQMenuTypeCancel:
        {
            result = @"F00E";
        }
            break;
        case YQMenuTypeEdit:
        {
            result = @"F707";
        }
            break;
        case YQMenuTypeScan:
        {
            result = @"F01B";
        }
            break;
        case YQMenuTypeDonate:
        {
            result = @"F04B";
        }
            break;
        case YQMenuTypeTop:
        {
            result = @"F029";
        }
            break;
        case YQMenuTypeActivation:
        {
            result = @"F026";
        }
            break;
        case YQMenuTypeAchive:
        {
            result = @"F031";
        }
            break;
        case YQMenuTypeDelete:
        {
            result = @"F012";
        }
            break;
        case YQMenuTypeShare:
        {
            result = @"F022";
        }
            break;
        case YQMenuTypeCopyTrackNo:
        {
            result = @"F01C";
        }
            break;
        case YQMenuTypeCopyEditAlias:
        {
            result = @"F708";
        }
            break;
        case YQMenuTypeCopyDetails:
        {
            result = @"F706";
        }
            break;
            
        default:
            break;
    }

    return result;
}

//返回特定行的标题
+(NSString*)getTitleWithType:(YQMenuType)type{
    NSString *result = @"";
    switch (type) {
        case YQMenuTypeCancel:
            result = [[ResGSystem __gButton_cancel] get];
            break;
        case YQMenuTypeEdit:
            result = [[ResGSystem __gButton_edit] get];
            break;
        case YQMenuTypeScan:
            result = [[ResV5AppWord __scan_title] get];
            break;
        case YQMenuTypeDonate:
            result = [[ResGDonate __btn_donate] get];
            break;
        case YQMenuTypeTop:
            result = [[ResV5AppWord __operation_item_toTop] get];
            break;
        case YQMenuTypeActivation:
            result = [[ResV5AppWord __main_tabActivation] get];
            break;
        case YQMenuTypeAchive:
            result = [[ResV5AppWord __main_tabArchived] get];
            break;
        case YQMenuTypeDelete:
            result = [[ResGSystem __gButton_delete] get];
            break;
        case YQMenuTypeShare:
            result = [[ResV5AppWord __more_share] get];
            break;
        case YQMenuTypeCopyTrackNo:
            result = [[ResGTrackRelated __toolCopy_copyNumber] get];
            break;
        case YQMenuTypeCopyEditAlias:
            result = [[ResV5AppWord __memo_title] get];
            break;
        case YQMenuTypeCopyDetails:
            result = [[ResGTrackRelated __toolCopy_copyDetails] get];
            break;

        default:
            break;
    }
    
    return result;
}

@end
