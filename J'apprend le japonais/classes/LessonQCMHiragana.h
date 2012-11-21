//
//  LessonQCMHiraganaViewController.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 05/11/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Hiragana.h"
#import "HiraganaFlipView.h"

@interface LessonQCMHiragana : UIViewController
{
    Hiragana * currentHiragan;
    
    int currentScore;
    
    NSMutableArray * knows;
    NSMutableArray * knowsRomanji;
    
    NSMutableArray * btnArray;
}

@property (weak, nonatomic) IBOutlet UILabel *msg;

@property (weak, nonatomic) IBOutlet HiraganaFlipView *hiraganaFlipView;

@property (weak, nonatomic) IBOutlet UIButton *leftTopButton;
@property (weak, nonatomic) IBOutlet UIButton *leftMiddleButton;
@property (weak, nonatomic) IBOutlet UIButton *leftBottomButton;
@property (weak, nonatomic) IBOutlet UIButton *rightTopButton;
@property (weak, nonatomic) IBOutlet UIButton *rightMiddleButton;
@property (weak, nonatomic) IBOutlet UIButton *rightBottomButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;


@property (weak, nonatomic) IBOutlet UILabel *goodHiraganaPlain;
@property (weak, nonatomic) IBOutlet UILabel *goodRomanjiPlain;

@property (weak, nonatomic) IBOutlet UILabel *goodHiragana;
@property (weak, nonatomic) IBOutlet UILabel *goodRomanji;

@property (weak, nonatomic) IBOutlet UILabel *falseHiragana;
@property (weak, nonatomic) IBOutlet UILabel *falseRomanji;


- (void) displayTrueResponse:(Hiragana *)hiragana;
- (void) displayFalseResponse:(Hiragana *)trueHiragana falseReponse:(Hiragana *)falseReponse;

@end
