//
//  NUISettings+YQ.h
//  NUITest
//
//  Created by Hydra on 2017/1/17.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "NUISettings.h"

@interface NUISettings (YQ)


/**
 以多张表初始化NUI

 @param names nss文件集合
 */
+ (void)initWithStylesheets:(NSArray*)names;
@end
