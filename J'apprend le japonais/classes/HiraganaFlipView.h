//
//  HiraganaFlipView.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 29/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hiragana.h"

@interface HiraganaFlipView : UIView
{
    Hiragana * _hiragana;
    BOOL isJapanFace;
}
 
@property (strong, nonatomic) IBOutlet UILabel * lblHiragana;
@property (strong, nonatomic) IBOutlet UIImageView * imgCentral;


- (void) displayNewHiragana:(Hiragana *)hiragana;
- (void) displayEmpty;

@end
