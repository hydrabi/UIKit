//
//  TrackingResultCarrierCell.m
//  YQTrack
//
//  Created by 毕志锋 on 15/7/21.
//  Copyright (c) 2015年 17track. All rights reserved.
//

#import "TrackingResultCarrierCell.h"
#import "YQResourceLib.h"
#import "TrackRecordManager.h"
#import "NSString+Addition.h"
#import "UIColor+Addition.h"
#import "TrackingResultViewUIParameter.h"
#import "TrackResultModel.h"
#import "NSString+CommonIconFont.h"


@interface TrackingResultCarrierCell()<UIGestureRecognizerDelegate>
/**
 *  用图片的时候显示运输商图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *carrierIconImageView;

/**
 *  运输商名称
 */
@property (weak, nonatomic) IBOutlet UILabel *carrierNameLabel;

/**
 *  运输商国家
 */
@property (weak, nonatomic) IBOutlet UILabel *carrierCountryLabel;

/**
 *  运输商状态
 */
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

/**
 *  用字体的时候显示这个
 */
@property (weak, nonatomic) IBOutlet UILabel *carrierLogoLable;

/**
 *  分割线
 */
@property (weak, nonatomic) IBOutlet UIView *lineView;

/**
 *  线的底部约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineBottomContraint;

/**
 *  国家底部约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *countryBottomContraint;
/**
 *  名称top约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *carrierNameTopContraint;
/**
 *  扩大其点击范围
 */
@property (weak, nonatomic) IBOutlet UIView *clickRegionView;
/**
 *  点击手势识别器，使推送按钮点击范围扩大
 */
@property (nonatomic,strong)UITapGestureRecognizer *tapGesture;
/**
 *  是否目的地事件
 */
@property (nonatomic,assign)BOOL isDestination;
/**
 *  定制的选中背景
 */
//@property (nonatomic,strong)UIView *customSelectBackGroundView;
/**
 *  定制的点击选中底部白色
 */
//@property (nonatomic,strong)UIView *bottomWhiteSpaceView;
/**
 *  官网信息图标
 */
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;
/**
 *  运输商代码
 */
@property (nonatomic,assign)NSInteger carrierCode;
/**
 *  运输商网站地址
 */
@property (nonatomic,strong)NSString *carrierUrl;

@end

@implementation TrackingResultCarrierCell

//-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
//    [super setHighlighted:highlighted animated:animated];
//    if(highlighted){
//        self.customSelectBackGroundView.hidden = NO;
//    }
//    else{
//        self.customSelectBackGroundView.hidden = YES;
//    }
//}

-(void)awakeFromNib{
    [super awakeFromNib];
    _isMutableCarrier             = NO;
    _shouldShouldInformation      = NO;
    self.carrierCountryLabel.text = @"";
    self.carrierNameLabel.text    = @"";
    [self configUI];
    
    if(!self.tapGesture){
        //添加状态按钮点击事件，跳转到help页面
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        self.tapGesture.delegate = self;
        [self.clickRegionView addGestureRecognizer:self.tapGesture];
    }
    //运输商cell被选中的view需要定制，不包含分割线以下部分
    
    
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"#d7d7d7" alpha:1];
//    if(!self.customSelectBackGroundView){
//        self.customSelectBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
//        self.customSelectBackGroundView.backgroundColor = [UIColor colorWithHexString:@"#DFDFDF" alpha:1];
//        [self.selectedBackgroundView addSubview:self.customSelectBackGroundView];
//        [self.customSelectBackGroundView makeConstraints:^(MASConstraintMaker *make){
//            make.trailing.equalTo(self.selectedBackgroundView.trailing).offset(@0);
//            make.leading.equalTo(self.selectedBackgroundView.leading).offset(@8);
//            make.bottom.equalTo(self.selectedBackgroundView.bottom).offset(@-16);
//            make.height.equalTo(@1);
//        }];
        
