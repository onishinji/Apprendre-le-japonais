//
//  LessonRandomHiragana.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KanaFlipView.h"
#import "LessonControllerViewController.h"

#import <Slt/Slt.h>
#import <OpenEars/FliteController.h>
#import <OpenEars/LanguageModelGenerator.h>
#import <OpenEars/PocketsphinxController.h>
#import <OpenEars/OpenEarsEventsObserver.h>
#import "HelpViewController.h"


@interface LessonRandomKanaController : LessonControllerViewController <OpenEarsEventsObserverDelegate>
{
    NSMutableArray * knows;
    NSMutableArray * knowsRomanji;
    int currentPos;
    
    LanguageModelGenerator *lmGenerator;
    FliteController *fliteController;
    PocketsphinxController *pocketsphinxController;
    Slt *slt;
    OpenEarsEventsObserver *openEarsEventsObserver;
}

@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIButton *btnPrev;
@property (weak, nonatomic) IBOutlet UILabel *msg;

@property (strong, nonatomic) FliteController *fliteController;
@property (strong, nonatomic) Slt *slt;
@property (strong, nonatomic) PocketsphinxController *pocketsphinxController;
@property (strong, nonatomic) OpenEarsEventsObserver *openEarsEventsObserver;

@property (strong, nonatomic) IBOutlet KanaFlipView * kanaFlipView;

@end
