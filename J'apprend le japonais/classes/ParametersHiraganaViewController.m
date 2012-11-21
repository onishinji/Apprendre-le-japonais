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
        
        NSFetchedResultsController * resultsController = [[Computer sharedInstance] getHiraganaPerSections];
        
        allResult = [[NSMutableDictionary  alloc] init]; 
        int sectionId = 0;
        for(int i = 0; i < [[resultsController sections] count]; i++)
        {
            
            NSMutableArray * hiraganas = [[NSMutableArray alloc] init];
            
            id <NSFetchedResultsSectionInfo> info = [[resultsController sections] objectAtIndex:i];
            for(int j = 0; j < [info numberOfObjects]; j++)
            {
                [hiraganas addObject:[[info objects] objectAtIndex:j]];
            }
            
            NSMutableDictionary * nbRow = [[NSMutableDictionary alloc] init];
            for(Hiragana * h in hiraganas)
            {
                [nbRow setObject:@"1" forKey:[h.row stringValue]];
            }
            
            
            NSMutableArray * sectionHiragana = [[NSMutableArray alloc] init];
            for (int row = 1; row <= [nbRow count]; row ++)
            {
                for(int col = 1; col <= 5; col++)
                {
                    Hiragana * thehiragana = nil;
                    
                    for(Hiragana * hir in hiraganas)
                    {
                        
                        if([hir.col intValue] == col && [hir.row intValue] == row)
                        {
                            thehiragana = hir;
                        }
                    }
                    if(thehiragana == nil) {
                        [sectionHiragana addObject:@""];
                    }
                    else
                    {
                        [sectionHiragana addObject:thehiragana];
                    }
                }
            }
            
            NSLog(@"section%d  nb = %d", sectionId, [sectionHiragana count]);
            
            [allResult setObject:sectionHiragana forKey:[NSString stringWithFormat:@"section_%d", sectionId] ];
            sectionId++;
            
        }
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
    
    _collectionViewLayout = [[PSTCollectionViewFlowLayout alloc] init];
    _collectionViewLayout.itemSize = CGSizeMake(90, 90.0f);
    _collectionViewLayout.sectionInset =  UIEdgeInsetsMake(0, 5, 0, 5);
    _collectionViewLayout.minimumInteritemSpacing = 3;
    _collectionViewLayout.minimumLineSpacing = 3;
    _collectionViewLayout.headerReferenceSize = CGSizeMake(480, 30);
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        _collectionView = [[PSTCollectionView alloc] initWithFrame:CGRectMake(0, 35, 900, 670) collectionViewLayout:_collectionViewLayout];
    }
    else
    {
        _collectionView = [[PSTCollectionView alloc] initWithFrame:CGRectMake(0, 35, 480, 230) collectionViewLayout:_collectionViewLayout];
        
    }
    
    
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.alwaysBounceVertical = YES;
    
        
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:PSTCollectionViewCell.class forCellWithReuseIdentifier:@"PSTCollectionViewCell"]; 
    
    [_collectionView registerClass:JapanCell.class forCellWithReuseIdentifier:@"Section"];
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
    int nb = [allResult count];
    return nb;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    int nb = [[allResult objectForKey:[NSString stringWithFormat:@"section_%d", section ]] count];
   return nb;
}

- (PSTCollectionReusableView *)collectionView: (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
   
    
    PSTCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Section" forIndexPath:indexPath];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 480, 30)]; 
    
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
    
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    
    cell.backgroundColor = [UIColor blackColor];
    [cell addSubview:label];
    
    return cell;
}

- (PSTCollectionViewCell *)collectionView:(PSTCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
  
    JapanCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Japan" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor greenColor];
    
    id objetInArray = [[allResult objectForKey:[NSString stringWithFormat:@"section_%d",indexPath.section ]] objectAtIndex:indexPath.row];
    
    if([objetInArray isKindOfClass:[Hiragana class]])
    {
        Hiragana * hir = objetInArray;
        
        cell.title.text = hir.japan;
        cell.subTitle.text = hir.romanji;
        cell.backgroundColor = [UIColor grayColor];
        
        if([hir.isSelected boolValue])
        {
            cell.backgroundColor = [UIColor whiteColor];
        }
    }
    else
    {
        cell.title.text = @"";
        cell.subTitle.text = @"";
        cell.backgroundColor = [UIColor clearColor];
    }  
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id objetInArray = [[allResult objectForKey:[NSString stringWithFormat:@"section_%d",indexPath.section ]] objectAtIndex:indexPath.row];
    
    if([objetInArray isKindOfClass:[Hiragana class]])
    {
        Hiragana * hir = objetInArray;
        [[Computer sharedInstance] toggleSelectedHiragana:hir];
        
        
        [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        NSLog(@"%@ a été cliqué", [hir romanji]);
        
    }
}


@end
