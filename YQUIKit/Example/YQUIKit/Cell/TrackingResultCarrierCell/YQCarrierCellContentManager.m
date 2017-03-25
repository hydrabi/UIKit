//
//  YQCarrierCellContentManager.m
//  YQUIKit
//
//  Created by Hydra on 2017/3/6.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import "YQCarrierCellContentManager.h"
#import "TrackResultModel.h"
#import "YQResourceLib.h"
#import "TrackRecordManager.h"
#import "YQDetailedCarrierTableViewCell.h"
#import "YQDetailedCarrierIconTableViewCell.h"
#import "YQSimpleCarrierTableViewCell.h"

static NSString *detailedCarrierTableViewCellIdentifier  = @"detailedCarrierTableViewCellIdentifier";
static NSString *simpleCarrierTableViewCellIdentifier = @"simpleCarrierTableViewCellIdentifier";
static NSString *detailedCarrierIconTableViewCellIdentifier  = @"detailedCarrierIconTableViewCellIdentifier";

@interface YQCarrierCellContentManager()
@property (nonatomic,strong)NSString *carrierName;
@property (nonatomic,strong)NSString *countryName;
@property (nonatomic,strong)id iconType;
@end

@implementation YQCarrierCellContentManager

-(void)registerNibWithTableView:(UITableView*)tableView{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"YQUIKit" ofType:@"bundle"];
    NSBundle *YQUIKitBundle = [NSBundle bundleWithPath:bundlePath];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQDetailedCarrierTableViewCell class])
                                          bundle:YQUIKitBundle]
    forCellReuseIdentifier:detailedCarrierTableViewCellIdentifier];
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQSimpleCarrierTableViewCell class])
                                          bundle:YQUIKitBundle]
    forCellReuseIdentifier:simpleCarrierTableViewCellIdentifier];
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQDetailedCarrierIconTableViewCell class])
                                          bundle:YQUIKitBundle]
    forCellReuseIdentifier:detailedCarrierIconTableViewCellIdentifier];
}

-(RACTuple *)dealWithCarrierNumber:(NSNumber*)number{
    NSInteger carrierInteger = [number integerValue];
    NSString *carrierString = @"";
    if(carrierInteger == 0){
        carrierString = @"";
        return RACTuplePack([[ResGTrackRelated __editorCarrier_auto] get],
                            @"",
                            [UIImage imageNamed:@"trackResult_auto"],
                            nil);
    }
    else{
        carrierString = [YQResourceUIHelper carrierFromInteger:carrierInteger];
    }
    
    NSString *carrierName    = @"";
    NSString *countryKey     = @"";
    NSString *countryName    = @"";
    //运输商颜色
    NSString *carrierBackgroundColor = @"";
    id carrierLogo = nil;
    
    if(carrierInteger ==0 || carrierInteger>100000){
        carrierName   = [[ResGExpress _name] get:carrierString];
        carrierBackgroundColor = [[ResGExpress _iconBgColor] get:carrierString];
    }
    else{
        carrierName   = [[ResGCarrier _name] get:carrierString];
        countryKey    = [[ResGCarrier _country] get:carrierString];
    }
    
    if(countryKey.length>0){
        countryName   = [[ResGCountry _name] get:countryKey];
    }
    
    carrierLogo = [YQResourceUIHelper logoForCarrier:carrierString];
    return RACTuplePack(carrierName,
                        countryName,
                        carrierLogo,
                        carrierBackgroundColor);
};

-(RACTuple *)dealWithRecordModel:(TrackRecordModel*)recordModel isDestination:(BOOL)isDestination{
    NSError *error;
    
    TrackResultModel *resultModel = [[TrackResultModel alloc] initWithDictionary:recordModel.trackResult error:&error];
    //目的地或者发件地国家
    NSString *country;
    //运输商查询状态
    NSString *carrierInfoState;
    
    //都需要补0。。。
    if(isDestination){
        if(resultModel.destinationCountry!=0){
            country                      =  [YQResourceUIHelper countryFromInteger:resultModel.destinationCountry];
        }
        carrierInfoState             =   [YQResourceUIHelper infoStateFilterFromInteger:resultModel.secondCarrierInfoState];
        
    }
    else{
        if(resultModel.originCountry!=0){
            country                      =  [YQResourceUIHelper countryFromInteger:resultModel.originCountry];
        }
        carrierInfoState             = [YQResourceUIHelper infoStateFilterFromInteger:resultModel.firstCarrierInfoState];
    }
    
    //状态
//    NSString *iconText;
//    UIColor *bgColor                 = [YQResourceUIHelper colorWithInfoState:carrierInfoState];
//    iconText = [YQResourceUIHelper iconFontWithInfoState:carrierInfoState];
    
    //国家全名
    NSString *countryName;
    if(country.length>0){
        countryName = [[ResGCountry _name] get:country];
    }
    else{
        countryName = [[ResGSystem __gName_enumUnknow] get];
    }
    
    YQResourceLoader *carrierLoder =nil;
    //运输商名称
    NSString *carrierName = @"";
    NSString *carrierKey = @"";
    //运输商颜色
    NSString *carrierBackgroundColor = @"";
    //运输商
    NSInteger carrierNumber;
    if(isDestination){
        carrierNumber = resultModel.secondCarrier;
    }
    else{
        carrierNumber = resultModel.firstCarrier;
    }
    
    carrierKey = [YQResourceUIHelper carrierFromInteger:carrierNumber];
    //大于100000 为express
    if(carrierNumber ==0 || carrierNumber>100000){
        carrierBackgroundColor = [[ResGExpress _iconBgColor] get:carrierKey];
        carrierLoder = [[YQResourceManager sharedSingleton] loaderForClass:[ResGExpress class]];
        carrierName = [[ResGExpress _name] get:carrierKey];
    }
    else{
        carrierLoder = [[YQResourceManager sharedSingleton] loaderForClass:[ResGCarrier class]];
        carrierName = [[ResGCarrier _name] get:carrierKey];
    }
    
    //如果资源不包含该运输商，把该运输商当作0处理
    if(![carrierLoder containKey:carrierKey]){
        carrierName = [[ResGSystem __gName_enumUnknow] get];
        carrierKey = [YQResourceUIHelper carrierFromInteger:0];
    }
    
    id carrierLogo = [YQResourceUIHelper logoForCarrier:carrierKey];
    
    return RACTuplePack(carrierName,
                        countryName,
                        carrierLogo,
                        carrierBackgroundColor);
}

