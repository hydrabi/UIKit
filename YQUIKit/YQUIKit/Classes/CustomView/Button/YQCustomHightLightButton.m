//
//  CustomHightLightButton.m
//  YQTrack
//
//  Created by 毕志锋 on 15/9/22.
//  Copyright (c) 2015年 17track. All rights reserved.
//

#import "YQCustomHightLightButton.h"

@interface YQCustomHightLightButton()

/**
 *  之前的透明度
 */
@property (nonatomic,assign)CGFloat originAlpha;

@end

@implementation YQCustomHightLightButton

-(instancetype)init{
    self = [super init];
    if(self){
        self.adjustsImageWhenHighlighted = NO;
        self.alpha = 1.0f;
    }
    return self;
}

-(void)setAlpha:(CGFloat)alpha{
    [super setAlpha:alpha];
    if(self.originAlpha == 0){
        self.originAlpha = alpha;
    }
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.adjustsImageWhenHighlighted = NO;
    self.alpha = 1.0f;
}

- (void)setHighlighted:(BOOL)highlighted {
    
    [super setHighlighted:highlighted];
    [self tweakState:highlighted];
    
}

- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    [self tweakState:selected];
}

- (void)tweakState:(BOOL)state {
    
    if (state) {
        self.alpha = 0.3;
    }
    else {
        self.alpha = self.originAlpha;
    }
}

@end
