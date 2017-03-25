//
//  YQTrackListEmptyTabelViewCell.m
//  Pods
//
//  Created by Hydra on 2017/3/13.
//
//

#import "YQTrackListEmptyTabelViewCell.h"
#import "NUIRenderer.h"
@implementation YQTrackListEmptyTabelViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.boxImageView setImage:[UIImage imageNamed:@"cell_TrackListEmpty"]];
    
    [NUIRenderer renderLabel:self.tipsLabel
                   withClass:@"Label_Large_87"];
    self.tipsLabel.numberOfLines = 0;
    self.tipsLabel.textAlignment = NSTextAlignmentCenter;
    
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
