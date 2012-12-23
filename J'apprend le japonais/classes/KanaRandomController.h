//
//  LessonRandomHiragana.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KanaFlipView.h"
#import "ExerciseController.h"

#import "HelpViewController.h"


@interface KanaRandomController : ExerciseController
{
    NSMutableArray * knows;
    NSMutableArray * knowsRomanji;
    int currentPos;
     
}

@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIButton *btnPrev;
@property (weak, nonatomic) IBOutlet UILabel *msg;


@property (strong, nonatomic) IBOutlet KanaFlipView * kanaFlipView;

@end
