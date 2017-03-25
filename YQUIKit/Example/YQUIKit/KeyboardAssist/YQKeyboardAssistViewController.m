//
//  YQKeyboardAssistViewController.m
//  YQUIKit
//
//  Created by Hydra on 2017/3/15.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import "YQKeyboardAssistViewController.h"
#import "YQKeyboardAssistView.h"
@interface YQKeyboardAssistViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet YQKeyboardAssistView *assistView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation YQKeyboardAssistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.assistView setContentWithBtnTypes:@[@(YQKeyboardAssistType_Alphabet),
                                              @(YQKeyboardAssistType_Number),
                                              @(YQKeyboardAssistType_Filter),]
                               keyboardShow:^(CGRect keyboardRect){
                                   if(keyboardRect.origin.y < CGRectGetHeight(self.view.frame)){
                                       self.assistView.hidden = NO;
                                       self.bottomConstraint.constant = keyboardRect.size.height;
                                       //    更新界面
                                       [self.view setNeedsUpdateConstraints];
                                       [self.view updateConstraintsIfNeeded];
                                       [self.view layoutIfNeeded];
                                   }
                               }
                               keyboardHide:^{
                                   self.assistView.hidden = YES;
                               }
                              clickCallback:^(YQKeyboardAssistType type){
                                   
                               }];
    self.textField.autocorrectionType     = UITextAutocapitalizationTypeNone;
//    self.textField.keyboardType           = UIKeyboardTypeASCIICapable;
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

@end
