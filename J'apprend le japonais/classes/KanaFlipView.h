//
//  HiraganaFlipView.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 29/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hiragana.h"
#import "KanaView.h"

@interface KanaFlipView : KanaView
{
    BOOL isJapanFace;
}


- (void) displayNewHiragana:(Hiragana *)hiragana;
- (void) switchToggleFace;
@end
