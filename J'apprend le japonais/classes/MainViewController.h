//
//  ViewController.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : PSUICollectionViewController <PSTCollectionViewDelegate, PSTCollectionViewDataSource>

@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;
@property (strong, nonatomic) NSMutableArray * lessons;

@end
