//
//  YQRefreshViewController.m
//  YQUIKit
//
//  Created by Hydra on 2017/2/17.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import "YQRefreshViewController.h"
#import "YQRefreshControl.h"
@interface YQRefreshViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak)IBOutlet UITableView *tableView;
@property (nonatomic,strong)YQRefreshControl *refreshControl;
@end

@implementation YQRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.refreshControl = [self.tableView addRefreshControlWithVerticalOffset:100
                                          actionHandler:^(YQRefreshControl *control){
        
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"cell"];
//    [self.refreshControl manuallyTriggered:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)stopAnimation:(id)sender{
    [self.refreshControl stopIndicatorAnimation];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"请下拉刷新";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
@end
