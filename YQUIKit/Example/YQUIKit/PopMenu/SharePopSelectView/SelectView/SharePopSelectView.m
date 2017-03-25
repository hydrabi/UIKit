//
//  SharePopSelectView.m
//  YQTrack
//
//  Created by 毕志锋 on 15/9/10.
//  Copyright (c) 2015年 17track. All rights reserved.
//

#import "SharePopSelectView.h"
#import "UIColor+Addition.h"
#import "SharePopSelectViewTableViewCell.h"
#import "SharePopSelectViewUIParameter.h"
#import "SelectViewAboutTableViewCell.h"

static NSString * const tableViewCellReuseId = @"tableViewCellReuseId";
static NSString *cellIndentifier             = @"cellIdentifier";
static NSString *aboutCellIdentifier         = @"aboutCellIdentifier";

@interface SharePopSelectView()
/**
 *  share页面上的tableView
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  数据源队列
 */
@property (strong,nonatomic) NSMutableArray *dataSourceArray;
/**
 *  父视图
 */
@property (weak,nonatomic) UIView *parentView;
/**
 *  隐藏动画
 */
@property (strong,nonatomic) CAAnimationGroup *hideGroup;
/**
 *  展示动画
 */
@property (strong,nonatomic) CAAnimationGroup *showGroup;
/**
 *  不同页面展示特定的菜单
 */
@property (assign,nonatomic) SharePopSelectTableViewType tableViewType;

@property (strong,nonatomic) TrackRecordModel *model;
/**
 *  响应点击的覆盖在parentView上的视图
 */
@property (strong,nonatomic) UIView *tapActionView;
@end

@implementation SharePopSelectView

+(instancetype)instanceSharePopSelectViewWithParentView:(UIView*)parent model:(TrackRecordModel*)model tableViewType:(SharePopSelectTableViewType)tableViewType
{
    NSArray* nibView               = [[NSBundle mainBundle] loadNibNamed:@"SharePopSelectView" owner:nil options:nil];
    SharePopSelectView *selectView = (SharePopSelectView*)[nibView objectAtIndex:0];
    selectView.parentView          = parent;
    selectView.model               = model;
    selectView.tableViewType       = tableViewType;
    [selectView configSelectView];
    return [nibView objectAtIndex:0];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,
                                                           [[SharePopSelectViewUIParameter sharedSingleton] tableViewCell_separaterLineInset ],
                                                           0,
                                                           [[SharePopSelectViewUIParameter sharedSingleton] tableViewCell_separaterLineInset ])];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,
                                                          [[SharePopSelectViewUIParameter sharedSingleton] tableViewCell_separaterLineInset ],
                                                          0,
                                                          [[SharePopSelectViewUIParameter sharedSingleton] tableViewCell_separaterLineInset ])];
    }
}

#pragma mark - 展示sharePopView
//展示sharePopView
-(void)showSharePopView{
    if(!self.superview){
        if(!self.tapActionView.superview){
            [self.parentView addSubview:self.tapActionView];
        }
        [self.parentView addSubview:self];
        [self.layer addAnimation:self.showGroup forKey:@"start"];
        self.layer.opacity = 1.0;
    }
    else{
        [self hideSharePopView];
    }
}

-(void)hideSharePopView{
    if(self.superview){
        
        [self.layer addAnimation:self.hideGroup forKey:@"end"];
        self.layer.opacity = 0.0;
        if(self.tapActionView.superview){
            [self.tapActionView removeFromSuperview];
        }
    }
}

#pragma mark - UI
-(void)configSelectView{
    if(!self.dataSourceArray){
        [self configTabelView];
        [self configUI];
        [self configAnimation];
        [self configTapActionView];
    }
}

-(void)configResultTableView{
    if(DEVICE_IS_IPAD){
        //激活状态
        if([self.model.isActivated boolValue]){
            self.dataSourceArray = @[
                                     @(SharePopSelectTableViewCellType_achive),
                                     @(SharePopSelectTableViewCellType_copyEditAlias),
                                     @(SharePopSelectTableViewCellType_copyTrackNo),
                                     @(SharePopSelectTableViewCellType_copyDetails)].mutableCopy;
        }
        //归档状态
        else{
            self.dataSourceArray = @[@(SharePopSelectTableViewCellType_activation),
                                     @(SharePopSelectTableViewCellType_copyEditAlias),
                                     @(SharePopSelectTableViewCellType_copyTrackNo),
                                     @(SharePopSelectTableViewCellType_copyDetails)].mutableCopy;
        }
    }
    else{
        //激活状态
        if([self.model.isActivated boolValue]){
            self.dataSourceArray = @[
                                     @(SharePopSelectTableViewCellType_achive),
                                     @(SharePopSelectTableViewCellType_share),
                                     @(SharePopSelectTableViewCellType_copyEditAlias),
                                     @(SharePopSelectTableViewCellType_copyTrackNo),
                                     @(SharePopSelectTableViewCellType_copyDetails)].mutableCopy;
        }
        //归档状态
        else{
            self.dataSourceArray = @[@(SharePopSelectTableViewCellType_activation),
                                     @(SharePopSelectTableViewCellType_share),
                                     @(SharePopSelectTableViewCellType_copyEditAlias),
                                     @(SharePopSelectTableViewCellType_copyTrackNo),
                                     @(SharePopSelectTableViewCellType_copyDetails)].mutableCopy;
        }
    }
}

