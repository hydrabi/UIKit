//
//  YQMenuManager.h
//  Pods
//
//  Created by Hydra on 2017/3/1.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,YQMenuType) {
    YQMenuTypeCancel,       /**<取消*/
    YQMenuTypeEdit,         /**<编辑*/
    YQMenuTypeScan,         /**<扫描*/
    YQMenuTypeDonate,       /**<捐献*/
    YQMenuTypeTop,
    YQMenuTypeActivation,
    YQMenuTypeAchive,
    YQMenuTypeDelete,
    YQMenuTypeShare,
    YQMenuTypeCopyTrackNo,
    YQMenuTypeCopyEditAlias,
    YQMenuTypeCopyDetails,
};

@interface YQMenuManager : NSObject
+(NSString*)getIconKeyWithType:(YQMenuType)type;
+(NSString*)getTitleWithType:(YQMenuType)type;
@end
