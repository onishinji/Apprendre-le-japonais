//
//  UIView+Tags.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 15/12/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "UIView+Tags.h"

@implementation UIView (Tags)


- (NSArray *) subViewsWithTag:(NSInteger) tag
{
    NSMutableArray * views = [[NSMutableArray alloc] init];
    
    for (UIView * v in self.subviews)
    {
        if(v.tag == tag)
        {
            [views addObject:v];
        }
    }
    
    return [NSArray arrayWithArray:views];
}
@end
