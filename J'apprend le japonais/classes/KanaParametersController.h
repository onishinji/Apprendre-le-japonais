//
//  ParametersHiraganaViewController.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 28/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LessonControllerViewController.h"

@interface KanaParametersController : LessonControllerViewController <PSTCollectionViewDataSource, PSTCollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate>
{
    
    NSMutableDictionary * allResult;
    NSMutableArray * allKanas;

    PSTCollectionViewFlowLayout * _collectionViewLayout;
    PSTCollectionView * _collectionView;
} 

@end
