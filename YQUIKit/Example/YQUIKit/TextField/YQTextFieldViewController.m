//
//  YQTextFieldViewController.m
//  YQUIKit
//
//  Created by Hydra on 2017/3/2.
//  Copyright © 2017年 hydrabi. All rights reserved.
//

#import "YQTextFieldViewController.h"
#import "YQIndicatorTextFieldControl.h"
#import "YQPasswordTextFieldControl.h"
#import "YQTrailButtonTextFieldControl.h"
#import "NSArray+YQResource.h"

@interface YQTextFieldViewController ()
@property (nonatomic,weak)IBOutlet YQBasicTextFieldControl *basicTextField;
@property (nonatomic,weak)IBOutlet YQIndicatorTextFieldControl *indicatorTextField;
@property (nonatomic,weak)IBOutlet YQPasswordTextFieldControl *passwordTextField;
@property (nonatomic,weak)IBOutlet YQTrailButtonTextFieldControl *trailButtonTextField;
@end

@implementation YQTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initilize];
    [self signalConfig];
    
    [self.basicTextField setPlaceHolderText:@"Hint text"];
    [self.basicTextField setLineViewBeResponsed];
    [self.indicatorTextField setPlaceHolderText:@"Hint text"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self chosenFirstTextField];
}

#pragma mark - 初始化
-(void)initilize{
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    self.tapGesture.cancelsTouchesInView = NO;
    [self.tapGesture setDelegate:self];
    
//    @weakify(self)
//    [[[[NSNotificationCenter defaultCenter]
//       rac_addObserverForName:NotificationKey_SystemLanguageHadChange
//       object:nil]
//      deliverOnMainThread]
//     subscribeNext:^(id _){
//         @strongify(self)
//         [self reloadWord];
//     }];
}

-(void)signalConfig{
    @weakify(self)
    //返回键点击
    [[self rac_signalForSelector:@selector(textFieldShouldReturn:)
                    fromProtocol:@protocol(UITextFieldDelegate)]
     subscribeNext:^(RACTuple *tuple){
         @strongify(self)
         [self getFirstResponderControlWithTextField:tuple.first];
         [self.firstResponderTextField setLineViewBeResponsed];
     }];
    
    //开始编辑
    [[[[NSNotificationCenter defaultCenter]
       rac_addObserverForName:UITextFieldTextDidBeginEditingNotification
       object:nil]
      deliverOnMainThread]
     subscribeNext:^(NSNotification *notification){
         @strongify(self)
         if([notification.object isKindOfClass:[UITextField class]]){
             [self getFirstResponderControlWithTextField:(UITextField*)notification.object];
         }
         [self.firstResponderTextField.window addGestureRecognizer:_tapGesture];
         [self.firstResponderTextField setLineViewBeResponsed];
     }];
    
    //结束编辑
    [[[[NSNotificationCenter defaultCenter]
       rac_addObserverForName:UITextFieldTextDidEndEditingNotification
       object:nil]
      deliverOnMainThread]
     subscribeNext:^(NSNotification *notification){
         @strongify(self)
         self.firstResponderTextField = nil;
         [self.firstResponderTextField.window removeGestureRecognizer:_tapGesture];
         [self unSelectedTextFieldSeparateLine];
     }];
    
}

//获取当前页面所有textField
-(NSMutableArray*)respoderTextField{
    NSMutableArray *textFields = @[].mutableCopy;
    NSArray *subviews = self.view.subviews;
    for(UIView *subview in subviews){
        if([subview isKindOfClass:[YQBasicTextFieldControl class]]){
            [textFields addObject:subview];
        }
    }
    //按照位置排序
    textFields = [textFields sortedArrayByPosition].mutableCopy;
    return textFields;
}

//收集改视图内的所有textField
-(void)cellectTextFieldAndFrame{
    if(!self.textFields){
        self.textFields                       = [self respoderTextField];
        NSMutableArray *originTextFieldFrames = @[].mutableCopy;
        for(UITextField *subTextField in self.textFields){
            CGRect frame = subTextField.frame;
            [originTextFieldFrames addObject:[NSValue valueWithCGRect:frame]];
        }
        self.textFieldOriginFrames = originTextFieldFrames;
    }
}

#pragma mark - textFieldControl处理
-(void)getFirstResponderControlWithTextField:(UITextField*)textField{
    for(YQBasicTextFieldControl *control in self.textFields){
        if(control.textField == textField)
        {
            self.firstResponderTextField = control;
        }
    }
}

-(YQBasicTextFieldControl*)dealWithTextFieldReturn:(UITextField*)textField{
    [self getFirstResponderControlWithTextField:textField];
    
    if(textField.returnKeyType == UIReturnKeyNext){
        NSInteger index = [self.textFields indexOfObject:self.firstResponderTextField];
        if(index<self.textFields.count-1){
            YQBasicTextFieldControl *nextTextField = self.textFields[index+1];
            [nextTextField.textField becomeFirstResponder];
            [nextTextField setLineViewBeResponsed];
            return nextTextField;
        }
    }
    else if (textField.returnKeyType == UIReturnKeyDone){
        
    }
    return nil;
}

-(void)unSelectedTextFieldSeparateLine{
    for(YQBasicTextFieldControl *control in self.textFields){
        [control setLineViewNormal];
    }
}

//首次出现第一个输入框变成第一响应者
-(void)chosenFirstTextField{
    [self cellectTextFieldAndFrame];
    if(self.textFields.count>0){
        YQBasicTextFieldControl *textFieldControl = self.textFields[0];
        [textFieldControl.textField becomeFirstResponder];
    }
}

#pragma mark - 清空textField
-(void)clearAllTextField{
    for(UITextField *textField in self.textFields){
        textField.text = @"";
    }
}

#pragma mark - 点击手势响应事件
- (void)tapGestureAction:(UITapGestureRecognizer*)gesture  // (Enhancement ID: #14)
{
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        [self.firstResponderTextField.textField resignFirstResponder];
    }
}

#pragma mark - UIGestureRecognizerDelegate
//是否允许两个手势识别器同时被识别
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

//按钮等不会受到影响
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return ([[touch view] isKindOfClass:[UIControl class]] || [[touch view] isKindOfClass:[UINavigationBar class]]) ? NO : YES;
}


@end
