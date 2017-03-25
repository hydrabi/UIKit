//
//  YQCellViewController.m
//  NUITest
//
//  Created by Hydra on 2017/1/16.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "YQCellViewController.h"
#import "LeftSideTableViewCell.h"
#import "TrackingResultSelectCarrierCell.h"
#import "TrackMain_HistoryListEditTabelViewCell.h"
#import "TrackingResultCarrierCell.h"
#import "YQCustomHightLightButton.h"
#import "YQSectionHeaderView.h"

#import "YQDetailedCarrierTableViewCell.h"
#import "YQDetailedCarrierIconTableViewCell.h"
#import "YQSelectedCarrierTableViewCell.h"
#import "YQSimpleCarrierTableViewCell.h"
#import "YQUnknowCarrierTableViewCell.h"

#import "YQLeadingIconTableViewCell.h"
#import "YQIndicatorTabelViewCell.h"
#import "YQSwitchTableViewCell.h"

#import "YQTrackListSuccessTabelViewCell.h"
#import "YQTrackListFailTabelViewCell.h"
#import "YQTrackListLoadingTableViewCell.h"

static NSString *YQDetailedCarrierTableViewCellIdentifier = @"YQDetailedCarrierTableViewCellIdentifier";
static NSString *YQDetailedCarrierIconTableViewCellReuseIdentifier = @"YQDetailedCarrierIconTableViewCellReuseIdentifier";
static NSString *YQSelectedCarrierTableViewCellReuseIdentifier = @"YQSelectedCarrierTableViewCellReuseIdentifier";
static NSString *YQSimpleCarrierTableViewCellReuseIdentifier = @"YQSimpleCarrierTableViewCellReuseIdentifier";
static NSString *YQUnknowCarrierTableViewCellReuseIdentifier = @"YQUnknowCarrierTableViewCellReuseIdentifier";

static NSString *YQLeadingIconTableViewCellReuseIdentifier = @"YQLeadingIconTableViewCellReuseIdentifier";
static NSString *YQIndicatorTabelViewCellReuseIdentifier = @"YQIndicatorTabelViewCellReuseIdentifier";
static NSString *YQSwitchTableViewCellReuseIdentifier = @"YQSwitchTableViewCellReuseIdentifier";

static NSString *YQTrackListSuccessTabelViewCellReuseIdentifier = @"YQTrackListSuccessTabelViewCellReuseIdentifier";
static NSString *YQTrackListFailTabelViewCellReuseIdentifier = @"YQTrackListFailTabelViewCellReuseIdentifier";
static NSString *YQTrackListLoadingTableViewCellReuseIdentifier = @"YQTrackListLoadingTableViewCellReuseIdentifier";


@interface YQCellViewController ()
@property (nonatomic,strong)NSMutableArray *cellDataArr;
@end

@implementation YQCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self dataSourceConfig];
}

