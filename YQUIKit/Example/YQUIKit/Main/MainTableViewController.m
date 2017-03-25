//
//  MainTableViewController.m
//  NUITest
//
//  Created by Hydra on 2017/1/10.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "MainTableViewController.h"
#import "YQColorViewController.h"
#import "YQButtonViewController.h"
#import "YQCellViewController.h"
#import "YQPopMenuViewController.h"
#import "YQRefreshViewController.h"
#import "YQHomePageViewController.h"
#import "YQPadHomePageViewController.h"
#import "YQCheckBoxViewController.h"
static NSString * cellReuseIdentifier = @"cellReuseIdentifier";


@interface MainTableViewController ()
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //添加一个对应的 YQxxxViewController，并在此加入对应的名称即可显示
    self.dataArr = @[
                     @"Color",
                     @"Label",
                     @"Button",
                     @"Cell",
                     @"PopMenu",
                     @"Refresh",
                     @"CheckBox",
                     @"TextField",
                     @"NavigationBar",
                     @"ConstantParameter",
                     @"KeyboardAssist",
                     ].mutableCopy;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellReuseIdentifier];
    
    [self setNeedsStatusBarAppearanceUpdate];
    self.title = @"Main";
    [self.navigationController.navigationBar setTranslucent:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    
    if(self.dataArr.count>indexPath.row){
        cell.textLabel.text = self.dataArr[indexPath.row];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSString *name = self.dataArr[indexPath.row];
    Class clazz;
    NSString *className = [NSString stringWithFormat:@"YQ%@ViewController",name];
    clazz = NSClassFromString(className);

    UIViewController *controller = [[clazz alloc] initWithNibName:className bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
