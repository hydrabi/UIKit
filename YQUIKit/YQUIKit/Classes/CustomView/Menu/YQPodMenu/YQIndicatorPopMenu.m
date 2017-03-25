//
//  YQIndicatorPopMenu.m
//  Pods
//
//  Created by Hydra on 2017/3/1.
//
//

#import "YQIndicatorPopMenu.h"
#import "YQIndicatorMenuTableViewCell.h"
#import "YQResourceLib.h"

static NSString *indicatorCellIndentifier             = @"indicatorCellIndentifier";

@implementation YQIndicatorPopMenu

-(void)UIConfig{
    [super UIConfig];
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;

    [self registerCellNib];
    [self.tableView reloadData];
}

#pragma mark - 注册tableView要用到的所有CellNib
-(void)registerCellNib{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"YQUIKit" ofType:@"bundle"];
    NSBundle *YQUIKitBundle = [NSBundle bundleWithPath:bundlePath];
    UINib *cellNib                   = [UINib nibWithNibName:NSStringFromClass([YQIndicatorMenuTableViewCell class])
                                                      bundle:YQUIKitBundle];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:indicatorCellIndentifier];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,
                                                           [YQUIDefinitions getFloat:@"@Normal_Height_10"],
                                                           0,
                                                           [YQUIDefinitions getFloat:@"@Normal_Height_10"])];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,
                                                          [YQUIDefinitions getFloat:@"@Normal_Height_10"],
                                                          0,
                                                          [YQUIDefinitions getFloat:@"@Normal_Height_10"])];
    }
}

#pragma mark - TableView source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YQIndicatorMenuTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:indicatorCellIndentifier
                                                                              forIndexPath:indexPath];
    if(self.menuTypesArr.count>indexPath.row){
        [cell resetValueWithMenuType:[self.menuTypesArr[indexPath.row] integerValue]];
    }
    return cell;
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuTypesArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [YQUIDefinitions getFloat:@"@Normal_Height_44"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [YQUIDefinitions getFloat:@"@Normal_Height_44"];
}

#pragma mark - TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.menuTypesArr.count>indexPath.row){
        YQMenuType type = [self.menuTypesArr[indexPath.row] integerValue];
        if(self.callback){
            self.callback(type);
        }
    }
    [self hidePopView];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
