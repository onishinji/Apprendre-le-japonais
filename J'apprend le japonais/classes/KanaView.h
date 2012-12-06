//
//  HiraganaView.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 21/11/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kana.h"

@interface KanaView : UIView
{
    Kana * _hiragana;
}


@property (strong, nonatomic) IBOutlet UILabel * lblHiragana;
@property (strong, nonatomic) IBOutlet UIImageView * imgCentral;
@property (strong, nonatomic) NSNumber * fontSize;

@property (strong, nonatomic) Kana * currentHiragana;

- (void) displayRomanji;
- (void) displayJapan;
- (void) displayEmpty;
- (void) initialize;

@end
