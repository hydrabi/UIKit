//
//  YQTrackListLoadingCollectionViewCell.h
//  Pods
//
//  Created by Hydra on 2017/3/23.
//
//

#import <UIKit/UIKit.h>

@interface YQTrackListLoadingCollectionViewCell : UICollectionViewCell
/**
 *  用字体的时候显示这个
 */
@property (weak, nonatomic) IBOutlet UILabel *logoLable;
/**
 单号或备注名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 *  指示器
 */
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