-(void)dataSourceConfig{
    
    NSArray *cellArr1 = @[
                          @"YQDetailedCarrierTableViewCell",
                          ];
    NSArray *cellArr2 = @[
                          @"YQDetailedCarrierIconTableViewCell"
                          ];
    NSArray *cellArr3 = @[
                          @"YQSelectedCarrierTableViewCell"
                          ];
    NSArray *cellArr4 = @[
                          @"YQSimpleCarrierTableViewCell"
                          ];
    NSArray *cellArr5 = @[
                          @"YQUnknowCarrierTableViewCell"
                          ];
    NSArray *cellArr6 = @[
                          @"YQLeadingIconTableViewCell"
                          ];
    NSArray *cellArr7 = @[
                          @"YQIndicatorTabelViewCell"
                          ];
    NSArray *cellArr8 = @[
                          @"YQSwitchTableViewCell"
                          ];
    NSArray *cellArr9 = @[
                          @"YQTrackListSuccessTabelViewCell"
                          ];
    NSArray *cellArr10 = @[
                          @"YQTrackListFailTabelViewCell"
                          ];
    NSArray *cellArr11 = @[
                           @"YQTrackListLoadingTableViewCell"
                           ];
    
    self.cellDataArr = @[
                         cellArr1,
                         cellArr2,
                         cellArr3,
                         cellArr4,
                         cellArr5,
                         cellArr6,
                         cellArr7,
                         cellArr8,
                         cellArr9,
                         cellArr10,
                         cellArr11,
                         ].mutableCopy;
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"YQUIKit" ofType:@"bundle"];
    NSBundle *YQUIKitBundle = [NSBundle bundleWithPath:bundlePath];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQDetailedCarrierTableViewCell class])
                                               bundle:YQUIKitBundle]
         forCellReuseIdentifier:YQDetailedCarrierTableViewCellIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQDetailedCarrierIconTableViewCell class])
                                               bundle:YQUIKitBundle]
         forCellReuseIdentifier:YQDetailedCarrierIconTableViewCellReuseIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQSelectedCarrierTableViewCell class]) bundle:YQUIKitBundle]
         forCellReuseIdentifier:YQSelectedCarrierTableViewCellReuseIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQSimpleCarrierTableViewCell class]) bundle:YQUIKitBundle]
         forCellReuseIdentifier:YQSimpleCarrierTableViewCellReuseIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQUnknowCarrierTableViewCell class]) bundle:YQUIKitBundle]
         forCellReuseIdentifier:YQUnknowCarrierTableViewCellReuseIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQLeadingIconTableViewCell class]) bundle:YQUIKitBundle]
         forCellReuseIdentifier:YQLeadingIconTableViewCellReuseIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQIndicatorTabelViewCell class]) bundle:YQUIKitBundle]
         forCellReuseIdentifier:YQIndicatorTabelViewCellReuseIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQSwitchTableViewCell class]) bundle:YQUIKitBundle]
         forCellReuseIdentifier:YQSwitchTableViewCellReuseIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQTrackListSuccessTabelViewCell class]) bundle:YQUIKitBundle]
         forCellReuseIdentifier:YQTrackListSuccessTabelViewCellReuseIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQTrackListFailTabelViewCell class]) bundle:YQUIKitBundle]
         forCellReuseIdentifier:YQTrackListFailTabelViewCellReuseIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQTrackListLoadingTableViewCell class]) bundle:YQUIKitBundle]
         forCellReuseIdentifier:YQTrackListLoadingTableViewCellReuseIdentifier];
}

#pragma mark - Table view data source

