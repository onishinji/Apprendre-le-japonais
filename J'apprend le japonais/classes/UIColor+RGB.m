//
//  UIColor+RGB.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 09/12/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "UIColor+RGB.h"

@implementation UIColor (RGB)

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha {
    return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}

@end
 