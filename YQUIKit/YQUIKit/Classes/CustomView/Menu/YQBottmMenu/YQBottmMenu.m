//
//  YQBottmMenu.m
//  Pods
//
//  Created by Hydra on 2017/2/24.
//
//

#import "YQBottmMenu.h"
#import "ReactiveCocoa.h"
#import "YQUIDefinitions.h"
#import "YQBottmMenuCell.h"

#ifdef __OBJC__
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#endif

static NSString *cellReuseIdentifier = @"cellReuseIdentifier";

@interface YQBottmMenu()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,copy)BottomMenuCallback callback;
@property (nonatomic,strong)NSMutableArray *menuTypes;
@property (nonatomic,strong)UIView *backgroundDarkView;
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation YQBottmMenu

#pragma mark - 初始化
+(YQBottmMenu*)homeMenuWithCallback:(BottomMenuCallback)callback{
    return [self menuWithCallback:callback
                        menuTypes:
            @(YQMenuTypeEdit),
            @(YQMenuTypeScan),
            @(YQMenuTypeDonate),
            @(YQMenuTypeCancel),
            nil];
}

+(YQBottmMenu*)menuWithCallback:(BottomMenuCallback)callback menuTypes:(NSNumber*)types,...{
    va_list argementList;
    NSNumber *eachObject;
    NSMutableArray *typesArr = nil;
    if(types){
        typesArr = [[NSMutableArray alloc] initWithObjects:types, nil];
        va_start(argementList, types);
        while (eachObject = va_arg(argementList, NSNumber*)) {
            [typesArr addObject:eachObject];
        }
        va_end(argementList);
    }
    
    return [[self alloc] initWithCallback:callback
                                menuTypes:typesArr];
}

-(id)initWithCallback:(BottomMenuCallback)callback menuTypes:(NSMutableArray*)types{
    if(self = [super init]){
        self.callback = callback;
        self.menuTypes = types;
        [self UIConfig];
        [self registerNib];
    }
    return self;
}

#pragma mark - UI
-(void)UIConfig{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    @weakify(self)
    [self makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.edges.equalTo(window);
    }];
    
    self.backgroundDarkView = [[UIView alloc] init];
    self.backgroundDarkView.alpha = 0;
    self.backgroundDarkView.userInteractionEnabled = NO;
    self.backgroundDarkView.backgroundColor = [UIColor colorWithRed:(46)/255.0f\
                                                              green:(49)/255.0f\
                                                               blue:(50)/255.0f\
                                                              alpha:1.0];
    [self addSubview:self.backgroundDarkView];
    [self.backgroundDarkView makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelClick)];
    [self.backgroundDarkView addGestureRecognizer:tap];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    
    CGFloat height = [YQUIDefinitions getFloat:@"@Normal_Height_48"] * self.menuTypes.count;
    [self.tableView makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.left.and.right.and.bottom.equalTo(self);
        make.height.equalTo(height);
    }];
    self.tableView.transform = CGAffineTransformMakeTranslation(0, height);
    
    
}

#pragma mark - register
-(void)registerNib{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"YQUIKit" ofType:@"bundle"];
    NSBundle *YQUIKitBundle = [NSBundle bundleWithPath:bundlePath];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQBottmMenuCell class])
                                               bundle:YQUIKitBundle]
         forCellReuseIdentifier:cellReuseIdentifier];
    
}

#pragma mark - 事件
-(void)cancelClick{
    [self hideMenuWithSelectedType:YQMenuTypeCancel];
}

-(void)show{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.backgroundDarkView.alpha = 0.3;
                         self.backgroundDarkView.userInteractionEnabled = YES;
                         self.tableView.transform = CGAffineTransformIdentity;
                     }completion:^(BOOL finished){
                         
                     }];
}

-(void)hideMenuWithSelectedType:(YQMenuType)type{
    if(self.callback){
        self.callback(type);
    }
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.backgroundDarkView.alpha = 0;
                         self.backgroundDarkView.userInteractionEnabled = NO;
                         CGFloat height = [YQUIDefinitions getFloat:@"@Normal_Height_48"] * self.menuTypes.count;
                         self.tableView.transform = CGAffineTransformMakeTranslation(0, height);
                     }completion:^(BOOL finished){
                         [weakSelf removeFromSuperview];
                     }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YQBottmMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier
                                                            forIndexPath:indexPath];
    if(self.menuTypes.count>indexPath.row){
        [cell resetValueWithBottomMenuType:[self.menuTypes[indexPath.row] integerValue]];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [YQUIDefinitions getFloat:@"@Normal_Height_48"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.menuTypes.count>indexPath.row){
        [self hideMenuWithSelectedType:[self.menuTypes[indexPath.row] integerValue]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
