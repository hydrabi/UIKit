//
//  YQColorView.m
//  NUITest
//
//  Created by Hydra on 2017/1/10.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "YQColorView.h"
//#import "NUIStyleParser+Definition.h"
//#import "YQStyleConfigration.h"
#import "NUISettings.h"
#import "YQUIDefinitions.h"
@interface YQColorView()
@property (nonatomic,strong)NSArray *colors;
@end

@implementation YQColorView

-(instancetype)initWithColors:(NSArray*)colors frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.colors = colors;
        [self UIConfig];
    }
    return self;
}

-(void)UIConfig{
    CGFloat yOffset = 0.0f;
    CGFloat width = 120.0f;
    CGFloat height = [YQUIDefinitions getFloat:@"@Normal_Height_44"];
    CGFloat xOffset = [YQUIDefinitions getFloat:@"@Leading_16"];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, width, height)];
    NSString *colorName = [self.colors[0] componentsSeparatedByString:@"_"][1];
    label.text = colorName;
    [self addSubview:label];
    yOffset += height;
    
    for(NSInteger i = 0; i< self.colors.count;i++){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, width, height)];
        label.textAlignment = NSTextAlignmentCenter;
        NSString *colorKey = self.colors[i];
        NSString *nameStr = [colorKey componentsSeparatedByString:@"_"].lastObject;
        NSString *valueStr = [YQUIDefinitions getProperty:colorKey];
        label.text =  [NSString stringWithFormat:@"%@ / %@",nameStr,valueStr];
        UIColor *color = [YQUIDefinitions getColor:self.colors[i]];
        label.backgroundColor = color;
        [self addSubview:label];
        yOffset+=height;
    }
    
}

@end
