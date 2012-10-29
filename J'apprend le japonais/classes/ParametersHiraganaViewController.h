//
//  ParametersHiraganaViewController.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 28/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParametersHiraganaViewController : UIViewController
{
    NSArray * hiraganas;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionsView;

@end