//        self.bottomWhiteSpaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 15)];
//        self.bottomWhiteSpaceView.backgroundColor = [UIColor whiteColor];
//        [self.selectedBackgroundView addSubview:self.bottomWhiteSpaceView];
//        [self.bottomWhiteSpaceView makeConstraints:^(MASConstraintMaker *make){
//            make.trailing.equalTo(self.selectedBackgroundView.trailing).offset(@0);
//            make.leading.equalTo(self.selectedBackgroundView.leading).offset(@0);
//            make.bottom.equalTo(self.selectedBackgroundView.bottom).offset(@0);
//            make.height.equalTo(@15);
//        }];
//    }
    
}

-(void)configUI{
    self.carrierLogoLable.layer.cornerRadius = 5.0f;
    self.carrierLogoLable.clipsToBounds = YES;
    self.carrierLogoLable.font = [UIFont fontWithName:@"carrier" size:40.0f];
    
    self.carrierCountryLabel.textColor = [UIColor colorWithHexString:@"#000000" alpha:0.54];
    self.carrierCountryLabel.font = [UIFont systemFontOfSize:12];
    
    self.carrierNameLabel.textColor = [UIColor colorWithHexString:@"#000000" alpha:0.87];
    self.carrierNameLabel.font = [UIFont systemFontOfSize:16];
    
    self.informationLabel.font = [UIFont fontWithName:iconFontName size:16.0f];
    self.informationLabel.text = [YQResourceUIHelper iconFontWithCommonState:@"F001"];
}

-(void)resetValueWithRecordModel:(TrackRecordModel*)recordModel isDestination:(BOOL)isDestination{
    NSError *error;
    
    self.isDestination = isDestination;
    
    TrackResultModel *resultModel = [[TrackResultModel alloc] initWithDictionary:recordModel.trackResult error:&error];
    //目的地或者发件地国家
    NSString *country;
    //运输商查询状态
    NSString *carrierInfoState;
    //状态
    NSString *iconText;
    //都需要补0。。。
    if(isDestination){
        if(resultModel.destinationCountry!=0){
            country                      =  [YQResourceUIHelper countryFromInteger:resultModel.destinationCountry];
        }
        carrierInfoState             =   [YQResourceUIHelper infoStateFilterFromInteger:resultModel.secondCarrierInfoState];
        
    }
    else{
        if(resultModel.originCountry!=0){
            country                      =  [YQResourceUIHelper countryFromInteger:resultModel.originCountry];
        }
        carrierInfoState             = [YQResourceUIHelper infoStateFilterFromInteger:resultModel.firstCarrierInfoState];
    }

    iconText = [YQResourceUIHelper iconFontWithInfoState:carrierInfoState];
    
    //国家全名
    NSString *countryName;
    if(country.length>0){
        countryName = [[ResGCountry _name] get:country];
    }
    else{
        countryName = [[ResGSystem __gName_enumUnknow] get];
    }

    
    UIColor *bgColor                 = [YQResourceUIHelper colorWithInfoState:carrierInfoState];

    self.carrierCountryLabel.text    = countryName;
    self.statusLabel.text            = iconText;
    self.statusLabel.textColor       = bgColor;
    self.statusLabel.backgroundColor = [UIColor whiteColor];
    self.statusLabel.font = [UIFont fontWithName:iconFontName size:24];
    
    
    YQResourceLoader *carrierLoder =nil;
    //运输商名称
    NSString *carrierName = @"";
    NSString *carrierKey = @"";
    //运输商颜色
    NSString *carrierBackgroundColor = @"";
    //运输商
    NSInteger carrierNumber;
    if(isDestination){
        carrierNumber = resultModel.secondCarrier;
    }
    else{
        carrierNumber = resultModel.firstCarrier;
    }
    
    carrierKey = [YQResourceUIHelper carrierFromInteger:carrierNumber];
    //大于100000 为express
    if(carrierNumber ==0 || carrierNumber>100000){
        carrierBackgroundColor = [[ResGExpress _iconBgColor] get:carrierKey];
        carrierLoder = [[YQResourceManager sharedSingleton] loaderForClass:[ResGExpress class]];
        carrierName = [[ResGExpress _name] get:carrierKey];
    }
    else{
        carrierLoder = [[YQResourceManager sharedSingleton] loaderForClass:[ResGCarrier class]];
        carrierName = [[ResGCarrier _name] get:carrierKey];
    }
    
    //如果资源不包含该运输商，把该运输商当作0处理
    if(![carrierLoder containKey:carrierKey]){
        carrierName = [[ResGSystem __gName_enumUnknow] get];
        carrierKey = [YQResourceUIHelper carrierFromInteger:0];
    }
    
   
    self.carrierNameLabel.text = carrierName;
    
    id carrierLogo = [YQResourceUIHelper logoForCarrier:carrierKey];
    if(carrierLogo!=nil){
        //显示图片
        if([carrierLogo isKindOfClass:[UIImage class]]){
            self.carrierIconImageView.hidden = NO;
            self.carrierLogoLable.hidden     = YES;
            [self.carrierIconImageView setImage:(UIImage*)carrierLogo];
        }
        else if([carrierLogo isKindOfClass:[NSString class]]){
            self.carrierIconImageView.hidden = YES;
            self.carrierLogoLable.hidden     = NO;
            self.carrierLogoLable.text = (NSString*)carrierLogo;
            self.carrierLogoLable.backgroundColor = [UIColor colorWithHexString:carrierBackgroundColor alpha:1];
        }
    }
    else{
        self.carrierIconImageView.hidden = NO;
        self.carrierLogoLable.hidden     = YES;
        [self.carrierIconImageView setImage:[UIImage imageNamed:@"trackResult_selectCarrier"]];
    }
    
}

