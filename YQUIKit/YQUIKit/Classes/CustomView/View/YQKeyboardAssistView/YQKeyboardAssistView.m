//
//  YQKeyboardAssistView.m
//  Pods
//
//  Created by Hydra on 2017/3/15.
//
//

#import "YQKeyboardAssistView.h"
#import "YQUIKit.h"
#import "NUIRenderer.h"
#import "ReactiveCocoa.h"
#import "UIColor+Addition.h"
#import "YQCustomHightLightButton.h"
#import "YQResourceLib.h"
#ifdef __OBJC__
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#endif

@interface YQKeyboardAssistView()
/**
 按钮枚举类型
 */
@property (nonatomic,strong)NSArray *btnTypeArr;
/**
 按钮类型
 */
@property (nonatomic,strong)NSMutableArray *btnArr;

/**
 父控制器
 */
@property (nonatomic,weak)UIViewController *parent;

/**
 键盘展示回调
 */
@property (nonatomic,copy)keyboardShow showCallback;

/**
 键盘隐藏回调
 */
@property (nonatomic,copy)keyboardHide hideCallback;

/**
 点击回调
 */
@property (nonatomic,copy)clickedCallback clickCallback;
@end

@implementation YQKeyboardAssistView

-(instancetype)init{
    self = [super init];
    if(self){
        [self UIConfig];
        [self bindNotification];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self UIConfig];
        [self bindNotification];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self UIConfig];
        [self bindNotification];
    }
    return self;
}
#pragma mark - 配置UI
-(void)UIConfig{
    self.backgroundColor = [UIColor clearColor];
    self.btnArr = @[].mutableCopy;
}

-(void)setContentWithBtnTypes:(NSArray*)btnTypes
                 keyboardShow:(keyboardShow)keyboardShow
                 keyboardHide:(keyboardHide)keyboardHide
                clickCallback:(clickedCallback)clickCallback{
    self.showCallback = keyboardShow;
    self.hideCallback = keyboardHide;
    self.clickCallback = clickCallback;
    [self resetContentWithBtnTypes:btnTypes];
}

-(void)resetContentWithBtnTypes:(NSArray*)btnTypes{
    self.btnTypeArr = btnTypes;
    [self.btnArr makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.btnArr removeAllObjects];
    [self createButtonAndConstraint];
}

-(void)createButtonAndConstraint{
    UIButton *lastButton = nil;
    for(NSNumber *type in self.btnTypeArr){
        YQCustomHightLightButton *btn = [self createButtonWithType:type.integerValue];
        [self.btnArr addObject:btn];
        [self addSubview:btn];
        
        @weakify(self)
        [btn makeConstraints:^(MASConstraintMaker *make){
            @strongify(self)
            if(lastButton == nil){
                make.leading.equalTo(self.leading);
            }
            else{
                make.leading.equalTo(lastButton.trailing);
                make.width.equalTo(lastButton.width);
            }
            make.top.and.bottom.equalTo(self);
            
            if([type isEqualToValue:[self.btnTypeArr lastObject]]){
                make.trailing.equalTo(self.trailing);
            }
        }];
        lastButton = btn;
    }
}

-(YQCustomHightLightButton*)createButtonWithType:(YQKeyboardAssistType)type{
    YQCustomHightLightButton *btn = [[YQCustomHightLightButton alloc] init];
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#616161" alpha:1]];
    btn.tag = type;
    [btn addTarget:self
            action:@selector(buttonClickAction:)
  forControlEvents:UIControlEventTouchUpInside];
    if(type == YQKeyboardAssistType_Alphabet){
        [btn setTitleColor:[YQUIDefinitions getColor:@"@Color_White"]
                  forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:[YQUIDefinitions getFloat:@"@FontSize_16"]];
        [btn setTitle:@"A~Z"
             forState:UIControlStateNormal];
    }
    else if(type == YQKeyboardAssistType_Number){
        [btn setTitleColor:[YQUIDefinitions getColor:@"@Color_White"]
                  forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:[YQUIDefinitions getFloat:@"@FontSize_16"]];
        [btn setTitle:@"0~9"
             forState:UIControlStateNormal];
    }
    else if(type == YQKeyboardAssistType_Filter){
        [NUIRenderer renderButton:btn
                        withClass:@"Button_Icon"];
        [btn setTitle:[YQResourceUIHelper iconFontWithCommonState:@"F03A"]
             forState:UIControlStateNormal];
    }
    return btn;
}

//点击事件
-(void)buttonClickAction:(UIButton*)btn{
    if(self.clickCallback){
        self.clickCallback(btn.tag);
    }
}

#pragma mark - 绑定键盘消息通知
-(void)bindNotification{
    //键盘将会出现
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter]
      rac_addObserverForName:UIKeyboardWillShowNotification
                                                          object:nil]
     deliverOnMainThread]
     subscribeNext:^(NSNotification *notification){
         @strongify(self)
         NSDictionary *userInfo = [notification userInfo];
         NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
         CGRect keyboardRect = [aValue CGRectValue];
         if(self.superview){
             keyboardRect = [self.superview convertRect:keyboardRect fromView:nil];
         }
         
         if(self.showCallback){
             self.showCallback(keyboardRect);
         }
     }];
    
    //键盘隐藏
    [[[[NSNotificationCenter defaultCenter]
       rac_addObserverForName:UIKeyboardWillHideNotification
       object:nil]
      deliverOnMainThread]
     subscribeNext:^(NSNotification *notification){
         @strongify(self)

         if(self.hideCallback){
             self.hideCallback();
         }
     }];
}
@end
