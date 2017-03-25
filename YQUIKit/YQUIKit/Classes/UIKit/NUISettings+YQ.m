//
//  NUISettings+YQ.m
//  NUITest
//
//  Created by Hydra on 2017/1/17.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "NUISettings+YQ.h"
#import "NUIStyleParser+YQ.h"
#import "NUIAppearance.h"


//提取私有方法，复制实现，避免未来因为官方方法修改导致异常
@interface NUISettings (PullUpMethod)
+ (NUISettings*)getInstance;
+ (NSString *)stylesheetOrientationFromInterfaceOrientation:(UIInterfaceOrientation)orientation;
@end

@implementation NUISettings (PullUpMethod)

    
static NUISettings *instance = nil;
    
+ (NUISettings*)getInstance{
    @synchronized(self) {
        if (instance == nil) {
            [[NUISwizzler new] swizzleAll];
            instance = [NUISettings new];
        }
    }
        
    return instance;
}

    
+ (NSString *)stylesheetOrientationFromInterfaceOrientation:(UIInterfaceOrientation)orientation
    {
        return UIInterfaceOrientationIsLandscape(orientation) ? @"landscape" : @"portrait";
    }
    
    
@end

@implementation NUISettings (YQ)


+ (void)initWithStylesheets:(NSArray*)names
{
    instance = [self getInstance];
    if(names.count>0){
        instance.stylesheetName = names[0];
    }
    
    if (!instance.additionalStylesheetNames)
        instance.additionalStylesheetNames = [NSMutableArray array];
    
    //保存styleSheet名称
    for(NSString *name in names){
        [instance.additionalStylesheetNames addObject:name];
    }
    
    //保存屏幕方向
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    instance.stylesheetOrientation = [self stylesheetOrientationFromInterfaceOrientation:orientation];
    
    //解析文件
    NUIStyleParser *parser = [[NUIStyleParser alloc] init];
    instance.styles = [parser getStylesFromFiles:names];
    
    [NUIAppearance init];
}

@end
