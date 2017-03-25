//
//  YQCustomNavigationView.m
//  Pods
//
//  Created by Hydra on 2017/2/20.
//
//

#import "YQCustomNavigationView.h"
#import "YQUIKit.h"
#import "NUIRenderer.h"
#import "YQResourceLib.h"
#import "YQCustomHightLightButton.h"
#import "YQPortraitButton.h"
#import "ReactiveCocoa.h"
#import "YQTarBar.h"
#import "GJRedDot.h"
#import "YQCircleIconButton.h"
#import "YQCheckBox.h"
#ifdef __OBJC__
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#endif

static const CGFloat topOffset = 20.0f;
static const CGFloat leftOffset = 16.0f;

@interface YQCustomNavigationView()
//回调
@property (nonatomic,copy) NavigationCallBack callBack;
//左边item枚举队列
@property (nonatomic,strong)NSArray *leftBtnsTypeArr;
//左边item队列
@property (nonnull,nonatomic,strong)NSMutableArray<UIView*> *leftBtnsArr;
//右边item枚举队列
@property (nonatomic,strong)NSArray *rightBtnsTypeArr;
//右边item队列
@property (nonnull,nonatomic,strong)NSMutableArray<UIView*> *rightBtnsArr;
//背景风格
@property (nonatomic,assign)NavigationBackgroundStyle backgroundStyle;
//父控制器
@property (nonatomic,weak)UIViewController *parent;
//背景图层
@property (nonatomic,strong)UIView *bgView;
//阴影图层
@property (nonatomic,strong)UIView *shadowBackgroundView;
//居中的item类型
@property (nonatomic,assign)NavigationItemStyle middleStyle;
//标题label
@property (nonatomic,weak)UILabel *titleLabel;
@end

@implementation YQCustomNavigationView
#pragma mark - 属性初始化
-(NSMutableArray*)leftBtnsArr{
    if(_leftBtnsArr == nil){
        _leftBtnsArr = @[].mutableCopy;
    }
    return _leftBtnsArr;
}

-(NSMutableArray*)rightBtnsArr{
    if(_rightBtnsArr == nil){
        _rightBtnsArr = @[].mutableCopy;
    }
    return _rightBtnsArr;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    if(self.shadowBackgroundView == nil){
        self.shadowBackgroundView = [[UIView alloc] init];
        self.shadowBackgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.shadowBackgroundView];
        
        @weakify(self)
        [self.shadowBackgroundView makeConstraints:^(MASConstraintMaker *make){
            @strongify(self)
            make.leading.equalTo(self.leading);
            make.trailing.equalTo(self.trailing);
            make.top.equalTo(self.top);
            make.bottom.equalTo(self.bottom);
        }];
    }
    
    if(self.bgView == nil){
        self.bgView = [[UIView alloc] init];
        [self addSubview:self.bgView];
        
        @weakify(self)
        [self.bgView makeConstraints:^(MASConstraintMaker *make){
            @strongify(self)
            make.leading.equalTo(self.leading);
            make.trailing.equalTo(self.trailing);
            make.top.equalTo(self.top);
            make.bottom.equalTo(self.bottom);
        }];
    }
    
    if(self.navigationBarView == nil){
        self.navigationBarView = [[UIView alloc] init];
        self.navigationBarView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.navigationBarView];
        
        @weakify(self)
        [self.navigationBarView makeConstraints:^(MASConstraintMaker *make){
            @strongify(self)
            make.leading.equalTo(self.leading);
            make.trailing.equalTo(self.trailing);
            make.top.equalTo(topOffset);
            make.bottom.equalTo(self.bottom);
        }];
    }
    
}