-(NSString*)getSepecificStringIndexPath:(NSIndexPath*)indexPath{
    NSString *result = nil;
    
    if(self.cellDataArr.count>indexPath.section){
        NSArray *arr = self.cellDataArr[indexPath.section];
        result = arr[indexPath.row];
    }
    return result;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.cellDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(self.cellDataArr.count>section){
        NSArray *arr = self.cellDataArr[section];
        return arr.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *normalCell = [[UITableViewCell alloc] init];
    NSString *data = [self getSepecificStringIndexPath:indexPath];
    if([data isEqualToString:@"YQDetailedCarrierTableViewCell"]){
        YQDetailedCarrierTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YQDetailedCarrierTableViewCellIdentifier forIndexPath:indexPath];
        cell.carrierNameLabel.text = @"Afghan Post";
        cell.carrierCountryLabel.text = @"阿富汗";
        [cell.carrierIconImageView setImage:[UIImage imageNamed:@"01021"]];
        return cell;
    }
    else if([data isEqualToString:@"YQDetailedCarrierIconTableViewCell"]){
        YQDetailedCarrierIconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YQDetailedCarrierIconTableViewCellReuseIdentifier
                                                                                   forIndexPath:indexPath];
        cell.carrierLogoLable.text = [YQResourceUIHelper logoForCarrier:@"100012"];
        cell.carrierLogoLable.backgroundColor = [UIColor colorWithHexString:@"231815" alpha:1];
        cell.carrierNameLabel.text = @"顺丰速递";
        cell.carrierCountryLabel.text = @"中国";
        return cell;
    }
    else if([data isEqualToString:@"YQSelectedCarrierTableViewCell"]){
        YQSelectedCarrierTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YQSelectedCarrierTableViewCellReuseIdentifier
                                                                               forIndexPath:indexPath];
        cell.iconLabel.text = [YQResourceUIHelper logoForCarrier:@"100001"];
        cell.iconLabel.backgroundColor = [UIColor colorWithHexString:@"FFCC00" alpha:1];
        cell.carrierNameLabel.text = @"DHL";
        return cell;
    }
    else if([data isEqualToString:@"YQSimpleCarrierTableViewCell"]){
        YQSimpleCarrierTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YQSimpleCarrierTableViewCellReuseIdentifier
                                                                             forIndexPath:indexPath];
        [cell.carrierIconImageView setImage:[UIImage imageNamed:@"01021"]];
        
        cell.carrierNameLabel.text = @"Afghan Post";
        return cell;
    }
    else if([data isEqualToString:@"YQUnknowCarrierTableViewCell"]){
        YQUnknowCarrierTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YQUnknowCarrierTableViewCellReuseIdentifier
                                                                             forIndexPath:indexPath];
        cell.iconLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"F007"];
        cell.firstLineLabel.text = @"China";
        cell.secondLienLabel.text = @"Express";
        return cell;
    }
    else if([data isEqualToString:@"YQLeadingIconTableViewCell"]){
        YQLeadingIconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YQLeadingIconTableViewCellReuseIdentifier
                                                                             forIndexPath:indexPath];
        cell.leadingIconLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"F707"];
        cell.titleLabel.text = @"Edit";
        return cell;
    }
    else if([data isEqualToString:@"YQIndicatorTabelViewCell"]){
        YQIndicatorTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YQIndicatorTabelViewCellReuseIdentifier
                                                                             forIndexPath:indexPath];
        cell.titleLabel.text = @"Cheakit out";
        return cell;
    }
    else if([data isEqualToString:@"YQSwitchTableViewCell"]){
        YQSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YQSwitchTableViewCellReuseIdentifier
                                                                             forIndexPath:indexPath];
        cell.titleLabel.text = @"Turn on";
        return cell;
    }
    else if([data isEqualToString:@"YQTrackListSuccessTabelViewCell"]){
        YQTrackListSuccessTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YQTrackListSuccessTabelViewCellReuseIdentifier
                                                                      forIndexPath:indexPath];
        cell.nameLabel.text = @"70826529389";
        cell.carrierLabel.text = @"Itella Posti";
        cell.eventLabel.text = @"Xabarovsk UKD 680880,Processing,Left";
        cell.detailedTimeLabel.text = @"2015-03-12 12:43";
        NSString *packageState                         = @"20";
        UIColor *iconBgColor                          =[YQResourceUIHelper colorWithPackageState:packageState];
        cell.logoLabel.backgroundColor = iconBgColor;
        cell.logoLabel.text = [YQResourceUIHelper iconFontWithPackageState:[YQResourceUIHelper packageStateFromInteger:packageState.integerValue]];
        return cell;
    }
    else if([data isEqualToString:@"YQTrackListFailTabelViewCell"]){
        YQTrackListFailTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YQTrackListFailTabelViewCellReuseIdentifier
                                                                                forIndexPath:indexPath];
        cell.nameLabel.text = @"qq123";
        cell.carrierLabel.text = @"unknow";
        cell.tipsLabel.text = @"Item is not found at this moment,if necessary";
        NSString *packageState                         = @"00";
        UIColor *iconBgColor                          =[YQResourceUIHelper colorWithPackageState:packageState];
        cell.logoLabel.backgroundColor = iconBgColor;
        cell.logoLabel.text = [YQResourceUIHelper iconFontWithPackageState:[YQResourceUIHelper packageStateFromInteger:packageState.integerValue]];
        return cell;
    }
    else if([data isEqualToString:@"YQTrackListLoadingTableViewCell"]){
        YQTrackListLoadingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YQTrackListLoadingTableViewCellReuseIdentifier
                                                                             forIndexPath:indexPath];
        cell.nameLabel.text = @"EE001542970CM";
        return cell;
    }
    
    return normalCell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *data = [self getSepecificStringIndexPath:indexPath];
    if([data isEqualToString:@"YQTrackListSuccessTabelViewCell"] ||
       [data isEqualToString:@"YQTrackListFailTabelViewCell"]){
        return 122.0f;
    }
    return 72.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0f;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YQSectionHeaderView *header = [[YQSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 44.0f)];
    NSArray *arr = self.cellDataArr[section];
    if(arr.count>0){
        header.titleLabel.text = arr[0];
    }
    return header;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
}

@end
