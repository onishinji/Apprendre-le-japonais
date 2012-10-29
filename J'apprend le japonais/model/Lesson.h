//
//  Lesson.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lesson : NSObject

@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) UIImage * icon;
@property (strong, nonatomic) NSString * className;


-(id)initWithTitle:(NSString *)title icon:(UIImage *)icon className:(NSString *)className;

@end