//
//  YQFontTableViewController.m
//  NUITest
//
//  Created by Hydra on 2017/1/10.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "YQFontTableViewController.h"
#import "NUISettings.h"
#import "NUIRenderer.h"
#import "YQRadiusLabelTableViewCell.h"
#import "UIColor+Addition.h"
#import "YQResourceLib.h"
#import "YQUIDefinitions.h"

static NSString *cellReuserIdentifier = @"cellReuserIdentifier";
static NSString *radiusCellReuseridentifier = @"radiusCellReuseridentifier";
static NSString *headerReuseridentifier = @"headerReuseridentifier";

@interface YQFontTableViewController ()
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)NSMutableArray *headerArr;
@property (nonatomic,strong)NSMutableArray *carrierArr;
@property (nonatomic,strong)NSMutableArray *infoArr;
@end

@implementation YQFontTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self UIConfig];
    [self dataSourceConfig];
}

-(void)UIConfig{
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:cellReuserIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQRadiusLabelTableViewCell class]) bundle:nil]
         forCellReuseIdentifier:radiusCellReuseridentifier];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:headerReuseridentifier];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)dataSourceConfig{
    self.dataArr = @[].mutableCopy;
    NSArray *arr1 = @[
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
    NSArray *arr2 = @[
                      @"0",
                      @"10",
                      @"20",
                      @"30",
                      @"40",
                      @"50",
                      ];
    [self.dataArr addObject:arr1];
    [self.dataArr addObject:arr2];
    
    self.headerArr = @[@"normalLabel",
                       @"logoLabel"].mutableCopy;
    
    YQResourceLoader *expressLoader  = [[YQResourceManager sharedSingleton] loaderForClass:[ResGExpress class]];
    //所有的键
    NSArray *allKeys                 = [expressLoader itemKeys];
    //存放国际邮政
    NSMutableArray *internationalArr = [[NSMutableArray alloc] init];
    //存放国内邮政
    NSMutableArray *chineseArr       = [[NSMutableArray alloc] init];
    for(NSString *key in allKeys){
        //国际
        if([key integerValue] < 190001){
            //不包括全球Global Postal
            if([key integerValue]>0){
                [internationalArr addObject:key];
            }
        }
        //国内
        else{
            [chineseArr addObject:key];
        }
    }
    self.carrierArr        = internationalArr;
    
    self.infoArr = @[
                     @"00",
                     @"01",
                     @"02",
                     @"10",
                     @"11",
                     @"12",
                     ].mutableCopy;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSString*)getSepecificStringIndexPath:(NSIndexPath*)indexPath{
    NSString *result = nil;
    
    if(self.dataArr.count>indexPath.section){
        NSArray *arr = self.dataArr[indexPath.section];
        result = arr[indexPath.row];
    }
    return result;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(self.dataArr.count>section){
        NSArray *arr = self.dataArr[section];
        return arr.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        return 80;
    }
    
    return 44;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *header =  [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerReuseridentifier];
    header.textLabel.text = self.headerArr[section];
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if(indexPath.section == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuserIdentifier
                                                                forIndexPath:indexPath];
        NSString *class = [self getSepecificStringIndexPath:indexPath];
        if(class.length>0){
            [NUIRenderer renderLabel:cell.textLabel withClass:class];
            if(self.dataArr.count>indexPath.section){
                NSArray *arr = self.dataArr[indexPath.section];
                cell.textLabel.text = arr[indexPath.row];
            }
            
        }
        return cell;
    }
    else{
        YQRadiusLabelTableViewCell *radiusCell = [tableView dequeueReusableCellWithIdentifier:radiusCellReuseridentifier
                                                                forIndexPath:indexPath];
        
        NSString *data = [self getSepecificStringIndexPath:indexPath];
        NSInteger packageState = [data integerValue];
        data = [YQResourceUIHelper packageStateFromInteger:packageState];
        radiusCell.logoLabel.text = [YQResourceUIHelper iconFontWithPackageState:[YQResourceUIHelper packageStateFromInteger:packageState]];
        radiusCell.logoLabel.backgroundColor = [YQResourceUIHelper colorWithPackageState:data];
        radiusCell.normalLogoLabel.text = [YQResourceUIHelper iconFontWithPackageState:[YQResourceUIHelper packageStateFromInteger:packageState]];
        radiusCell.normalLogoLabel.backgroundColor = [YQResourceUIHelper colorWithPackageState:data];
        
        
        NSInteger carrierNumber = [self.carrierArr[indexPath.row] integerValue];
        NSString *carrierString = @"";
        carrierString = [YQResourceUIHelper carrierFromInteger:carrierNumber];
        NSString *carrierLogo = [YQResourceUIHelper logoForCarrier:carrierString];
        NSString *carrierBackgroundColor = [[ResGExpress _iconBgColor] get:carrierString];
        radiusCell.normalCarrierLabel.text = carrierLogo;
        radiusCell.normalCarrierLabel.backgroundColor = [UIColor colorWithHexString:carrierBackgroundColor alpha:1];
        
        
        NSString *iconText = [YQResourceUIHelper iconFontWithInfoState:self.infoArr[indexPath.row]];
        radiusCell.statusLabel.text = iconText;
        UIColor *bgColor                 = [YQResourceUIHelper colorWithInfoState:self.infoArr[indexPath.row]];
        radiusCell.statusLabel.textColor       = bgColor;
        
        radiusCell.informationLabel.font = [UIFont fontWithName:iconFontName size:16.0f];
        radiusCell.informationLabel.textColor = [YQUIDefinitions getColor:@"@Color_Dark_54"];
        radiusCell.informationLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"F001"];
        
        return radiusCell;
        
        
    }
    
    // Configure the cell...
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
