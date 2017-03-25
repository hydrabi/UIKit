//
//  UITabelViewSeparatorView.m
//  YQTrack
//
//  Created by 毕志锋 on 15/9/15.
//  Copyright (c) 2015年 17track. All rights reserved.
//

#import "YQSeparatorTableViewCell.h"
#import "UIColor+Addition.h"
#import "YQUIDefinitions.h"
#ifdef __OBJC__
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#endif
@interface YQSeparatorTableViewCell()

@end

@implementation YQSeparatorTableViewCell

-(void)awakeFromNib{

    if(!self.aboveLineView){
        self.aboveLineView = [[UIView alloc] init];
        self.aboveLineView.backgroundColor = [YQUIDefinitions getColor:@"@Color_Dark_12"];
        [self addSubview:self.aboveLineView];
        [self.aboveLineView makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.top).offset(0);
            make.leading.equalTo(self.leading).offset([YQUIDefinitions getFloat:@"@Leading_16"]);
            make.trailing.equalTo(self.trailing).offset(0);
            make.height.equalTo(@1);
        }];
    }
    
    if(!self.floorLineView){
        self.floorLineView = [[UIView alloc] init];
        self.floorLineView.backgroundColor = [YQUIDefinitions getColor:@"@Color_Dark_12"];;
        [self addSubview:self.floorLineView];
        [self.floorLineView makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(self.bottom).offset(0);
            make.leading.equalTo(self.leading).offset([YQUIDefinitions getFloat:@"@Leading_16"]);
            make.trailing.equalTo(self.trailing).offset(0);
            make.height.equalTo(@1);
        }];
    }
    
    [self hideBothLine];
}

#pragma mark - 展示线条

-(void)showAboveLine{
    self.aboveLineView.hidden = NO;
    self.floorLineView.hidden = YES;
}

-(void)showFloorLine{
    self.floorLineView.hidden = NO;
    self.aboveLineView.hidden = YES;
}

-(void)showBothLine{
    self.floorLineView.hidden = NO;
    self.aboveLineView.hidden = NO;
}

-(void)hideBothLine{
    self.floorLineView.hidden = YES;
    self.aboveLineView.hidden = YES;
}
@end
