//
//  ViewController.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "MainViewController.h"
#import "LessonCell.h"
#import "Lesson.h"
#import "LessonContainerController.h"
#import "SectionLessonCell.h"
#import "constant.h"
#import "UIColor+RGB.h"
#import "GData.h"

@interface MainViewController ()

@end

@implementation MainViewController


@synthesize lessons = _lessons;
@synthesize managedObjectContext = _managedObjectContext;

#pragma mark - Init Core
- (void)viewDidLoad
{ 
    [super viewDidLoad];
    
    [self.collectionView registerClass:SectionLessonCell.class forCellWithReuseIdentifier:@"Section"];
   self.collectionView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"home_bkg.png"]];
	// Do any additional setup after loading the view, tyxpically from a nib.
    
    //[self.collectionView setBackgroundColor:[UIColor colorWithR:231 G:183 B:137 A:1]];
}



- (NSMutableArray *) lessonsForSection:(NSInteger) section
{
    
    NSMutableDictionary * paramsHiragana = [[NSMutableDictionary alloc] init];
    [paramsHiragana setObject:[NSNumber numberWithInt:TYPE_HIRAGANA] forKey:@"kanaType"];
    [paramsHiragana setObject:[NSNumber numberWithInt:MODE_ROMANJI_JAPAN] forKey:@"mode"];
        
    NSMutableDictionary * paramsHiraganaInvertMode = [NSMutableDictionary dictionaryWithDictionary:paramsHiragana];
    [paramsHiraganaInvertMode setObject:[NSNumber numberWithInt:MODE_JAPAN_ROMANJI] forKey:@"mode"];
    
    NSMutableDictionary * paramsKatakana = [[NSMutableDictionary alloc] init];
    [paramsKatakana setObject:[NSNumber numberWithInt:TYPE_KATAKANA] forKey:@"kanaType"];
    [paramsKatakana setObject:[NSNumber numberWithInt:MODE_ROMANJI_JAPAN] forKey:@"mode"];
    
    NSMutableDictionary * paramsKatakanaInvertMode = [NSMutableDictionary dictionaryWithDictionary:paramsKatakana];
    [paramsKatakana setObject:[NSNumber numberWithInt:MODE_JAPAN_ROMANJI] forKey:@"mode"];
    
     NSMutableArray * lessons = [[NSMutableArray alloc] init];
    switch (section) {
        case 0:
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"Shuffle K > R" icon:[UIImage imageNamed:@"shuffle_icon.png"] className:@"LessonRandomKanaController" parameters:paramsHiragana]];
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"Shuffle R > K" icon:[UIImage imageNamed:@"shuffle_romanji_icon.png"] className:@"LessonRandomKanaController" parameters:paramsHiraganaInvertMode]];
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"QCM K > R" icon:[UIImage imageNamed:@"qcm_hiragana_icon.png"] className:@"LessonQCMKanaController" parameters:paramsHiragana]];
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"QCM R > K" icon:[UIImage imageNamed:@"qcm_romanji_icon.png"] className:@"LessonQCMKanaController" parameters:paramsHiraganaInvertMode]];
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"Paramètres" icon:[UIImage imageNamed:@"params_icon.png"] className:@"ParametersKanaViewController" parameters:paramsHiragana]];

            
            break;
            
        case 1:
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"Shuffle K > R" icon:[UIImage imageNamed:@"shuffle_kata_icon.png"] className:@"LessonRandomKanaController" parameters:paramsKatakana]];
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"Shuffle R > K" icon:[UIImage imageNamed:@"shuffle_romanji_icon.png"] className:@"LessonRandomKanaController" parameters:paramsKatakanaInvertMode]];
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"QCM K > R" icon:[UIImage imageNamed:@"qcm_katakana_icon.png"] className:@"LessonQCMKanaController" parameters:paramsKatakana]];
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"QCM R > K" icon:[UIImage imageNamed:@"qcm_romanji_icon.png"] className:@"LessonQCMKanaController" parameters:paramsKatakanaInvertMode]];
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"Parametres" icon:[UIImage imageNamed:@"params_icon.png"] className:@"ParametersKanaViewController" parameters:paramsKatakana]];
            break;
        case 2:
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"Vocabulaire" icon:[UIImage imageNamed:@"XXX.png"] className:@"VocabularyViewController" parameters:paramsKatakana]];
            
            break;
        default:
            break;
    }
    
    return lessons;
}

#pragma mark - Collection delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (PSTCollectionReusableView *)collectionView:(PSTCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    SectionLessonCell * sectionCell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Section" forIndexPath:indexPath];
    if(indexPath.section == 0)
    {
         sectionCell.title.text = @"ひらがな Hiragana";
    }
    else if(indexPath.section == 1)
    {
        sectionCell.title.text = @"カタカナ Katakana";
    }
    else if(indexPath.section == 2)
    {
        sectionCell.title.text = @"Pour les vrais";
    }
    
    return sectionCell;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return [[self lessonsForSection:section] count];
}

- (PSUICollectionViewCell *)collectionView:(PSUICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    LessonCell *myCell = [cv dequeueReusableCellWithReuseIdentifier:@"Lesson" forIndexPath:indexPath];
    
    Lesson * lesson = [[self lessonsForSection:indexPath.section] objectAtIndex:indexPath.row];
    myCell.title.text = lesson.title;
    myCell.icon.image = lesson.icon;
    
    myCell.layer.borderWidth = 1;
    myCell.layer.borderColor = [UIColor colorWithR:0 G:0 B:0 A:1].CGColor;
    myCell.layer.cornerRadius = 5;
    
    [myCell setHighlighted:FALSE];
    //[myCell configBackground];
    
    return myCell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [[collectionView cellForItemAtIndexPath:indexPath] setHighlighted:TRUE];
    
    Lesson * lesson = [[self lessonsForSection:indexPath.section] objectAtIndex:indexPath.row];
    
    LessonContainerController *lessonController = [[LessonContainerController alloc] init];
    lessonController.managedObjectContext = _managedObjectContext;
    lessonController.lesson =  lesson;
    lessonController.parameters = lesson.parameters;
    
    [self.navigationController pushViewController:lessonController animated:YES];
    
    [[self.collectionView cellForItemAtIndexPath:indexPath] setHighlighted:FALSE];
}

#pragma mark - Go to the lesson

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"RunLesson"]){
        LessonCell *cell = (LessonCell *)sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        
        Lesson * lesson = [[self lessonsForSection:indexPath.section] objectAtIndex:indexPath.row];
        
        LessonContainerController *lessonController = (LessonContainerController *)[segue destinationViewController];
        lessonController.managedObjectContext = _managedObjectContext;
        lessonController.lesson =  lesson;
        
 
    }
    // Assume self.view is the table view
    //NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    //DetailObject *detail = [self detailForIndexPath:path];
  //  [segue.destinationViewController setDetail:detail];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
