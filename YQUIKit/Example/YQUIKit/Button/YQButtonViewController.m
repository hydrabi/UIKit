//
//  YQButtonController.m
//  YQUIKit
//
//  Created by Halin Lee on 2/17/17.
//  Copyright © 2017 hydrabi. All rights reserved.
//

#import "YQButtonViewController.h"
#import "YQButtonCell.h"
#import "NUISettings.h"
#import "NUIRenderer.h"
#import "YQResourceLib.h"
#import "YQRaiseButtonCell.h"
#import "YQUIDefinitions.h"

static NSString *buttonCellReuseridentifier = @"buttonCellReuseridentifier";
static NSString *iconCellReuseridentifier = @"iconCellReuseridentifier";
static NSString *raiseButtonCellReuseridentifier = @"raiseButtonCellReuseridentifier";

@interface YQButtonSection : NSObject
@property (nonatomic,strong) NSString *sectionName;
@property (nonatomic,copy) NSDictionary *sectionItems;
@property (nonatomic,copy) NSArray *orders;
@end
@implementation YQButtonSection
@end

@interface YQButtonViewController ()

@property (nonatomic,strong) NSArray<YQButtonSection *> *dataArr;
@end

@implementation YQButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([YQButtonCell class]) bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:buttonCellReuseridentifier];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:iconCellReuseridentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQRaiseButtonCell class]) bundle:nil]
         forCellReuseIdentifier:raiseButtonCellReuseridentifier];
    
    NSMutableArray *dataArr = [NSMutableArray array];
    
    //配置Label
    YQButtonSection *buttonSection = [[YQButtonSection alloc] init];
    buttonSection.sectionName = @"Default Button";
    buttonSection.orders = @[
                            @"Button_Default",
                            @"Button_Blue",
                            @"Button_Yellow",
                            @"Button_Green",
                            @"Button_LightBlue",
                            @"Button_Red",
                            @"Button_White",
                            @"Button_Disable",
                            @"Button_DisableWhite",
                            ];
    
    buttonSection.sectionItems = @{
                             @"Button_Default"       :@"Button_Default",
                             @"Button_Blue"          :@"Button_Default:Button_Blue",
                             @"Button_Yellow"        :@"Button_Default:Button_Yellow",
                             @"Button_Green"         :@"Button_Default:Button_Green",
                             @"Button_LightBlue"     :@"Button_Default:Button_LightBlue",
                             @"Button_Red"           :@"Button_Default:Button_Red",
                             @"Button_White"         :@"Button_Default:Button_White",
                             @"Button_Disable"       :@"Button_Default:Button_Disable",
                             @"Button_DisableWhite"  :@"Button_Default:Button_DisableWhite",
                             };
    [dataArr addObject:buttonSection];
    
    buttonSection = [[YQButtonSection alloc] init];
    buttonSection.sectionName = @"Icon Button";
    buttonSection.orders = @[@"Button_Icon",
                            @"Button_Icon_Large"];
    buttonSection.sectionItems = @{@"Button_Icon":@"Button_Icon",
                                  @"Button_Icon_Large":@"Button_Icon:Button_Icon_Large"
                                   };
    [dataArr addObject:buttonSection];
    
    buttonSection = [[YQButtonSection alloc] init];
    buttonSection.sectionName = @"Raise Button";
    buttonSection.orders = @[@"Button_Raise_Oriange",
                             @"Button_Raise_Blue",
                             @"Button_Raise_Disable",
                             ];
    buttonSection.sectionItems = @{@"Button_Raise_Oriange":@"Button_Raise",
                                   @"Button_Raise_Blue":@"Button_Raise",
                                   @"Button_Raise_Disable":@"Button_Raise",
                                   
                                   };
    [dataArr addObject:buttonSection];
    
    
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
    YQButtonSection *section = self.dataArr[indexPath.section];
    NSString *className = section.orders[indexPath.row];
    NSString *nuiClass = section.sectionItems[className];
    YQButtonCell *cell;
    switch (indexPath.section) {
        case 0:
        {
            cell = [self.tableView dequeueReusableCellWithIdentifier:buttonCellReuseridentifier];
            cell.contentButton.backgroundColor = [UIColor clearColor];
            cell.nameLabel.text = className;
            [NUIRenderer renderButton:cell.contentButton withClass:nuiClass];
            [self setLabelCell:cell withRow:indexPath.row];
        }

            break;
            
        case 1:
        {
            cell = [self.tableView dequeueReusableCellWithIdentifier:iconCellReuseridentifier];
            cell.contentButton.backgroundColor = [UIColor clearColor];
            cell.nameLabel.text = className;
            [NUIRenderer renderButton:cell.contentButton withClass:nuiClass];
            [self setIconCell:cell withRow:indexPath.row];
        }
            
            break;
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:raiseButtonCellReuseridentifier
                                                                                 forIndexPath:indexPath];
            YQRaiseButtonCell *raiseButtonCell = (YQRaiseButtonCell*)cell;
            raiseButtonCell.titleLabel.text = className;
            if([className isEqualToString:@"Button_Raise_Disable"]){
                [raiseButtonCell.button hideShadow];
                [raiseButtonCell.button setLayerBackgroundColor:[YQUIDefinitions getColor:@"@Color_Dark_12"]];
            }
            else if([className isEqualToString:@"Button_Raise_Oriange"]){
                [raiseButtonCell.button setLayerBackgroundColor:[YQUIDefinitions getColor:@"@Color_Oriange"]];
            }
            else{
                [raiseButtonCell.button setLayerBackgroundColor:[YQUIDefinitions getColor:@"@Color_Blue"]];
            }
            
        }
            break;
    }
    
    
    
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.dataArr[section].sectionName;
}

- (void)setLabelCell:(YQButtonCell *)cell withRow:(NSInteger)row{
    [cell.contentButton setTitle:@"BUTTON" forState:UIControlStateNormal];
    
}

- (void)setIconCell:(YQButtonCell *)cell withRow:(NSInteger)row{
    NSString *title = [YQResourceUIHelper iconFontWithCommonState:@"F701"];

    [cell.contentButton setTitle:title forState:UIControlStateNormal];
    
    switch (row) {

        case 0:{
            cell.contentView.backgroundColor = [UIColor clearColor];
            [cell.contentButton setBackgroundColor:[UIColor colorWithHexString:@"#18acfc"
                                                                    alpha:1]];
            [cell.contentButton setTitle:[YQResourceUIHelper
                                     iconFontWithCommonState:@"C014"]
                           forState:UIControlStateNormal];
            break;
        }
            
        case 1:{
            cell.contentView.backgroundColor = [UIColor lightGrayColor];
            [cell.contentButton setTitle: [YQResourceUIHelper iconFontWithCommonState:@"F01B"]
                              forState:UIControlStateNormal];
            break;
        }

        default:
            break;
    }
}


@end
