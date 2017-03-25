//
//  YQTrackListEmptyCollectionViewCell.m
//  Pods
//
//  Created by Hydra on 2017/3/23.
//
//

#import "YQTrackListEmptyCollectionViewCell.h"
#import "NUIRenderer.h"
@implementation YQTrackListEmptyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.boxImageView setImage:[UIImage imageNamed:@"cell_TrackListEmpty"]];
    
    [NUIRenderer renderLabel:self.tipsLabel
                   withClass:@"Label_Large_87"];
    self.tipsLabel.numberOfLines = 0;
    self.tipsLabel.textAlignment = NSTextAlignmentCenter;
    
    self.backgroundColor = [UIColor clearColor];
}

@end
