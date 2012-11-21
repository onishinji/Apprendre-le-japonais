//
//  LessonControllerViewController.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 21/11/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "LessonControllerViewController.h"

@interface LessonControllerViewController ()

@end

@implementation LessonControllerViewController

@synthesize currentKanaType;

- (BOOL) isForHiragana
{
    return [currentKanaType intValue] == TYPE_HIRAGANA;
}

- (BOOL) isForKatakana
{
    return [currentKanaType intValue] == TYPE_KATAKANA;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
        
        
        if([self isForKatakana])
        {
            NSLog(@"je load un katakana !");
        }
        
        if([self isForHiragana])
        {
            NSLog(@"je load un hiragana !");
        }
}

@end
