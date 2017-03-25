//
//  NSLayoutConstraint+NUI.m
//  NUIDemo
//
//  Created by Halin Lee on 1/4/17.
//  Copyright © 2017 Tom Benner. All rights reserved.
//

#import "NSLayoutConstraint+NUI.h"
#import "NUISettings.h"
#import "objc/runtime.h"
#import "YQUIDefinitions.h"

static void * const kNUIAssociatedNuiDefinition = "nuiDefinition";
@implementation NSLayoutConstraint(NUI)


- (void)setNuiDefinition:(NSString *)nuiDefinition{
    
    objc_setAssociatedObject(self, kNUIAssociatedNuiDefinition, nuiDefinition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
    self.constant = [YQUIDefinitions getFloat:nuiDefinition];
}

- (NSString *)nuiDefinition{
    return objc_getAssociatedObject(self, kNUIAssociatedNuiDefinition);
}

@end
