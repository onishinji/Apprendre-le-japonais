//
//  VocabularyDetailViewController.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 16/12/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VocabularyItem.h"
#import "ExerciseController.h"
#import "ContentViewController.h"

@interface VocabularyDetailViewController : ExerciseController
{
    int nbSizeUpDown;
    ContentViewController *dataViewController;
}

@property (nonatomic, weak) VocabularyItem * currentItem;
@end
