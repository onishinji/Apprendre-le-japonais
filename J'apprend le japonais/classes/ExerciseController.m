//
//  LessonControllerViewController.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 21/11/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "ExerciseController.h"

@interface ExerciseController ()

@end

@implementation ExerciseController
 
@synthesize currentKanaType; 

- (BOOL) isForHiragana
{
    return [self.currentKanaType intValue] == TYPE_HIRAGANA;
}

- (BOOL) isForKatakana
{
    return [self.currentKanaType intValue] == TYPE_KATAKANA;
}


- (BOOL) isForRomanjiToJapan
{
    return [self.currentMode intValue] == MODE_ROMANJI_JAPAN;
}

- (BOOL) isForJapanToRomanji
{
    return [self.currentMode intValue] == MODE_JAPAN_ROMANJI;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    openHelpAlready = false;
}

// to be override
- (IBAction) openHelp:(UIBarButtonItem *)bar
{
    
}

// to be override, init controller
- (void) activeController
{
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
