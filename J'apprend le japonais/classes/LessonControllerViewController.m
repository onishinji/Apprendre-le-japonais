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
    
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"home_bkg.png"]];
}

@end
