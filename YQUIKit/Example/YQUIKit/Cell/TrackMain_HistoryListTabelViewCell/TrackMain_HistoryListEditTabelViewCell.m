//
//  TrackMain_HistoryListTabelViewCell.m
//  YQTrack
//
//  Created by 毕志锋 on 15/7/30.
//  Copyright (c) 2015年 17track. All rights reserved.
//

#import "TrackMain_HistoryListEditTabelViewCell.h"
#import "UIColor+Addition.h"
#import "NSString+CommonIconFont.h"
@interface TrackMain_HistoryListEditTabelViewCell()

/**
 *  作用与推送图片
 */
@property (nonatomic,strong)UITapGestureRecognizer *notificatonTap;

@property (nonatomic,strong)TrackRecordModel *model;

@end

@implementation TrackMain_HistoryListEditTabelViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self configUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UILabel*)trackNOLabel{
    if(_trackNOLabel == nil){
        _trackNOLabel = [[UILabel alloc] init];
        _trackNOLabel.font = [UIFont systemFontOfSize:12];
        _trackNOLabel.textColor = [UIColor colorWithHexString:@"000000" alpha:0.87];
    }
    return _trackNOLabel;
}

-(UILabel*)trackNOAliasLabel{
    if(_trackNOAliasLabel == nil){
        _trackNOAliasLabel = [[UILabel alloc] init];
        _trackNOAliasLabel.font = [UIFont systemFontOfSize:16];
        _trackNOAliasLabel.textColor = [UIColor colorWithHexString:@"000000" alpha:0.87];
    }
    return _trackNOAliasLabel;
}

#pragma mark - 配置UI
-(void)configUI{
    self.trackNOAliasLabel.text = @"";
    self.trackNOLabel.text = @"";
    self.logoLabel.clipsToBounds = YES;
    self.logoLabel.layer.cornerRadius = 5.0f;
    self.logoLabel.font = [UIFont fontWithName:iconFontName size:24.0f];
    
    
    self.selectLabel.font = [UIFont fontWithName:iconFontName size:24.0f];
    self.selectLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"F403"];
    self.selectLabel.textColor = [UIColor colorWithHexString:@"000000" alpha:0.54];
}

/**
 *  不同类型的cell显示的内容不同
 *
 *  @param currentCellType cell的类型
 */
-(void)setCurrentCellType:(EditTabelViewCellType)currentCellType{
    _currentCellType = currentCellType;
    if(_currentCellType == EditTabelViewCellType_ActivationOrArchived){
        self.logoLabel.hidden = NO;
    }
}

-(void)resetValueWithModal:(TrackRecordModel*)model{
    self.model = model;
    
    NSString *packageState         = [YQResourceUIHelper packageStateFromInteger:model.packageState.integerValue];

    UIColor *iconBgColor          =[YQResourceUIHelper colorWithPackageState:packageState];

    self.logoLabel.text            = [YQResourceUIHelper iconFontWithPackageState:[YQResourceUIHelper packageStateFromInteger:[model.packageState integerValue]]];
    self.logoLabel.textColor = [UIColor whiteColor];
    self.logoLabel.backgroundColor = iconBgColor;
    
    if(model.trackNoAlias.length>0){
        self.trackNOAliasLabel.text    = model.trackNoAlias;
        self.trackNOLabel.text         = model.trackNo;
        [self resetTrackNoAliasLabelContrainWithTrackNOAlias];
    }
    else{
        [self resetTrackNOAliasLabelContrain];
        self.trackNOAliasLabel.text    = model.trackNo;
    }
}

/**
 *  当没有单号别名的时候，只出现一个label，需要重写约束
 */
-(void)resetTrackNOAliasLabelContrain{
    UIView *superView = self.trackNOAliasLabel.superview;
    if(self.trackNOAliasLabel.superview){
        [self.trackNOAliasLabel removeFromSuperview];
    }
    
    if(self.trackNOLabel.superview){
        [self.trackNOLabel removeFromSuperview];
    }
    [superView addSubview:self.trackNOAliasLabel];
    
    [self.trackNOAliasLabel updateConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(superView.left).offset(76);
        make.right.equalTo(superView.right).offset(-54);
        make.centerY.equalTo(superView);
    }];

}

/**
 *  有单号别名
 */
-(void)resetTrackNoAliasLabelContrainWithTrackNOAlias{
    UIView *superView = self.trackNOAliasLabel.superview;
    if(self.trackNOAliasLabel.superview){
        [self.trackNOAliasLabel removeFromSuperview];
    }
    
    if(self.trackNOLabel.superview){
        [self.trackNOLabel removeFromSuperview];
    }
    
    
    [superView addSubview:self.trackNOAliasLabel];
    [superView addSubview:self.trackNOLabel];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]<8.0){
        if(!self.trackNOLabel || !self.trackNOAliasLabel){
            return;
        }
    }
    
    [self.trackNOAliasLabel makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(superView.left).offset(76);
        make.right.equalTo(superView.right).offset(-54);
        make.top.equalTo(superView.top).offset(15);
        make.bottom.equalTo(self.trackNOLabel.top).offset(-4);
    }];
    
    [self.trackNOLabel makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(superView.left).offset(76);
        make.right.equalTo(superView.right).offset(-54);
    }];
}

-(void)setButtonSelected:(BOOL)result{
    if(result){
        self.selectLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"F00F"];
        self.selectLabel.textColor = [UIColor colorWithHexString:@"003a9b" alpha:1];
    }
    else{
        self.selectLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"F403"];
        self.selectLabel.textColor = [UIColor colorWithHexString:@"000000" alpha:0.54];
    }
    
}

@end
