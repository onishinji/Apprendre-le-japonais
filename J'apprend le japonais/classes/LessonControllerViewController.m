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

@synthesize params = _params;
@synthesize currentKanaType;
@synthesize parent = _parent;

- (BOOL) isForHiragana
{
    return [currentKanaType intValue] == TYPE_HIRAGANA;
}

- (BOOL) isForKatakana
{
    return [currentKanaType intValue] == TYPE_KATAKANA;
}


- (BOOL) isForRomanjiToJapan
{
    return [[self.params objectForKey:@"mode"] isEqualToNumber:[NSNumber numberWithInt:MODE_ROMANJI_JAPAN]];
}

- (BOOL) isForJapanToRomanji
{
    return [[self.params objectForKey:@"mode"] isEqualToNumber:[NSNumber numberWithInt:MODE_JAPAN_ROMANJI]];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    openHelpAlready = false;
}

// to be override
- (void) openHelp:(UIBarButtonItem *)bar
{
    
}

// to be override, init controller
- (void) activeController
{
    
}

@end
