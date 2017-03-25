//
//  NUIViewRenderer(YQ).m
//  Pods
//
//  Created by Halin Lee on 2/17/17.
//
//

#import "NUIViewRenderer+YQ.h"

@implementation NUIViewRenderer(YQ)

+ (void)renderSize:(UIView*)view withClass:(NSString*)className
{
    CGFloat height = 0;
    if ([NUISettings hasProperty:@"height" withClass:className]) {
        height = [NUISettings getFloat:@"height" withClass:className];
    }
    
    CGFloat width = 0;
    if ([NUISettings hasProperty:@"width" withClass:className]) {
        width = [NUISettings getFloat:@"width" withClass:className];
    }
    

    
    NSArray *constraints = view.constraints;
    if (width != 0){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstAttribute = %d", NSLayoutAttributeWidth];
        NSArray<NSLayoutConstraint *> *filteredArray = [constraints filteredArrayUsingPredicate:predicate];
        if(filteredArray.count == 0){
            NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:nil toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:width];
            
            [view addConstraint:constraint];
        } else{
            filteredArray.firstObject.constant = width;
        }
    }
    
    if (height != 0){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstAttribute = %d", NSLayoutAttributeHeight];
        NSArray<NSLayoutConstraint *>  *filteredArray = [constraints filteredArrayUsingPredicate:predicate];
        if(filteredArray.count == 0){
            NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:nil toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:height];
            
            [view addConstraint:constraint];
        } else{
            filteredArray.firstObject.constant = height;
        }
        
    }
    
    
}



@end
