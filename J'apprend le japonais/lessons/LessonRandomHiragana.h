//
//  LessonRandomHiragana.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HiraganaFlipView.h"

@interface LessonRandomHiragana : UIViewController
{
    NSMutableArray * knows;
}

@property (strong, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UILabel *msg;

@property (strong, nonatomic) IBOutlet HiraganaFlipView * hiraganaView;

@end
