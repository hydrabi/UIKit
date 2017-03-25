//
//  YQNavigationBarViewController.m
//  YQUIKit
//
//  Created by Hydra on 2017/3/9.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import "YQNavigationBarViewController.h"
#import "NavigationBarTableViewCell.h"
#import "YQUIDefinitions.h"
#import "YQSectionHeaderView.h"
static NSString *tableViewCellReuseIdentifier = @"tableViewCellReuseIdentifier";
static NSString *tableViewCellReuseIdentifier1 = @"tableViewCellReuseIdentifier1";
static NSString *tableViewCellReuseIdentifier2 = @"tableViewCellReuseIdentifier2";
static NSString *tableViewCellReuseIdentifier3 = @"tableViewCellReuseIdentifier3";
static NSString *tableViewCellReuseIdentifier4 = @"tableViewCellReuseIdentifier4";

@interface YQNavigationBarViewController ()
@property (nonatomic,strong)NSArray *dataSource;
@end

@implementation YQNavigationBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NavigationBarTableViewCell class])
                                               bundle:nil]
         forCellReuseIdentifier:tableViewCellReuseIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NavigationBarTableViewCell class])
                                               bundle:nil]
         forCellReuseIdentifier:tableViewCellReuseIdentifier1];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NavigationBarTableViewCell class])
                                               bundle:nil]
         forCellReuseIdentifier:tableViewCellReuseIdentifier2];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NavigationBarTableViewCell class])
                                               bundle:nil]
         forCellReuseIdentifier:tableViewCellReuseIdentifier3];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NavigationBarTableViewCell class])
                                               bundle:nil]
         forCellReuseIdentifier:tableViewCellReuseIdentifier4];
    
    if(DEVICE_IS_IPAD){
        self.dataSource = @[
                            @[@"蓝色风格首页导航栏"],
                            @[@"蓝色风格自定义导航栏"],
                            @[@"蓝色风格iPad首页导航栏"],
                            @[@"浅色风格自定义导航栏(无右边按钮)"],
                            @[@"浅色风格自定义导航栏"],
                            ];
    }
    else{
        self.dataSource = @[
                            @[@"蓝色风格首页导航栏"],
                            @[@"蓝色风格自定义导航栏"],
                            @[@"浅色风格自定义导航栏"],
                            @[@"浅色风格自定义导航栏(无右边按钮)"],
                            ];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)titleWithIndexPath:(NSIndexPath*)indexPath{
    NSString *title = @"";
    if(self.dataSource.count>indexPath.section){
        NSArray *temp = self.dataSource[indexPath.section];
        title = temp[indexPath.row];
    }
    return title;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.dataSource.count>section){
        NSArray *temp = self.dataSource[section];
         return temp.count;
    }
    return 1;
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *normalCell = [[UITableViewCell alloc] init];
    if([[self titleWithIndexPath:indexPath] isEqualToString:@"蓝色风格首页导航栏"]){
        NavigationBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellReuseIdentifier
                                                                           forIndexPath:indexPath];
        [cell.navigationView setHomePageContentsWithParent:self
                                                     isLogin:YES
                                                  middleType:NavigationStyleEmpty
                                                     handler:^(NavigationItemStyle style){
                                                         
                                                     }];
        
        [cell.navigationView showRedDotWithType:NavigationStyleHomeNotification
                                         isLeft:NO
                                     withBorder:NO
                                    borderWidth:0
                                    borderColor:nil
                                         offset:CGPointMake(-10, 10)];
        
        [cell.navigationView showRedDotWithType:NavigationStyleHomePortrait
                                         isLeft:NO
                                     withBorder:YES
                                    borderWidth:1.0f
                                    borderColor:[YQUIDefinitions getColor:@"@Color_White"]
                                         offset:CGPointMake(-10, 10)];
        return cell;
    }
    else if([[self titleWithIndexPath:indexPath] isEqualToString:@"蓝色风格自定义导航栏"]){
        NavigationBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellReuseIdentifier1
                                                                           forIndexPath:indexPath];
        [cell.navigationView setContentWithParent:self
                                              title:@"Title"
                                     leftBtnsType:@[@(NavigationStyleReturn),
                                                    @(NavigationStyleTitle)]
                                         middleType:NavigationStyleEmpty
                                      rightBtnsType:@[@(NavigationStyleMenu),
                                                      @(NavigationStyleShare)]
                                    backgroundStyle:NavigationBackgroundStyleBlue
                                            handler:^(NavigationItemStyle style){
                                                if(style == NavigationStyleReturn){
                                                    
                                                }
                                            }];
        return cell;
    }
    else if([[self titleWithIndexPath:indexPath] isEqualToString:@"蓝色风格iPad首页导航栏"]){
        NavigationBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellReuseIdentifier2
                                                                           forIndexPath:indexPath];
        [cell.navigationView setHomePageContentsWithParent:self
                                                     isLogin:YES
                                                  middleType:NavigationStyleTabBar
                                                     handler:^(NavigationItemStyle style){
                                                         
                                                     }];
        return cell;
    }
    else if([[self titleWithIndexPath:indexPath] isEqualToString:@"浅色风格自定义导航栏"]){
        NavigationBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellReuseIdentifier3
                                                                           forIndexPath:indexPath];
        [cell.navigationView setContentWithParent:self
                                              title:@"Title"
                                     leftBtnsType:@[@(NavigationStyleReturn),
                                                    @(NavigationStyleTitle)]
                                         middleType:NavigationStyleEmpty
                                      rightBtnsType:@[@(NavigationStyleMenu),
                                                      @(NavigationStyleEdit)]
                                    backgroundStyle:NavigationBackgroundStyleWhite
                                            handler:^(NavigationItemStyle style){
                                                
                                            }];
    }
    else if([[self titleWithIndexPath:indexPath] isEqualToString:@"浅色风格自定义导航栏(无右边按钮)"]){
        NavigationBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellReuseIdentifier4
                                                                           forIndexPath:indexPath];
        [cell.navigationView setContentWithParent:self
                                              title:@"Title"
                                     leftBtnsType:@[@(NavigationStyleReturn),
                                                    @(NavigationStyleTitle)]
                                         middleType:NavigationStyleEmpty
                                      rightBtnsType:nil
                                    backgroundStyle:NavigationBackgroundStyleWhite
                                            handler:^(NavigationItemStyle style){
                                                
                                            }];
        return cell;
    }
    return normalCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0f;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YQSectionHeaderView *header = [[YQSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 44.0f)];
    NSArray *arr = self.dataSource[section];
    if(arr.count>0){
        header.titleLabel.text = arr[0];
    }
    return header;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
}

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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
