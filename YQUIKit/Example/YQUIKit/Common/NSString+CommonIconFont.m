//
//  NSString+NavigationItemIcon.m
//  YQTrack
//
//  Created by Hydra on 16/4/14.
//  Copyright © 2016年 17track. All rights reserved.
//

#import "NSString+CommonIconFont.h"
#import "YQResourceLib.h"
@implementation NSString (CommonIconFont)

+(void)analytic:(NSString *)str callback:(void (^)(id))callback
{
    if (!str.length || !callback)
    {
        return;
    }
    
    NSString *pattern = @"<a target=\"_blank\" href=\"(.*?)\">(.*?)</a>";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSArray *matches = [regex matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    
    NSUInteger lastIdx = 0;
    for (NSTextCheckingResult* match in matches)
    {
        NSRange range = match.range;
        if (range.location > lastIdx)
        {
            //            callback([str substringWithRange:NSMakeRange(lastIdx, range.location - lastIdx)]);
        }
        callback(match);
        lastIdx = range.location + range.length;
        
    }
    if (lastIdx < str.length)
    {
        callback([str substringFromIndex:lastIdx]);
    }
}

@end
