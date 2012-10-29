//
//  ParametersHiraganaViewController.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 28/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "ParametersHiraganaViewController.h"
#import "Computer.h"
#import "JapanCell.h"

@interface ParametersHiraganaViewController ()

@end

@implementation ParametersHiraganaViewController

@synthesize collectionsView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    hiraganas = [[Computer sharedInstance] getAllHiragana];
    [collectionsView registerClass:[JapanCell class] forCellWithReuseIdentifier:@"Japan"];
    
    // Do any additional setup after loading the view from its nib.
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return [hiraganas count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JapanCell *myCell = [collectionView
                          dequeueReusableCellWithReuseIdentifier:@"Japan"
                          forIndexPath:indexPath];
    
    Hiragana * hir = [hiraganas objectAtIndex:indexPath.row];
    myCell.title.text = hir.japan;
    
    myCell.backgroundColor = [UIColor grayColor];
    
    if([hir.isSelected boolValue])
    {
        myCell.backgroundColor = [UIColor whiteColor];
    }
    
    return myCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Hiragana * hir = (Hiragana *) [hiraganas objectAtIndex:[indexPath row]];
    [[Computer sharedInstance] toggleSelectedHiragana:hir];
    
    [collectionsView reloadData];
    NSLog(@"%@ a été cliqué", [hir romanji]);
}


@end
