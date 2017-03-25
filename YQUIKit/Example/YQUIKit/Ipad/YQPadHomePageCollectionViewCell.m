//
//  YQPadHomePageCollectionViewCell.m
//  YQUIKit
//
//  Created by Hydra on 2017/2/22.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import "YQPadHomePageCollectionViewCell.h"

@implementation YQPadHomePageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1.0f;
}

@end