-(void)setIsMutableCarrier:(BOOL)isMutableCarrier{
    _isMutableCarrier = isMutableCarrier;
    if(_isMutableCarrier){
        self.statusLabel.hidden = YES;
        [self remakeMutableCarrierConstraints];
        self.informationLabel.hidden = YES;
    }
    else{
        self.statusLabel.hidden = NO;
        self.informationLabel.hidden = YES;
    }
}

-(void)remakeMutableCarrierConstraints{
    UIView *lineSuperView = self.lineView.superview;
    [lineSuperView removeConstraint:self.lineBottomContraint];
    [lineSuperView removeConstraint:self.countryBottomContraint];
    [self.carrierLogoLable removeFromSuperview];
    [self.carrierIconImageView removeFromSuperview];
    [self.contentView addSubview:self.carrierLogoLable];
    [self.contentView addSubview:self.carrierIconImageView];
    
    if(self.carrierCountryLabel.text.length>0){
        self.carrierNameTopContraint.constant = 14;
    }
    else{
        self.carrierNameTopContraint.constant = 23;
    }
    
    [self.lineView updateConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(lineSuperView.bottom).offset(0);
    }];
    
    [self.carrierLogoLable makeConstraints:^(MASConstraintMaker *make){
        make.height.and.width.equalTo(@40);
        make.leading.equalTo(self.contentView.leading).offset(@16);
        make.centerY.equalTo(self.contentView.centerY);
    }];
    
    [self.carrierIconImageView makeConstraints:^(MASConstraintMaker *make){
        make.height.and.width.equalTo(@40);
        make.leading.equalTo(self.contentView.leading).offset(@16);
        make.centerY.equalTo(self.contentView.centerY);
    }];
    [self hideCustomSelectBackGroundView];
}

/**展示官网信息图标*/
-(void)showOfficialInformationWithCarrierNumber:(NSNumber*)number{
    _shouldShouldInformation = YES;
    NSInteger carrierInteger = [number integerValue];
    self.carrierCode = carrierInteger;
    NSString *carrierString = @"";
    NSString *url = @"";
    carrierString = [YQResourceUIHelper carrierFromInteger:carrierInteger];

    //获取官方网站url
    if(carrierInteger == 0){
        
    }
    else{
        if(carrierInteger>100000){
            url = [[ResGExpress _url] get:carrierString];
        }
        else{
            url = [[ResGCarrier _url] get:carrierString];
        }
    }
    
    self.informationLabel.hidden = NO;
    self.carrierUrl = url;
    if(url.length>0  || carrierInteger == 0){
        self.informationLabel.textColor = [UIColor colorWithHexString:@"003a9b" alpha:1];
    }
    else{
        self.informationLabel.textColor = [UIColor colorWithHexString:@"000000" alpha:0.26];
        
    }
}

