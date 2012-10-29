//
//  Lesson.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "Lesson.h"

@implementation Lesson

@synthesize title = _title;
@synthesize icon = _icon;
@synthesize className = _className;

-(id)initWithTitle:(NSString *)title icon:(UIImage *)icon className:(NSString *)className
{
    self = [super init];
    if (self) {
        _title = title;
        _icon  = icon;
        _className = className;
    }
    
    return self;
}

@end