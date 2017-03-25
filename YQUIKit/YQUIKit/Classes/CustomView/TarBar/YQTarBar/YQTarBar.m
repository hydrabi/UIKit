//
//  YQTarBar.m
//  Pods
//
//  Created by Hydra on 2017/2/22.
//
//

#import "YQTarBar.h"
#import "ReactiveCocoa.h"
#import "YQUIDefinitions.h"

#ifdef __OBJC__
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#endif

@interface YQTarBar()
//以后可能拓展多个选项
@property (nonatomic,strong)UIScrollView *scrollTabBar;
//下面的选中线条
@property (nonatomic,strong)UIView *lineView;
//按钮集合
@property (nonatomic,strong)NSMutableArray *itemsArr;
//选中按钮的颜色
@property (nonatomic,strong)UIColor *selectedButtonColor;
//未选中按钮的颜色
@property (nonatomic,strong)UIColor *unSelectedButtonColor;
//下划线颜色
@property (nonatomic,strong)UIColor *lineColor;
//标题集合
@property (nonatomic,strong)NSArray *titlesArr;
//回调
@property (nonatomic,copy)TabBarCallback callback;
//阴影图层
@property (nonatomic,strong)UIView *shadowBackgroundView;
//背景图层
@property (nonatomic,strong)UIView *bgView;
@end

@implementation YQTarBar

#pragma mark - 外部调用
-(void)resetNormalContentWithTitles:(NSArray*)titles callback:(TabBarCallback)callback{
    [self resetContentWithTitles:titles
                 backgroundColor:[YQUIDefinitions getColor:@"@Color_Blue"]
             selectedButtonColor:[YQUIDefinitions getColor:@"@Color_White"]
           unSelectedButtonColor:[YQUIDefinitions getColor:@"@Color_White_50"]
                       lineColor:[YQUIDefinitions getColor:@"@Color_White"]
                        callback:callback];
    [self.superview bringSubviewToFront:self];
}

-(void)resetContentWithTitles:(NSArray*)titles backgroundColor:(UIColor*)backgroundColor selectedButtonColor:(UIColor*)selectedButtonColor unSelectedButtonColor:(UIColor*)unSelectedButtonColor lineColor:(UIColor*)lineColor callback:(TabBarCallback)callback{
    self.titlesArr = titles;
    self.bgView.backgroundColor = backgroundColor;
    self.selectedButtonColor = selectedButtonColor;
    self.unSelectedButtonColor = unSelectedButtonColor;
    self.lineColor = lineColor;
    self.callback = callback;
    [self UIConfig];
}

-(void)showShadow{
    self.shadowBackgroundView.layer.shadowColor = [YQUIDefinitions getColor:@"@Color_Dark_54"].CGColor;
    self.shadowBackgroundView.layer.shadowOffset = CGSizeMake(0, 5);
    self.shadowBackgroundView.layer.shadowRadius = 3.0f;
    self.shadowBackgroundView.layer.shadowOpacity = 1.0f;
    
}

-(void)hideShadow{
    self.shadowBackgroundView.layer.shadowOffset = CGSizeMake(0, 0);
    self.shadowBackgroundView.layer.shadowOpacity = 0.0f;
}

#pragma mark - 属性
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
    
}

-(NSMutableArray*)itemsArr{
    if(_itemsArr == nil){
        _itemsArr = @[].mutableCopy;
    }
    return _itemsArr;
}

-(UIScrollView*)scrollTabBar{
    if(_scrollTabBar == nil){
        _scrollTabBar = [[UIScrollView alloc] init];
        _scrollTabBar.showsHorizontalScrollIndicator = NO;
        _scrollTabBar.scrollsToTop = NO;
        [self addSubview:_scrollTabBar];
        
        @weakify(self)
        [_scrollTabBar makeConstraints:^(MASConstraintMaker *make){
            make.leading.equalTo(self.leading);
            make.trailing.equalTo(self.trailing);
            make.top.equalTo(self.top);
            make.bottom.equalTo(self.bottom);
        }];
    }
    return _scrollTabBar;
}

-(void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    
    [self resetButtonTitleColorWithCurrentItemIndex:selectedIndex];
    [self animateLine];
    if(!self.hidden && self.callback){
        self.callback(selectedIndex);
    }
}

