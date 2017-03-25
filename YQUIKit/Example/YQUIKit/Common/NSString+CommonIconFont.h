//
//  NSString+NavigationItemIcon.h
//  YQTrack
//
//  Created by Hydra on 16/4/14.
//  Copyright © 2016年 17track. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *const iconFontName = @"17icon";
@interface NSString (CommonIconFont)

/**
 *  将html字符串中的超链接解析出来
 *
 *  @param str      html字符串
 *  @param callback 回调
 */
+(void)analytic:(NSString *)str callback:(void (^)(id))callback;
@end
