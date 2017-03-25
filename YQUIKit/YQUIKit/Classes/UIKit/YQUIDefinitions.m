//
//  YQUIDefinitions.m
//  NUITest
//
//  Created by Hydra on 2017/1/12.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "YQUIDefinitions.h"

@implementation YQUIDefinitions

-(instancetype)init{
    self = [super init];
    if(self){
        self.definitions = [NSMutableDictionary dictionary];
    }
    return self;
}

+(YQUIDefinitions*)sharedInstance{
    static dispatch_once_t once;
    static YQUIDefinitions * shared = nil;
    dispatch_once(&once, ^{
        shared = [[YQUIDefinitions alloc] init];
    });
    return shared;
}

-(void)addUIDefinitionsWithFileNames:(NSArray *)fileNames{
    for(NSString *fileName in fileNames){
        [self addUIDefinitionsWithFileName:fileName];
    }
}

-(NSMutableDictionary*)addUIDefinitionsWithFileName:(NSString *)fileName{
//        NUISettings *settings
//        unsigned int count = 0;
//        Ivar *members = class_copyIvarList([NUISettings class], &count);
//        for (int i = 0 ; i < count; i++) {
//            Ivar var = members[i];
//            //返回参数名称
//            const char *memberName = ivar_getName(var);
//            //返回类型
//            const char *memberType = ivar_getTypeEncoding(var);
//            NSLog(@"%s----%s", memberName, memberType);
//        }
    
//        unsigned int count1 = 0;
//        Method *memberFuncs = class_copyMethodList([NUIStyleParser class], &count1);//所有在.m文件显式实现的方法都会被找到
//        BOOL findParseMethod = NO;
//        for (int i = 0; i < count1; i++) {
//            SEL name = method_getName(memberFuncs[i]);
//            NSString *methodName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
//            if([methodName isEqualToString:@"parse:"]){
//                findParseMethod = YES;
//            }
//        }
    
    NSMutableDictionary *definitions = [NSMutableDictionary dictionary];
    NUIStyleParser *parser = [[NUIStyleParser alloc] init];
    
    NSAssert([parser respondsToSelector:@selector(parse:)], @"NUI第三方库中类NUIStyleParser无法找到parse:方法");
    
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"nss"];
    NSAssert1(path != nil, @"File \"%@\" does not exist", fileName);
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NUIStyleSheet *sheet = [parser performSelector:@selector(parse:) withObject:content];
    
    for (NUIDefinition *definition in sheet.definitions) {
        definitions[definition.variable] = definition.value;
    }
    
    [self.definitions addEntriesFromDictionary:definitions];
    
    return definitions;
}

+(BOOL)hasProperty:(NSString*)property{
    if([[self sharedInstance].definitions objectForKey:property]){
        return YES;
    }
    return NO;
}

+(NSString*)getProperty:(NSString*)property{
    return [self sharedInstance].definitions[property];
}

+ (BOOL)getBoolean:(NSString*)property
{
    return [NUIConverter toBoolean:[self getProperty:property]];
}

+ (float)getFloat:(NSString*)property
{
    return [NUIConverter toFloat:[self getProperty:property]];
}

+ (CGSize)getSize:(NSString*)property
{
    return [NUIConverter toSize:[self getProperty:property]];
}

+ (UIOffset)getOffset:(NSString*)property
{
    return [NUIConverter toOffset:[self getProperty:property]];
}

+ (UIEdgeInsets)getEdgeInsets:(NSString*)property
{
    return [NUIConverter toEdgeInsets:[self getProperty:property]];
}

+ (UITextBorderStyle)getBorderStyle:(NSString*)property
{
    return [NUIConverter toBorderStyle:[self getProperty:property]];
}

+ (UITableViewCellSeparatorStyle)getSeparatorStyle:(NSString*)property
{
    return [NUIConverter toSeparatorStyle:[self getProperty:property]];
}

+ (UIFont*)getFontWithClass:(NSString*)className
{
    return [self getFontWithClass:className baseFont:nil];
}

+ (UIFont*)getFontWithClass:(NSString*)className baseFont:(UIFont *)baseFont
{
    NSString *propertyName;
    CGFloat fontSize;
    UIFont *font = nil;
    
    propertyName = @"font-size";
    
    if ([self hasProperty:propertyName]) {
        fontSize = [self getFloat:@"font-size"];
    } else {
        fontSize = baseFont ? baseFont.pointSize : [UIFont systemFontSize];
    }
    
    propertyName = @"font-name";
    
    if ([self hasProperty:propertyName]) {
        NSString *fontName = [self getProperty:propertyName];
        
        if ([fontName isEqualToString:@"system"]) {
            font = [UIFont systemFontOfSize:fontSize];
        } else if ([fontName isEqualToString:@"boldSystem"]) {
            font = [UIFont boldSystemFontOfSize:fontSize];
        } else if ([fontName isEqualToString:@"italicSystem"]) {
            font = [UIFont italicSystemFontOfSize:fontSize];
        } else {
            font = [UIFont fontWithName:fontName size:fontSize];
        }
    } else {
        font = baseFont ? [baseFont fontWithSize:fontSize] : [UIFont systemFontOfSize:fontSize];
    }
    
    return font;
}

+ (UIColor*)getColor:(NSString*)property
{
    return [NUIConverter toColor:[self getProperty:property]];
}

+ (UIColor*)getColorFromImage:(NSString*)property
{
    return [NUIConverter toColorFromImageName:[self getProperty:property]];
}

+ (UIImage*)getImageFromColor:(NSString*)property
{
    return [NUIConverter toImageFromColorName:[self getProperty:property]];
}

+ (UIImage*)getImage:(NSString*)property
{
    UIImage *image = [NUIConverter toImageFromImageName:[self getProperty:property]];
    NSString *insetsProperty = [NSString stringWithFormat:@"%@%@", property, @"-insets"];
    if ([self hasProperty:insetsProperty]) {
        UIEdgeInsets insets = [self getEdgeInsets:insetsProperty];
        image = [image resizableImageWithCapInsets:insets];
    }
    return image;
}

+ (kTextAlignment)getTextAlignment:(NSString*)property
{
    return [NUIConverter toTextAlignment:[self getProperty:property]];
}

+ (UIControlContentHorizontalAlignment)getControlContentHorizontalAlignment:(NSString*)property
{
    return [NUIConverter toControlContentHorizontalAlignment:[self getProperty:property]];
}

+ (UIControlContentVerticalAlignment)getControlContentVerticalAlignment:(NSString*)property
{
    return [NUIConverter toControlContentVerticalAlignment:[self getProperty:property]];
}

@end
