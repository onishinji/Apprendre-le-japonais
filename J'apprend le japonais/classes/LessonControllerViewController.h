//
//  LessonControllerViewController.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 21/11/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "constant.h"

@interface LessonControllerViewController : UIViewController
{
    NSNumber * currentKanaType;
}

@property (nonatomic) NSNumber * currentKanaType;

- (BOOL) isForHiragana;
- (BOOL) isForKatakana;

@end
