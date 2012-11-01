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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        hiraganas = [[Computer sharedInstance] getAllHiragana];
        
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    _collectionViewLayout = [[PSTCollectionViewFlowLayout alloc] init];
    _collectionViewLayout.itemSize = CGSizeMake(50, 50.0f);
    
    _collectionView = [[PSTCollectionView alloc] initWithFrame:CGRectMake(0, 70, 320, 340) collectionViewLayout:_collectionViewLayout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.alwaysBounceVertical = YES;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:PSTCollectionViewCell.class forCellWithReuseIdentifier:@"PSTCollectionViewCell"];
    
    [_collectionView registerClass:JapanCell.class forCellWithReuseIdentifier:@"Japan"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Parameters  :/ viewDidLoad");
    
    // Do any additional setup after loading the view from its nib.
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [hiraganas count];
}

- (PSTCollectionViewCell *)collectionView:(PSTCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    JapanCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Japan" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor greenColor];
    
    
    Hiragana * hir = [hiraganas objectAtIndex:indexPath.row]; 
    
    cell.title.text = hir.japan;
    cell.backgroundColor = [UIColor grayColor];
    
    if([hir.isSelected boolValue])
    {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Hiragana * hir = (Hiragana *) [hiraganas objectAtIndex:[indexPath row]];
    [[Computer sharedInstance] toggleSelectedHiragana:hir];
    
    [_collectionView reloadData];
    NSLog(@"%@ a été cliqué", [hir romanji]);
}


@end
