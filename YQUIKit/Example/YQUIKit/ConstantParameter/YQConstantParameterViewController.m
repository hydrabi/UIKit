//
//  YQConstantParameterController.m
//  YQUIKit
//
//  Created by Hydra on 2017/3/9.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import "YQConstantParameterViewController.h"
#import "ConstantParameterTableViewCell.h"
#import "YQUIDefinitions.h"
#import "NUIRenderer.h"
#import "YQSectionHeaderView.h"

static NSString *cellIdentifier = @"cellIdentifier";
//4 8 12 16 20 24 72 40 44 48

@interface YQConstantParameterViewController ()
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation YQConstantParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = @[
                        @[
                            @"@Leading_4",
                            @"@Leading_8",
                            @"@Leading_12",
                            @"@Leading_16",
                            @"@Leading_72",
                            ],
                        @[
                            @"@Normal_Width_40",
                            @"@Normal_Width_44",
                            @"@Normal_Width_48",
                            ],
                        ].mutableCopy;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ConstantParameterTableViewCell class])
                                               bundle:nil]
         forCellReuseIdentifier:cellIdentifier];
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
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ConstantParameterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                                           forIndexPath:indexPath];
    
    if(indexPath.section == 0){
        cell.leading.constant = [YQUIDefinitions getFloat:[self titleWithIndexPath:indexPath]];
        cell.titleLabel.text = [NSString stringWithFormat:@"图标与左边的间距为%.1f",[YQUIDefinitions getFloat:[self titleWithIndexPath:indexPath]]];
    }
    else{
        cell.width.constant = [YQUIDefinitions getFloat:[self titleWithIndexPath:indexPath]];
        cell.height.constant = [YQUIDefinitions getFloat:[self titleWithIndexPath:indexPath]];
        cell.titleLabel.text = [NSString stringWithFormat:@"图标与宽高为%.1f",[YQUIDefinitions getFloat:[self titleWithIndexPath:indexPath]]];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YQSectionHeaderView *header = [[YQSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 44.0f)];
    
    if(section == 0){
        header.titleLabel.text = @"间距";
    }
    else{
        header.titleLabel.text = @"宽高";
    }
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0f;
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
