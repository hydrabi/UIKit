//
//  YQUIDefinitions.h
//  NUITest
//
//  Created by Hydra on 2017/1/12.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NUIStyleSheet.h"
#import "NUIDefinition.h"
#import "NUIRenderer.h"
#import "NUIStyleParser.h"


/**
 * 获得定义的UI参数
 */
@interface YQUIDefinitions : NSObject
@property (nonatomic,strong)NSMutableDictionary *definitions;

+(YQUIDefinitions*)sharedInstance;
-(NSMutableDictionary*)addUIDefinitionsWithFileName:(NSString *)fileName;
-(void)addUIDefinitionsWithFileNames:(NSArray *)fileNames;

+ (BOOL)hasProperty:(NSString*)property;
+ (NSString*)getProperty:(NSString*)property;
+ (BOOL)getBoolean:(NSString*)property;
+ (float)getFloat:(NSString*)property;
+ (CGSize)getSize:(NSString*)property;
+ (UIOffset)getOffset:(NSString*)property;
+ (UIEdgeInsets)getEdgeInsets:(NSString*)property;
+ (UITextBorderStyle)getBorderStyle:(NSString*)property;
+ (UITableViewCellSeparatorStyle)getSeparatorStyle:(NSString*)property;
+ (UIFont*)getFontWithClass:(NSString*)className;
+ (UIFont*)getFontWithClass:(NSString*)className baseFont:(UIFont *)baseFont;
+ (UIColor*)getColor:(NSString*)property;
+ (UIColor*)getColorFromImage:(NSString*)property;
+ (UIImage*)getImageFromColor:(NSString*)property;
+ (UIImage*)getImage:(NSString*)property;
+ (kTextAlignment)getTextAlignment:(NSString*)property;
+ (UIControlContentHorizontalAlignment)getControlContentHorizontalAlignment:(NSString*)property;
+ (UIControlContentVerticalAlignment)getControlContentVerticalAlignment:(NSString*)property;
@end
