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

@interface VocabularyDetailViewController : ExerciseController
@property (weak, nonatomic) IBOutlet UILabel *traduction;
@property (weak, nonatomic) IBOutlet UILabel *sampleUsageRomanji;
@property (weak, nonatomic) IBOutlet UILabel *sampleUsageJapan;
@property (weak, nonatomic) IBOutlet UILabel *sampleUsageTraduction;
@property (weak, nonatomic) IBOutlet UILabel *kanji;

@property (weak, nonatomic) IBOutlet UILabel *kana;
@property (weak, nonatomic) IBOutlet UILabel *romanji;
@property (nonatomic, weak) VocabularyItem * currentItem;
@end