-(UITableViewCell*)getTableViewCellWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath reuseIdentifier:(NSString*)reuseIdentifier carrierNumber:(NSNumber *)carrierNumber{
    NSInteger carrierInteger = [carrierNumber integerValue];
    UITableViewCell *cell = nil;
    //运输商为0，选择自动
    if(carrierInteger == 0){
        __block YQSimpleCarrierTableViewCell *carrierCell = [tableView dequeueReusableCellWithIdentifier:simpleCarrierTableViewCellIdentifier forIndexPath:indexPath];
        cell = (UITableViewCell*)carrierCell;
        RACTupleUnpack(NSString *carrierName,NSString *countryName,id iconType,NSString *iconBackgroundColor) = [self dealWithCarrierNumber:carrierNumber];
        carrierCell.carrierNameLabel.text = carrierName;
        if([iconType isKindOfClass:[UIImage class]]){
            [carrierCell.carrierIconImageView setImage:(UIImage*)iconType];
        }
    }
    else{
        RACTupleUnpack(NSString *carrierName,NSString *countryName,id iconType,NSString *iconBackgroundColor) = [self dealWithCarrierNumber:carrierNumber];
        if([iconType isKindOfClass:[UIImage class]]){
            YQDetailedCarrierTableViewCell *carrierCell = [tableView dequeueReusableCellWithIdentifier:detailedCarrierTableViewCellIdentifier forIndexPath:indexPath];
            carrierCell.carrierNameLabel.text = carrierName;
            carrierCell.carrierCountryLabel.text = countryName;
            [carrierCell.carrierIconImageView setImage:(UIImage*)iconType];
            cell = (UITableViewCell*)carrierCell;
        }
        else{
            YQDetailedCarrierIconTableViewCell *carrierCell = [tableView dequeueReusableCellWithIdentifier:detailedCarrierIconTableViewCellIdentifier
                                                                                              forIndexPath:indexPath];
            carrierCell.carrierNameLabel.text = carrierName;
            carrierCell.carrierCountryLabel.text = countryName;
            carrierCell.carrierLogoLable.text = (NSString*)iconType;
            carrierCell.carrierLogoLable.backgroundColor = [UIColor colorWithHexString:iconBackgroundColor
                                                                                 alpha:1];
            cell = (UITableViewCell*)carrierCell;
        }
    }
    return cell;
}

-(UITableViewCell*)getTableViewCellWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath reuseIdentifier:(NSString*)reuseIdentifier recordModel:(TrackRecordModel*)recordModel isDestination:(BOOL)isDestination{
    UITableViewCell *cell = nil;
    RACTupleUnpack(NSString *carrierName,NSString *countryName,id iconType,NSString *iconBackgroundColor) = [self dealWithRecordModel:recordModel
                                                                                                                        isDestination:isDestination];
    if([iconType isKindOfClass:[UIImage class]]){
        YQDetailedCarrierTableViewCell *carrierCell = [tableView dequeueReusableCellWithIdentifier:detailedCarrierTableViewCellIdentifier forIndexPath:indexPath];
        carrierCell.carrierNameLabel.text = carrierName;
        carrierCell.carrierCountryLabel.text = countryName;
        [carrierCell.carrierIconImageView setImage:(UIImage*)iconType];
        cell = (UITableViewCell*)carrierCell;
    }
    else{
        YQDetailedCarrierIconTableViewCell *carrierCell = [tableView dequeueReusableCellWithIdentifier:detailedCarrierIconTableViewCellIdentifier
                                                                                          forIndexPath:indexPath];
        carrierCell.carrierNameLabel.text = carrierName;
        carrierCell.carrierCountryLabel.text = countryName;
        carrierCell.carrierLogoLable.text = (NSString*)iconType;
        carrierCell.carrierLogoLable.backgroundColor = [UIColor colorWithHexString:iconBackgroundColor
                                                                             alpha:1];
        cell = (UITableViewCell*)carrierCell;
    }
    return cell;
}

@end
