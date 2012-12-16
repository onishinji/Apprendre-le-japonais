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
    BOOL openHelpAlready;
    
    
    HelpViewController * helpVC;
}

@property (nonatomic) NSNumber * currentKanaType;
@property (strong, nonatomic) NSMutableDictionary * params;
@property (strong, nonatomic) UIViewController * parent;

- (BOOL) isForHiragana;
- (BOOL) isForKatakana;


- (BOOL) isForRomanjiToJapan;
- (BOOL) isForJapanToRomanji;

- (void) activeController;
- (void) openHelp:(UIBarButtonItem *)bar;

@end
