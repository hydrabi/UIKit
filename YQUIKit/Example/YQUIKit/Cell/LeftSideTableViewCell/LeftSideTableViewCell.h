//
//  LeftSideTableViewCell.h
//  YQTrack
//
//  Created by 毕志锋 on 15/7/25.
//  Copyright (c) 2015年 17track. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftSideTableViewCell : UITableViewCell
/**
 *  顶部的图片
 */
@property (weak, nonatomic) IBOutlet UILabel *leadingIconLabel;
/**
 *  每一个分栏的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  尾部的v型图片
 */
@property (weak, nonatomic) IBOutlet UILabel *indicatorLabel;

/**重新设值*/
-(void)resetValueWithIndexPath:(NSIndexPath*)indexPath;
@end