#pragma mark - UI配置
-(void)UIConfig{
    [self removeSubviews];
    [self buttonsConfig];
    [self lineViewConfig];
    [self updateSubViewsFrame];
}

-(void)buttonsConfig{
    for(NSInteger index = 0;index<self.titlesArr.count;index++){
        UIButton *button = [[UIButton alloc] init];
        button.titleLabel.font = [UIFont systemFontOfSize:[YQUIDefinitions getFloat:@"@FontSize_14"]];
        [button setBackgroundColor:[UIColor clearColor]];
        if(index == self.selectedIndex){
            [button setTitleColor:self.selectedButtonColor forState:UIControlStateNormal];
        }
        else{
            [button setTitleColor:self.unSelectedButtonColor forState:UIControlStateNormal];
        }
        [button setTitle:self.titlesArr[index]
                forState:UIControlStateNormal];
        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = index;
        [self.scrollTabBar addSubview:button];
        
        [self.itemsArr addObject:button];
    }
}

-(void)lineViewConfig{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat buttonHeight = CGRectGetHeight(self.frame);
    CGFloat lineWidth = width/self.titlesArr.count;
    CGFloat lineHeight = 3.0f;
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = self.lineColor;
    [self.scrollTabBar addSubview:self.lineView];
}

-(void)removeSubviews{
    if(self.lineView && self.lineView.superview){
        [self.lineView removeFromSuperview];
        self.lineView = nil;
    }
    
    [self.itemsArr makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.itemsArr removeAllObjects];
}

//根据是否选中重置按钮的字体颜色
-(void)resetButtonTitleColorWithCurrentItemIndex:(NSInteger)index{
    for(NSInteger i = 0 ;i<self.itemsArr.count;i++){
        if(i != self.selectedIndex){
            [[self.itemsArr objectAtIndex:i] setTitleColor:self.unSelectedButtonColor
                                                  forState:UIControlStateNormal];
        }
        else{
            [[self.itemsArr objectAtIndex:i] setTitleColor:self.selectedButtonColor
                                                  forState:UIControlStateNormal];
        }
    }
}

//重新设置标题
-(void)resetButtonTitleWithNewTitleArr:(NSArray *)titlesArr{
    if(titlesArr.count == self.titlesArr.count ){
        self.titlesArr = titlesArr;
        for(NSInteger i = 0 ;i<self.itemsArr.count;i++){
            [[self.itemsArr objectAtIndex:i] setTitle:self.titlesArr[i] forState:UIControlStateNormal];
        }
    }
}

-(void)animateLine{
    if(self.itemsArr.count>_selectedIndex){
        UIButton *button = self.itemsArr[_selectedIndex];
        [UIView animateWithDuration:0.2f animations:^{
            self.lineView.frame = CGRectMake(button.frame.origin.x,
                                             self.lineView.frame.origin.y,
                                             CGRectGetWidth(button.frame),
                                             CGRectGetHeight(self.lineView.frame));
        }];
    }
    
}

-(void)updateSubViewsFrame{
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat buttonHeight = CGRectGetHeight(self.frame);
    CGFloat buttonWidth = width/self.titlesArr.count;
    CGFloat buttonX = 0.0f;
    for(NSInteger index = 0;index<self.itemsArr.count;index++){
        UIButton *button = self.itemsArr[index];
        button.frame = CGRectMake(buttonX,
                                  0,
                                  buttonWidth,
                                  buttonHeight);
        buttonX+=buttonWidth;
    }
    
    CGFloat lineWidth = width/self.titlesArr.count;
    CGFloat lineHeight = 3.0f;
    if(self.itemsArr.count>_selectedIndex){
        UIButton *button = self.itemsArr[_selectedIndex];
        self.lineView.frame = CGRectMake(button.frame.origin.x,
                                         buttonHeight-lineHeight,
                                         CGRectGetWidth(button.frame),
                                         lineHeight);
    }
   
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self updateSubViewsFrame];
}

#pragma mark - 点击事件
-(void)itemPressed:(UIButton*)button{
    self.selectedIndex = [self.itemsArr indexOfObject:button];
}
@end
