//
//  LessonControllerViewController.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 21/11/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "constant.h"
#import "HelpViewController.h"

@interface LessonControllerViewController : UIViewController
{
    NSNumber * currentKanaType;
    NSNumber * currentMode;
    BOOL openHelpAlready;
    
    
    HelpViewController * helpVC;
}

@property (nonatomic) NSNumber * currentKanaType;
@property (nonatomic) NSNumber * currentMode;

- (BOOL) isForHiragana;
- (BOOL) isForKatakana;


- (BOOL) isForRomanjiToJapan;
- (BOOL) isForJapanToRomanji;

- (void) activeController;
- (void) openHelp:(UIBarButtonItem *)bar;

@end