-(void)setBackgroundStyle:(NavigationBackgroundStyle)backgroundStyle{
    _backgroundStyle = backgroundStyle;
    //设置背景
    if(_backgroundStyle == NavigationBackgroundStyleBlue){
        self.bgView.backgroundColor = [YQUIDefinitions getColor:@"@Color_Blue"];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    else{
        self.bgView.backgroundColor = [YQUIDefinitions getColor:@"@Color_White"];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

-(void)setTitle:(NSString *)title{
    _title = title;
    if(self.titleLabel){
        self.titleLabel.text = title;
    }
}

//在切换页面的时候改变状态栏风格
-(void)bindViewModel{
    if(self.parent){
        @weakify(self)
        RACSignal *signal = [[[self.parent
           rac_signalForSelector:@selector(viewWillAppear:)]
          deliverOnMainThread]
         subscribeNext:^(id _){
             @strongify(self)
             self.backgroundStyle = _backgroundStyle;
         }];
    }
}

#pragma mark - 内容设定
//首页导航栏设置
-(void)setHomePageContentsWithParent:(UIViewController*)parent isLogin:(BOOL)isLogin middleType:(NavigationItemStyle)middleType handler:(NavigationCallBack)handler{
    NSArray *left = @[@(NavigationStyleHomeLogo)];
    NSArray *right = nil;
    if(isLogin){
        right = @[@(NavigationStyleMenu),
                           @(NavigationStyleHomePortrait),
                           @(NavigationStyleHomeNotification)];
    }
    else{
        right = @[@(NavigationStyleMenu),
                           @(NavigationStyleHomeUnLogin),
                           @(NavigationStyleHomeNotification)];
    }

    self.parent = parent;
    self.callBack = handler;
    [self resetContentsWithLeftBtnsType:left
                              rightBtns:right
                             middleStyle:middleType
                        backgroundStyle:NavigationBackgroundStyleBlue];
    [self.parent.view bringSubviewToFront:self];
}

//其它页面导航栏设置
-(void)setContentWithParent:(UIViewController*)parent
                        title:(NSString*)title
               leftBtnsType:(NSArray*)leftBtnsType
                   middleType:(NavigationItemStyle)middleType
                rightBtnsType:(NSArray<NSNumber*>*)rightBtnsType
              backgroundStyle:(NavigationBackgroundStyle)backgroundStyle
                      handler:(NavigationCallBack)handler{
    
    self.parent = parent;
    self.callBack = handler;
    [self resetContentsWithLeftBtnsType:leftBtnsType
                              rightBtns:rightBtnsType
                            middleStyle:middleType
                        backgroundStyle:backgroundStyle];
    self.title = title;
    [self.parent.view bringSubviewToFront:self];
}

//基本左右item设置
-(void)resetContentsWithLeftBtnsType:(NSArray*)leftBtnsType
                           rightBtns:(NSArray*)rightBtnsType
                         middleStyle:(NavigationItemStyle)middleStyle
                     backgroundStyle:(NavigationBackgroundStyle)backgroundStyle{

    self.backgroundStyle = backgroundStyle;
    self.leftBtnsTypeArr = leftBtnsType;
    self.rightBtnsTypeArr = rightBtnsType;
    self.middleStyle = middleStyle;
    [self.leftBtnsArr makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.rightBtnsArr makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.leftBtnsArr removeAllObjects];
    [self.rightBtnsArr removeAllObjects];
    [self.middleItem removeFromSuperview];
    self.middleItem = nil;
    [self createLeftButtons];
    [self createRightButtons];
    [self createMiddleItem];
    [self bindViewModel];
    
    
}

-(void)showShadow{
    self.shadowBackgroundView.layer.shadowColor = [YQUIDefinitions getColor:@"@Color_Dark_54"].CGColor;
    self.shadowBackgroundView.layer.shadowOffset = CGSizeMake(0, 3);
    self.shadowBackgroundView.layer.shadowRadius = 5.0f;
    self.shadowBackgroundView.layer.shadowOpacity = 1.0f;
}

-(void)hideShadow{
    self.shadowBackgroundView.layer.shadowOffset = CGSizeMake(0, 0);
    self.shadowBackgroundView.layer.shadowOpacity = 0.0f;
}

-(void)showRedDotWithType:(NavigationItemStyle)type isLeft:(BOOL)isLeft withBorder:(BOOL)withBorder borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor offset:(CGPoint)offset{
    NSMutableArray *btnsArr = nil;
    if(isLeft){
        btnsArr = self.leftBtnsArr;
    }
    else{
        btnsArr = self.rightBtnsArr;
    }
    
    for(UIView *view in btnsArr){
        if(view.tag == type){
            if(withBorder){
                [view setRedDotBorderWitdh:borderWidth];
                [view setRedDotBorderColor:borderColor];
                [view setRedDotRadius:4.0f];
            }
            [view setRedDotOffset:offset];
            [self setRedDotKey:[self navigationKeyWithStyle:type]
                  refreshBlock:^(BOOL show) {
                view.showRedDot = show;
            } handler:self];
            break;
        }
    }
    
}
#pragma mark - 设置UI
//点击事件
-(void)buttonClickAction:(UIButton*)btn{
    if(self.callBack){
        self.callBack(btn.tag);
    }
    
    //点击后重新设置红点状态
    NSString *redDotKey = [self navigationKeyWithStyle:btn.tag];
    [btn resetRedDotState:NO forKey:redDotKey];
}

//创建按钮
-(void)createItems:(BOOL)isLeft{
    NSArray *destTypeArr;
    NSMutableArray *destBtnsArr;
    if(isLeft){
        destTypeArr = self.leftBtnsTypeArr;
        destBtnsArr = self.leftBtnsArr;
    }
    else{
        destTypeArr = self.rightBtnsTypeArr;
        destBtnsArr = self.rightBtnsArr;
    }
    
    UIView *lastItem = nil;
    for(NSNumber *type in destTypeArr){
        UIView *item = [self createItemButtonWithType:[type integerValue]];
        [self.navigationBarView addSubview:item];
        [destBtnsArr addObject:item];
        if([item isKindOfClass:[UIButton class]]){
            [(UIButton*)item addTarget:self
                    action:@selector(buttonClickAction:)
          forControlEvents:UIControlEventTouchUpInside];
        }
        
        if([item isKindOfClass:[YQCheckBox class]]){
            [(YQCheckBox *)item addTarget:self
                                   action:@selector(buttonClickAction:)
                         forControlEvents:UIControlEventValueChanged];
        }
        
        [self makeConstraintsWithItem:item
                                lastItem:lastItem
                                type:[type integerValue]
                              isLeft:isLeft];
        lastItem = item;
    }
}

-(void)createLeftButtons{
    [self createItems:YES];
}

-(void)createRightButtons{
    [self createItems:NO];
}

-(UIView*)createItemButtonWithType:(NavigationItemStyle)type{
    if(type == NavigationStyleHomeLogo){
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigationBar_17Track"]];
        imageView.tag = type;
        return imageView;
    }
    else if(type == NavigationStyleTitle){
        UILabel *label = [[UILabel alloc] init];
        if(_backgroundStyle == NavigationBackgroundStyleBlue){
            [NUIRenderer renderLabel:label withClass:@"Label_White_Large"];
        }
        else{
            [NUIRenderer renderLabel:label withClass:@"Label_Bold_Larget_87"];
        }
        label.textAlignment = NSTextAlignmentLeft;
        label.text = self.title;
        label.tag = type;
        self.titleLabel = label;
        return label;
    }
    else if(type == NavigationStyleHomePortrait){
        YQPortraitButton *btn = [[YQPortraitButton alloc] init];
        btn.tag = type;
        return btn;
    }
    else if(type == NavigationStyleHomeUnLogin){
        YQCircleIconButton *btn = [[YQCircleIconButton alloc] init];
        [btn setTitleColor:[YQUIDefinitions getColor:@"@Color_Dark_26"]
                  forState:UIControlStateNormal];
        [btn setTitle:[self navigationItemIconWithStyle:type]
             forState:UIControlStateNormal];
        btn.tag = type;
        return btn;
    }
    else if (type == NavigationStyleCircleCheckBox){
        YQCheckBox *checkBox = [[YQCheckBox alloc] init];
        checkBox.checkBoxType = YQCheckBoxTypeCircle;
        checkBox.tag = type;
        return checkBox;
    }
    else{
        YQCustomHightLightButton *btn = [[YQCustomHightLightButton alloc] init];
        [NUIRenderer renderButton:btn
                        withClass:@"Button_Icon"];
        if(_backgroundStyle == NavigationBackgroundStyleWhite){
            [btn setTitleColor:[YQUIDefinitions getColor:@"@Color_Dark_54"] forState:UIControlStateNormal];
        }

        [btn setTitle:[self navigationItemIconWithStyle:type]
             forState:UIControlStateNormal];
        btn.tag = type;
        return btn;
    }
}

//创建约束，添加内容
-(void)makeConstraintsWithItem:(UIView*)item lastItem:(UIView*)lastItem type:(NavigationItemStyle)type isLeft:(BOOL)isLeft{
    
    __weak typeof(self) weakSelf = self;
    UIView *parentView = item.superview;
    [item makeConstraints:^(MASConstraintMaker *make){
        if(isLeft){
            if(lastItem == nil){
                //首页logo与左边间距16
                if(type == NavigationStyleHomeLogo){
                    make.leading.equalTo(parentView.leading).offset(leftOffset);
                }
                //其余为4
                else{
                    make.leading.equalTo(parentView.leading).offset(4.0f);
                }
            }
            else{
                if(type == NavigationStyleTitle){
                    //与标题与左边的item间距24
                    make.leading.equalTo(lastItem.trailing).offset(24.0f);
                }
                else{
                    make.leading.equalTo(lastItem.trailing);
                }
            }
        }
        else{
            if(lastItem == nil){
                make.trailing.equalTo(parentView.trailing).offset(@(-4.0f));
            }
            else{
                make.trailing.equalTo(lastItem.leading);
            }
        }
        
        
        if(type  == NavigationStyleHomeLogo){
            make.top.equalTo(parentView.top).offset(12);
            make.width.equalTo(126.0f);
            make.height.equalTo(20.0f);
        }
        else if (type == NavigationStyleMenu){
            make.top.equalTo(parentView.top);
            make.width.equalTo(38.0f);
            make.height.equalTo(44.0f);
        }
        else if (type == NavigationStyleTitle){
            make.centerY.equalTo(lastItem.centerY);
        }
        else{
            make.top.equalTo(parentView.top);
            make.width.equalTo(44.0f);
            make.height.equalTo(44.0f);
        }
    }];
}

-(void)createMiddleItem{
    if(self.middleStyle == NavigationStyleTabBar){
        YQTarBar *tabBar = [[YQTarBar alloc] init];
        self.middleItem = tabBar;
        [self.navigationBarView addSubview:tabBar];
        
        @weakify(self)
        [tabBar makeConstraints:^(MASConstraintMaker *make){
            @strongify(self)
            make.centerX.equalTo(self.centerX);
            make.height.equalTo(self.height);
            make.width.equalTo(400.0f);
        }];
        [tabBar resetNormalContentWithTitles:@[@"Shipment",
                                               @"Archive"]
                                    callback:nil];
    }
}

//获取icon的字体
-(NSString*)navigationItemIconWithStyle:(NavigationItemStyle)style{
    NSString *key = @"";
    switch (style) {
        case NavigationStyleSidebar:
            key = @"F701";
            break;
        case NavigationStyleSidebarWithRetDot:
            key = @"F701";
            break;
        case NavigationStyleEdit:
            key = @"F707";
            break;
        case NavigationStyleDismiss:
            key = @"F00E";
            break;
        case NavigationStyleSearch:
            key = @"F03B";
            break;
        case NavigationStyleShare:
            key = @"F03C";
            break;
        case NavigationStyleQRCode:
            key = @"F01B";
            break;
        case NavigationStyleReturn:
            key = @"F607";
            break;
        case NavigationStyleMenu:
            key = @"F02C";
            break;
        case NavigationStyleUnSelect:
            key = @"F403";
            break;
        case NavigationStyleSelect:
            key = @"F00F";
            break;
        case NavigationStyleEditAliasFinsh:
            key = @"F00D";
            break;
        case NavigationStyleEditAliasCancel:
            key = @"F00E";
            break;
        case NavigationStyleIpadEditAlias:
            key = @"F708";
            break;
        case NavigationStyleIpadShare:
            key = @"F022";
            break;
        case NavigationStyleIpadMenu:
            key = @"F02B";
            break;
        case NavigationStyleHomeNotification:
            key = @"F042";
            break;
        case NavigationStyleHomeUnLogin:
            key = @"F013";
            break;
        case NavigationStyleAlbum:
            key = @"F057";
            break;
        default:
            break;
    }
    NSString *result = [YQResourceUIHelper iconFontWithCommonState:key];
    return result;
}

//获取icon的字体
-(NSString*)navigationKeyWithStyle:(NavigationItemStyle)style{
    NSString *key = @"";
    switch (style) {
        case NavigationStyleHomePortrait:
            key = @"portraitkey";
            break;
        case NavigationStyleHomeNotification:
            key = @"notificationkey";
            break;
        default:
            break;
    }

    return key;
}

#pragma mark - 获取指定类型的Item
-(UIView*)getItemWithStyle:(NavigationItemStyle)style isLeft:(BOOL)isLeft{
    UIView *item = nil;
    NSArray *destTypeArr;
    NSMutableArray *destBtnsArr;
    if(isLeft){
        destTypeArr = self.leftBtnsTypeArr;
        destBtnsArr = self.leftBtnsArr;
    }
    else{
        destTypeArr = self.rightBtnsTypeArr;
        destBtnsArr = self.rightBtnsArr;
    }
    
    NSInteger index = [destTypeArr indexOfObject:@(style)];
    if(destBtnsArr.count>index){
        item = destBtnsArr[index];
    }
    
    return item;
}
@end
