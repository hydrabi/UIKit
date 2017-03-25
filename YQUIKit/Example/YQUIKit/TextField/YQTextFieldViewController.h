//
//  YQTextFieldViewController.h
//  YQUIKit
//
//  Created by Hydra on 2017/3/2.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQBasicTextFieldControl.h"
@interface YQTextFieldViewController : UIViewController<UITextFieldDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong)NSMutableArray *textFields;
@property (nonatomic,weak)YQBasicTextFieldControl *firstResponderTextField;
@property (nonatomic,strong)NSMutableArray *textFieldOriginFrames;
@property (nonatomic,strong)UITapGestureRecognizer *tapGesture;
@end
