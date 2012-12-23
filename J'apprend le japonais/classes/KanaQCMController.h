//
//  J'apprend le japonais
//
//  Created by Guillaume chave on 05/11/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Kana.h"
#import "KanaFlipView.h"
#import "ExerciseController.h"
#import "HelpViewController.h"
#import "UIViewController+overView.h"
#import "UIView+Tags.h"
#import "NSTimer+Blocks.h"

@interface KanaQCMController : ExerciseController
{
    Kana * currentKana;
    
    BOOL hasWrongAnswer;
    
    int currentScore;
    
    UIColor * defaultLblColor;
    
    UITapGestureRecognizer * tapToNext;
    
    NSMutableArray * knows;
    NSMutableArray * knowsRomanji;
    
    NSMutableArray * btnArray;
}

@property (weak, nonatomic) IBOutlet UILabel *msg;

@property (weak, nonatomic) IBOutlet KanaView *kanaView;

@property (weak, nonatomic) IBOutlet UIButton *leftTopButton;
@property (weak, nonatomic) IBOutlet UIButton *leftMiddleButton;
@property (weak, nonatomic) IBOutlet UIButton *leftBottomButton;
@property (weak, nonatomic) IBOutlet UIButton *rightTopButton;
@property (weak, nonatomic) IBOutlet UIButton *rightMiddleButton;
@property (weak, nonatomic) IBOutlet UIButton *rightBottomButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel * lblResponse;


- (void) displayTrueResponse:(Kana *)kana;
- (void) displayFalseResponse:(Kana *)trueResponse falseReponse:(Kana *)falseResponse;

@end
