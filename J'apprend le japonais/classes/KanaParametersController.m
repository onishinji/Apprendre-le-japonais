//
//  ParametersHiraganaViewController.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 28/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "KanaParametersController.h"
#import "Computer.h"
#import "ParametersCell.h"

@interface KanaParametersController ()

@end

@implementation KanaParametersController

- (void)loadView {
    [super loadView];
    
    _collectionViewLayout = [[PSTCollectionViewFlowLayout alloc] init];
    _collectionViewLayout.itemSize = CGSizeMake(90, 90.0f);
    _collectionViewLayout.sectionInset =  UIEdgeInsetsMake(0, 5, 0, 5);
    _collectionViewLayout.minimumInteritemSpacing = 3;
    _collectionViewLayout.minimumLineSpacing = 3;
    _collectionViewLayout.headerReferenceSize = CGSizeMake(260, 60);
    
    _collectionView = [[PSTCollectionView alloc] initWithFrame:CGRectMake(0, 35, self.view.frame.size.width, self.view.frame.size.height - 35) collectionViewLayout:_collectionViewLayout];
    
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.alwaysBounceVertical = YES;
    
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:PSTCollectionViewCell.class forCellWithReuseIdentifier:@"PSTCollectionViewCell"];
    [_collectionView registerClass:ParametersCell.class forCellWithReuseIdentifier:@"ParametersCell"];
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
}

- (void) activeController
{
    // Custom initialization
    
    NSFetchedResultsController * resultsController;
    if([self isForHiragana])
    {
        resultsController = [[Computer sharedInstance] getHiraganaPerSections];
    }
    else
    {
        resultsController = [[Computer sharedInstance] getKatakanaPerSections];
    }
    
    allResult = [[NSMutableDictionary  alloc] init];
    allKanas = [[NSMutableArray alloc] init];
    int sectionId = 0;
    for(int i = 0; i < [[resultsController sections] count]; i++)
    {
        
        NSMutableArray * kanas = [[NSMutableArray alloc] init];
        
        id <NSFetchedResultsSectionInfo> info = [[resultsController sections] objectAtIndex:i];
        for(int j = 0; j < [info numberOfObjects]; j++)
        {
            [kanas addObject:[[info objects] objectAtIndex:j]];
        }
        
        NSMutableDictionary * nbRow = [[NSMutableDictionary alloc] init];
        for(Kana * kana in kanas)
        {
            [nbRow setObject:@"1" forKey:[kana.row stringValue]];
        }
        
        
        NSMutableArray * sectionKana = [[NSMutableArray alloc] init];
        for (int row = 1; row <= [nbRow count]; row ++)
        {
            for(int col = 1; col <= 5; col++)
            {
                Kana * kana = nil;
                
                for(Kana * hir in kanas)
                {
                    [allKanas addObject:hir];
                    
                    if([hir.col intValue] == col && [hir.row intValue] == row)
                    {
                        kana = hir;
                    }
                }
                if(kana == nil) {
                    [sectionKana addObject:@""];
                }
                else
                {
                    [sectionKana addObject:kana];
                }
            }
        }
        
        [allResult setObject:sectionKana forKey:[NSString stringWithFormat:@"section_%d", sectionId] ];
        sectionId++;
        
    }
}

- (void) toogleItems:(UIBarButtonItem *)bar
{
    for(Kana * hir in allKanas)
    {
        [[Computer sharedInstance] toggleSelectedKana:hir withFlush:FALSE];
    }
    
    [[Computer sharedInstance] flush];
    [_collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    int nb = [allResult count];
    return nb;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    int nb = [[allResult objectForKey:[NSString stringWithFormat:@"section_%d", section ]] count];
   return nb;
}

- (PSTCollectionReusableView *)collectionView: (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
   
    
    PSTCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PSTCollectionViewCell" forIndexPath:indexPath];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 240, 35)];
    label.textAlignment = NSTextAlignmentCenter;
    
    switch (indexPath.section) {
        case 0:
            label.text = @"gojûon";
            break;
        case 1:
            label.text = @"gojûon avec (han)dakuten";
            break;
        case 2:
            label.text = @"yôon";
            break;
        case 3:
            label.text = @"yôon avec (han)dakuten";
            break;
        default:
            break;
    }
    
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    UIImageView * img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title_scroll.png"]];
    img.frame = CGRectMake(20, 10, 240, 40);
    [cell addSubview:img];
    
    cell.backgroundColor = [UIColor clearColor];
    [cell addSubview:label];
    
    return cell;
}

- (PSTCollectionViewCell *)collectionView:(PSTCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
  
    ParametersCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ParametersCell" forIndexPath:indexPath];
    
    id objetInArray = [[allResult objectForKey:[NSString stringWithFormat:@"section_%d",indexPath.section ]] objectAtIndex:indexPath.row];
    
    if([objetInArray isKindOfClass:[Kana class]])
    {
        
        Kana * hir = objetInArray;
        
        cell.title.text = hir.japan;
        cell.subTitle.text = hir.romanji;
        
        if([hir.isSelected boolValue])
        {
            [cell enabled];
        }
        
        if(![hir.isSelected boolValue])
        {
            [cell disabled];            
        }
    }
    else
    {
        [cell empty];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id objetInArray = [[allResult objectForKey:[NSString stringWithFormat:@"section_%d",indexPath.section ]] objectAtIndex:indexPath.row];
    
    if([objetInArray isKindOfClass:[Kana class]])
    {
        Kana * hir = objetInArray;
        [[Computer sharedInstance] toggleSelectedKana:hir withFlush:TRUE];
        
        
        [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        NSLog(@"%@ a été cliqué", [hir romanji]);
        
    }
}

- (IBAction)openHelp:(UIBarButtonItem *)bar
{
    helpVC = [[HelpViewController alloc] initWithNibName:@"helpParameters" bundle:nil];
    
    if(openHelpAlready)
    {
        openHelpAlready = false;
        [self dismissOverViewControllerAnimated:YES];
    }
    else
    {
        openHelpAlready = true;
        [self presentOverViewController:helpVC animated:YES];
    }
}


@end
