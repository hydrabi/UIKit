//
//  AnimationView.m
//  Loading
//
//  Created by Hydra on 2017/2/8.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "AnimationView.h"
#import <POP/POP.h>

static const CGFloat cloudWidth = 39.0f;
static const CGFloat cloudHeight = 28.0f;
static const CGFloat largeRate = 1.2f;
static const CGFloat smallFrontRate = 0.7f;
static const CGFloat smallBackRate = 0.5f;

static const CGFloat origamiDeviceWidth = 375.0f;

static const CGFloat origamiLargeCloudOriginCenterX = 240.0f;
static const CGFloat origamiLargeCloudDesitionX = -240.0f;

static const CGFloat origamiSmallFrontCloudOriginCenterX = 315.0f;
static const CGFloat origamiSmallFrontCloudDesitionX = -288.0f;

static const CGFloat origamiSmallBackCloudOriginCenterX = 364.0f;
static const CGFloat origamiSmallBackCloudDesitionX = -299.0f;

@interface AnimationView()
@property (nonatomic,strong)UIImageView *ballImage;
@property (nonatomic,strong)UIImageView *largeCloudImage;
@property (nonatomic,strong)UIImageView *smallFrontCloudImage;
@property (nonatomic,strong)UIImageView *smallBackCloudImage;
@end

@implementation AnimationView

-(instancetype)init{
    self = [super init];
    if(self){
        [self UIConfig];
        [self makeConstraints];
    }
    return self;
}

-(void)UIConfig{
    self.backgroundColor = [UIColor lightGrayColor];
    self.clipsToBounds = YES;
    
    
    self.largeCloudImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud"]];
    [self addSubview:self.largeCloudImage];
    
    self.smallFrontCloudImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud"]];
    [self addSubview:self.smallFrontCloudImage];
    
    self.smallBackCloudImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud"]];
    [self addSubview:self.smallBackCloudImage];
    
    self.ballImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball"]];
    self.ballImage.layer.anchorPoint = CGPointMake(0.5, 0);
    [self addSubview:self.ballImage];
}

-(void)makeConstraints{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat largeCloudCenterX = origamiLargeCloudOriginCenterX / origamiDeviceWidth * screenWidth;
    CGFloat smallFrontCenterX = origamiSmallFrontCloudOriginCenterX / origamiDeviceWidth * screenWidth;
    CGFloat smallBackCenterX = origamiSmallBackCloudOriginCenterX / origamiDeviceWidth * screenWidth;
    __weak typeof(self)weakSelf = self;
    [self.ballImage makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(weakSelf.centerX).offset(0);
        make.width.equalTo(60.0f);
        make.height.equalTo(93.0f);
        make.centerY.equalTo(self.top).offset(-36.0f);
    }];
    
    [self.largeCloudImage makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@(cloudWidth * largeRate));
        make.height.equalTo(@(cloudHeight * largeRate));
        make.centerY.equalTo(weakSelf.centerY).offset(0);
        make.centerX.equalTo(weakSelf.centerX).offset(@(largeCloudCenterX));
    }];
    
    [self.smallFrontCloudImage makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@(cloudWidth * smallFrontRate));
        make.height.equalTo(@(cloudHeight * smallFrontRate));
        make.centerY.equalTo(weakSelf.centerY).offset(13.0f);
        make.centerX.equalTo(weakSelf.centerX).offset(@(smallFrontCenterX));
    }];
    
    [self.smallBackCloudImage makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@(cloudWidth * smallBackRate));
        make.height.equalTo(@(cloudHeight * smallBackRate));
        make.centerY.equalTo(weakSelf.centerY).offset(-7.0f);
        make.centerX.equalTo(weakSelf.centerX).offset(@(smallBackCenterX));
    }];
}

-(void)performAniamtion{
    POPBasicAnimation *animRotation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    animRotation.fromValue = @(0);
    animRotation.toValue = @(12.0f*M_PI/180.0f);
    animRotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animRotation.autoreverses = YES;
    animRotation.duration = 0.4;
    animRotation.repeatForever = YES;
    
    POPBasicAnimation *animPositionY = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationY];
    animPositionY.toValue = @(-4.0f);
    animPositionY.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animPositionY.autoreverses = YES;
    animPositionY.duration = 0.4;
    animPositionY.repeatForever = YES;
    
    [self.ballImage.layer pop_addAnimation:animRotation forKey:@"ballRotationAnim"];
    [self.ballImage.layer pop_addAnimation:animPositionY forKey:@"ballPositionYAnim"];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat largeCloudToValue = (origamiLargeCloudDesitionX - origamiLargeCloudOriginCenterX)/ origamiDeviceWidth * screenWidth;
    CGFloat smallFrontToValue = (origamiSmallFrontCloudDesitionX - origamiSmallFrontCloudOriginCenterX) / origamiDeviceWidth * screenWidth;
    CGFloat smallBackToValue = (origamiSmallBackCloudDesitionX - origamiSmallBackCloudOriginCenterX) / origamiDeviceWidth * screenWidth;
    
    POPBasicAnimation *largeCloudPositionXAni = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationX];
    
    largeCloudPositionXAni.toValue = @(largeCloudToValue);
    largeCloudPositionXAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    largeCloudPositionXAni.duration = 0.6;
    largeCloudPositionXAni.repeatForever = YES;
    [self.largeCloudImage.layer pop_addAnimation:largeCloudPositionXAni forKey:@"largeCloudPositionXAni"];
    
    POPBasicAnimation *somallFrontCloudPositionXAni = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationX];
    
    somallFrontCloudPositionXAni.toValue = @(smallFrontToValue);
    somallFrontCloudPositionXAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    somallFrontCloudPositionXAni.duration = 0.8;
    somallFrontCloudPositionXAni.repeatForever = YES;
    [self.smallFrontCloudImage.layer pop_addAnimation:somallFrontCloudPositionXAni forKey:@"somallFrontCloudPositionXAni"];
    
    POPBasicAnimation *somallBackCloudPositionXAni = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationX];
    
    somallBackCloudPositionXAni.toValue = @(smallBackToValue);
    somallBackCloudPositionXAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    somallBackCloudPositionXAni.duration = 1.5;
    somallBackCloudPositionXAni.repeatForever = YES;
    [self.smallBackCloudImage.layer pop_addAnimation:somallBackCloudPositionXAni forKey:@"somallBackCloudPositionXAni"];
    
}

-(void)stopAniamtion{
    [self.ballImage.layer pop_removeAllAnimations];
    [self.largeCloudImage.layer pop_removeAllAnimations];
    [self.smallBackCloudImage.layer pop_removeAllAnimations];
    [self.smallFrontCloudImage.layer pop_removeAllAnimations];
    
    self.ballImage.layer.transform = CATransform3DIdentity;
    self.largeCloudImage.layer.transform = CATransform3DIdentity;
    self.smallBackCloudImage.layer.transform = CATransform3DIdentity;
    self.smallFrontCloudImage.layer.transform = CATransform3DIdentity;
}

@end