-(void)configAboutTableView{
    self.dataSourceArray = @[
                             @(SharePopSelectTableViewCellType_about17Track),
                             @(SharePopSelectTableViewCellType_aboutDisclaimer),
                             @(SharePopSelectTableViewCellType_aboutConditions),
                             @(SharePopSelectTableViewCellType_aboutPrivacy),
                             ].mutableCopy;
}

/**
 *  配置tableView
 */
-(void)configTabelView{
    
    switch (self.tableViewType) {
        case SharePopSelectTableViewType_result:
        {
            [self configResultTableView];
        }
            break;
        case SharePopSelectTableViewType_about:
        {
            [self configAboutTableView];
        }
            break;
        default:
            break;
    }
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewCellReuseId];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self registerCellNib];
    
}

/**
 *  配置UI
 */
-(void)configUI{
    SharePopSelectViewUIParameter *UIParameter = [SharePopSelectViewUIParameter sharedSingleton];
    
    CGFloat viewWidth = 0;
    switch (self.tableViewType) {
        case SharePopSelectTableViewType_result:
        {
            viewWidth = [UIParameter sharePopSelectView_width];
        }
            break;
        case SharePopSelectTableViewType_about:
        {
            viewWidth = [UIParameter sharePopSelectView_aboutWidth];
        }
            break;
        default:
            break;
    }
    
    //设置锚点，右上角
    self.layer.anchorPoint = CGPointMake(1, 0);
    self.layer.cornerRadius = 5.0f;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIParameter tableView_backGroundColor];
    self.frame = CGRectMake(CGRectGetWidth(self.parentView.frame)-viewWidth-[UIParameter sharePopSelectView_trailPadding],
                            [UIParameter sharePopSelectView_oringY],
                            viewWidth,
                            [UIParameter tableView_rowHeight]*self.dataSourceArray.count+[UIParameter sharePopSelectView_topAndBottomPadding]*2);
}

-(void)configTapActionView{
    if(!self.tapActionView){
        self.tapActionView = [[UIView alloc] initWithFrame:self.parentView.frame];
        self.tapActionView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self.tapActionView addGestureRecognizer:tap];
    }
}

-(void)tapAction:(UITapGestureRecognizer*)tap{
    [self hideSharePopView];
}

#pragma mark - 创建动画
/**
 *  创建动画
 */
-(void)configAnimation{
    [self configHideAniamtion];
    [self configShowAnimation];
}
/**
 *  隐藏动画
 */