-(void)resetValueWithAuto{
    self.carrierNameLabel.text    = [[ResGTrackRelated __editorCarrier_auto] get];
    self.carrierCountryLabel.text = @"";
    self.carrierIconImageView.hidden = NO;
    self.carrierLogoLable.hidden     = YES;
    [self.carrierIconImageView setImage:[UIImage imageNamed:@"trackResult_auto"]];
}

-(void)resetValueWithCarrierNumber:(NSNumber*)number{
    NSInteger carrierInteger = [number integerValue];
     NSString *carrierString = @"";
    if(carrierInteger == 0){
        [self resetValueWithAuto];
        return;
    }
    else{
        carrierString = [YQResourceUIHelper carrierFromInteger:carrierInteger];
    }
    
    NSString *carrierName    = @"";
    NSString *countryKey     = @"";
    NSString *countryName    = @"";
    //运输商颜色
    NSString *carrierBackgroundColor = @"";
    id carrierLogo = nil;
    
    if(carrierInteger ==0 || carrierInteger>100000){
        carrierName   = [[ResGExpress _name] get:carrierString];
        carrierBackgroundColor = [[ResGExpress _iconBgColor] get:carrierString];
    }
    else{
        carrierName   = [[ResGCarrier _name] get:carrierString];
        countryKey    = [[ResGCarrier _country] get:carrierString];
    }

    if(countryKey.length>0){
        countryName   = [[ResGCountry _name] get:countryKey];
    }
    
    carrierLogo = [YQResourceUIHelper logoForCarrier:carrierString];
    //显示图片
    if([carrierLogo isKindOfClass:[UIImage class]]){
        self.carrierIconImageView.hidden = NO;
        self.carrierLogoLable.hidden     = YES;
        [self.carrierIconImageView setImage:(UIImage*)carrierLogo];
    }
    else if([carrierLogo isKindOfClass:[NSString class]]){
        self.carrierIconImageView.hidden = YES;
        self.carrierLogoLable.hidden     = NO;
        self.carrierLogoLable.text = (NSString*)carrierLogo;
        self.carrierLogoLable.backgroundColor = [UIColor colorWithHexString:carrierBackgroundColor alpha:1];
    }
    self.carrierNameLabel.text    = carrierName;
    self.carrierCountryLabel.text = countryName;
    
}

-(void)hideLineViewWithShouldHide:(BOOL)shouldHide{
    if(shouldHide){
        self.lineView.hidden = YES;
    }
    else{
        self.lineView.hidden = NO;
    }
       
}


#pragma mark - 点击事件，进入help页面
-(void)tapGestureAction:(UITapGestureRecognizer*)gesture{
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(statusLabelRegionClickWithIsDestination:)]){
        [self.delegate statusLabelRegionClickWithIsDestination:self.isDestination];
    }
    
    if(_shouldShouldInformation && self.delegate &&  [self.delegate respondsToSelector:@selector(informationImageRegionClickWithUrl:carrierCode:)]){
        [self.delegate informationImageRegionClickWithUrl:self.carrierUrl carrierCode:self.carrierCode];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if(!_isMutableCarrier || _shouldShouldInformation){
        return YES;
    }
    else{
        return NO;
    }
}

#pragma mark - 在选择运输商的页面不需要特殊处理selectBackGroundView
-(void)hideCustomSelectBackGroundView{
//    self.customSelectBackGroundView.hidden = YES;
//    self.bottomWhiteSpaceView.hidden = YES;
}
@end
