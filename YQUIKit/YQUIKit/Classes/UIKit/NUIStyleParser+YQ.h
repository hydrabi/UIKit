//
//  NUIStyleParser+YQ.h
//  NUITest
//
//  Created by Hydra on 2017/1/17.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "NUIStyleParser.h"


/**
 拓展NUIStyleParser方法以实现对definition的直接获取
 */
@interface NUIStyleParser (YQ)
- (NSMutableDictionary*)getStylesFromFiles:(NSArray*)fileNames;
@end