-(void)configHideAniamtion{
    if(!self.hideGroup){
        CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [scale setFromValue:@(1.0)];
        [scale setToValue:@(0.0)];
        
        CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
        [opacity setFromValue:@(1.0)];
        [opacity setToValue:@(0.0)];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = 0.2;
        [group setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [group setAnimations:@[scale,opacity]];
        self.hideGroup = group;
        [group setValue:@"hide" forKey:@"hide"];
        self.hideGroup.delegate = self;
    }
}
/**
 *  展示动画
 */
-(void)configShowAnimation{
    if(!self.showGroup){
        CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [scale setFromValue:@(0.0)];
        [scale setToValue:@(1.0)];
        
        CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
        [opacity setFromValue:@(0.0)];
        [opacity setToValue:@(1.0)];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = 0.2;
        [group setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [group setAnimations:@[scale,opacity]];
        [group setValue:@"show" forKey:@"show"];
        self.showGroup = group;
    }
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if(self.superview!=nil){
        [self removeFromSuperview];
    }
}

#pragma mark 手势事件
/**屏幕点击事件*/
//- (void)receiveTouchEvent:(NSNotification *)notification
//{
//    UIEvent *event = [notification.userInfo objectForKey:WINDOWN_TOUCH_EVENT_INFO_KEY]; //从NSNotification获得所有点击
//    UITouch *touch = [[event allTouches] anyObject]; //获得点击事件
//    CGPoint point = [touch locationInView:self.parentView]; //获得点击位置
//
//    if (!CGRectContainsPoint(self.frame, point)) {
//        if(self.superview){
//            [self showSharePopView];
//        }
//    }
//}

#pragma mark - 响应indexpath的图片或者文字
//返回特定行的图片
-(NSString*)getSpecificImageNameWithIndexPath:(NSIndexPath*)indexPath{
    NSString *result = @"";
    if(self.dataSourceArray.count>indexPath.row){
        SharePopSelectTableViewCellType type = [self.dataSourceArray[indexPath.row] integerValue];
        switch (type) {
            case SharePopSelectTableViewCellType_activation:
                result = @"F026";
                break;
            case SharePopSelectTableViewCellType_achive:
                result = @"F031";
                break;
            case SharePopSelectTableViewCellType_share:
                result = @"F022";
                break;
            case SharePopSelectTableViewCellType_copyTrackNo:
                result = @"F01C";
                break;
            case SharePopSelectTableViewCellType_copyEditAlias:
                result = @"F708";
                break;
            case SharePopSelectTableViewCellType_copyDetails:
                result = @"F706";
                break;
            default:
                break;
        }
        
    }
    
    return result;
}

//返回特定行的标题
-(NSString*)getSpecificTitleWithIndexPath:(NSIndexPath*)indexPath{
    NSString *result = @"";
    if(self.dataSourceArray.count>indexPath.row){
        SharePopSelectTableViewCellType type = [self.dataSourceArray[indexPath.row] integerValue];
        switch (type) {
            case SharePopSelectTableViewCellType_activation:
                result = [[ResV5AppWord __main_tabActivation] get];
                break;
            case SharePopSelectTableViewCellType_achive:
                result = [[ResV5AppWord __main_tabArchived] get];
                break;
            case SharePopSelectTableViewCellType_favorites:
                result = [[ResV5AppWord __main_tabFavorites] get];
                break;
            case SharePopSelectTableViewCellType_send:
                result = @"Send";
                break;
            case SharePopSelectTableViewCellType_share:
                result = [[ResV5AppWord __more_share] get];
                break;
            case SharePopSelectTableViewCellType_copyTrackNo:
                result = [[ResGTrackRelated __toolCopy_copyNumber] get];
                break;
            case SharePopSelectTableViewCellType_copyEditAlias:
                result = [[ResV5AppWord __memo_title] get];
                break;
            case SharePopSelectTableViewCellType_copyDetails:
                result = [[ResGTrackRelated __toolCopy_copyDetails] get];
                break;
            case SharePopSelectTableViewCellType_about17Track:
                result = [[ResV5AppWord __about_aboutUs] get];
                break;
            case SharePopSelectTableViewCellType_aboutDisclaimer:
                result = [[ResV5AppWord __about_copyright] get];
                break;
            case SharePopSelectTableViewCellType_aboutPrivacy:
                result = [[ResV5AppWord __about_privacy] get];
                break;
            case SharePopSelectTableViewCellType_aboutConditions:
                result = [[ResV5AppWord __about_licensing] get];
                break;
            default:
                break;
        }
        
    }
    return result;
}

#pragma mark - 注册tableView要用到的所有CellNib
-(void)registerCellNib{
    UINib *cellNib                   = [UINib nibWithNibName:@"SharePopSelectViewTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:cellIndentifier];
    
    UINib *aboutCellNib              = [UINib nibWithNibName:NSStringFromClass([SelectViewAboutTableViewCell class]) bundle:nil];
    [self.tableView registerNib:aboutCellNib forCellReuseIdentifier:aboutCellIdentifier];
    
}

#pragma mark - TableView source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *defaultCell = [[UITableViewCell alloc] init];
    
    switch (self.tableViewType) {
        case SharePopSelectTableViewType_result:
        {
            SharePopSelectViewTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
            cell.leadingLabel.text = [YQResourceUIHelper iconFontWithCommonState:[self getSpecificImageNameWithIndexPath:indexPath]];
            cell.titleLabel.text = [self getSpecificTitleWithIndexPath:indexPath];
            return cell;
        }
            break;
        case SharePopSelectTableViewType_about:
        {
            SelectViewAboutTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:aboutCellIdentifier forIndexPath:indexPath];
            cell.titleLabel.text = [self getSpecificTitleWithIndexPath:indexPath];
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return defaultCell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark - TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(didSelectWithCellType:)]){
        if(self.dataSourceArray.count>indexPath.row){
            SharePopSelectTableViewCellType type = [self.dataSourceArray[indexPath.row] integerValue];
            
            [self.delegate didSelectWithCellType:type];
        }
        [self showSharePopView];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//tableViewCell分割线左边距为76
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0,10, 0, 10) ];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
    
    if([cell isKindOfClass:[SharePopSelectViewTableViewCell class]]){
        [cell setBackgroundColor:[UIColor clearColor]];
    }
}
@end
