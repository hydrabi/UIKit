//
//  YQLabelViewController.m
//  YQUIKit
//
//  Created by Halin Lee on 2/17/17.
//  Copyright © 2017 hydrabi. All rights reserved.
//

#import "YQLabelViewController.h"
#import "YQLabelCell.h"
#import "NUISettings.h"
#import "NUIRenderer.h"
#import "YQResourceLib.h"

static NSString *labelCellReuseridentifier = @"labelCellReuseridentifier";
static NSString *iconCellReuseridentifier = @"iconCellReuseridentifier";

@interface YQLabelSection : NSObject
@property (nonatomic,strong) NSString *sectionName;
@property (nonatomic,copy) NSDictionary *sectionItems;
@property (nonatomic,copy) NSArray *orders;
@end
@implementation YQLabelSection
@end

@interface YQLabelViewController ()

@property (nonatomic,strong) NSArray<YQLabelSection *> *dataArr;

@end

@implementation YQLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([YQLabelCell class]) bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:labelCellReuseridentifier];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:iconCellReuseridentifier];

    NSMutableArray *dataArr = [NSMutableArray array];
    
    //配置Label
    YQLabelSection *labelSection = [[YQLabelSection alloc] init];
    labelSection.sectionName = @"Label";
    labelSection.orders = @[
                            @"Label_Large_87",
                            @"Label_Normal_87",
                            @"Label_Small_87",
                            
                            @"Label_Large_54",
                            @"Label_Normal_54",
                            @"Label_Small_54",
                            
                            @"Label_Large_30",
                            @"Label_Normal_30",
                            @"Label_Small_30",
                            
                            @"Label_Bold_SuperLarge_87",
                            @"Label_Bold_Larget_87",
                            @"Label_Bold_Normal_87",
                            @"Label_Bold_Small_87",
                            
                            @"Label_Bold_SuperLarge_54",
                            @"Label_Bold_Larget_54",
                            @"Label_Bold_Normal_54",
                            @"Label_Bold_Small_54",
                            
                            @"Label_Bold_SuperLarge_30",
                            @"Label_Bold_Larget_30",
                            @"Label_Bold_Normal_30",
                            @"Label_Bold_Small_30",
                            ];
    labelSection.sectionItems = [NSDictionary dictionaryWithObjects:labelSection.orders forKeys:labelSection.orders];
    [dataArr addObject:labelSection];
    
    labelSection = [[YQLabelSection alloc] init];
    labelSection.sectionName = @"Icon Label";
    labelSection.orders = @[@"Label_Icon_Normal",
                            @"Label_Icon_Radius",
                            @"Label_Icon_Carrier"];
    labelSection.sectionItems = @{@"Label_Icon_Normal":@"Label_Icon_Normal",
                                  @"Label_Icon_Radius":@"Label_Icon_Normal:Label_Icon_Radius",
                                  @"Label_Icon_Carrier":@"Label_Icon_Normal:Label_Icon_Radius:Label_Icon_Carrier"};
    [dataArr addObject:labelSection];
    
    


    self.dataArr = dataArr;
    self.tableView.rowHeight = 56.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr[section].orders.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YQLabelCell *cell;
    switch (indexPath.section) {
        case 0:
            cell = [self.tableView dequeueReusableCellWithIdentifier:labelCellReuseridentifier];
            break;
            
        case 1:
            cell = [self.tableView dequeueReusableCellWithIdentifier:iconCellReuseridentifier];
            break;
    }
    
    
    cell.contentLabel.backgroundColor = [UIColor clearColor];
    
    YQLabelSection *section = self.dataArr[indexPath.section];
    NSString *className = section.orders[indexPath.row];
    cell.nameLabel.text = className;

    NSString *nuiClass = section.sectionItems[className];
    [NUIRenderer renderLabel:cell.contentLabel withClass:nuiClass];
    
    switch (indexPath.section) {
        case 0:
            [self setLabelCell:cell withRow:indexPath.row];
            break;
        case 1:
            [self setIconCell:cell withRow:indexPath.row];
            break;
        default:
            break;
    }
    [cell.nameLabel sizeToFit];
    [cell.contentView layoutIfNeeded];
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.dataArr[section].sectionName;
}

- (void)setLabelCell:(YQLabelCell *)cell withRow:(NSInteger)row{
    cell.contentLabel.text = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";

}

- (void)setIconCell:(YQLabelCell *)cell withRow:(NSInteger)row{

    
    
    switch (row) {
            
        case 0:
        case 1:{
            NSString *key = [YQResourceUIHelper packageStateFromInteger:0];
            cell.contentLabel.text = [YQResourceUIHelper iconFontWithPackageState:key];
            cell.contentLabel.backgroundColor = [YQResourceUIHelper colorWithPackageState:key];
 
            break;
        }
        case 2:{
            NSString *key = [YQResourceUIHelper carrierFromInteger:100012];
            cell.contentLabel.text = [YQResourceUIHelper logoForCarrier:key];
            NSString *backgroundColorStr = [[ResGExpress _iconBgColor] get:key];
            cell.contentLabel.backgroundColor = [UIColor colorWithHexString:backgroundColorStr alpha:1];
        }
            
            
        default:
            break;
    }
}

@end
