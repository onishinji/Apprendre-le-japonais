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

@interface MainViewController ()

@end

@implementation MainViewController


@synthesize lessons = _lessons;
@synthesize managedObjectContext = _managedObjectContext;

- (void)viewDidLoad
{ 
    [super viewDidLoad];
    
    [self.collectionView registerClass:SectionLessonCell.class forCellWithReuseIdentifier:@"Section"];
    
	// Do any additional setup after loading the view, tyxpically from a nib.
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
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"Shuffle K > R" icon:[UIImage imageNamed:@"shuffle.png"] className:@"LessonRandomKana" parameters:paramsHiragana]];
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"Shuffle R > K" icon:[UIImage imageNamed:@"shuffle.png"] className:@"LessonRandomKana" parameters:paramsHiraganaInvertMode]];
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"QCM K > R" icon:[UIImage imageNamed:@"qcm.png"] className:@"LessonQCMKana" parameters:paramsHiragana]];
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"QCM R > K" icon:[UIImage imageNamed:@"qcm.png"] className:@"LessonQCMKana" parameters:paramsHiraganaInvertMode]];
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"Parametres" icon:[UIImage imageNamed:@"parameters.png"] className:@"ParametersKanaViewController" parameters:paramsHiragana]];

            
            break;
            
        case 1:
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"Shuffle K > R" icon:[UIImage imageNamed:@"shuffle.png"] className:@"LessonRandomKana" parameters:paramsKatakana]];
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"Shuffle R > K" icon:[UIImage imageNamed:@"shuffle.png"] className:@"LessonRandomKana" parameters:paramsKatakanaInvertMode]];
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"QCM K > R" icon:[UIImage imageNamed:@"qcm.png"] className:@"LessonQCMKana" parameters:paramsKatakana]];
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"QCM R > K" icon:[UIImage imageNamed:@"qcm.png"] className:@"LessonQCMKana" parameters:paramsKatakanaInvertMode]];
            
            [lessons addObject:[[Lesson alloc] initWithTitle:@"Parametres" icon:[UIImage imageNamed:@"parameters.png"] className:@"ParametersKanaViewController" parameters:paramsKatakana]];
            
        default:
            break;
    }
    
    return lessons;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (PSTCollectionReusableView *)collectionView:(PSTCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
        SectionLessonCell * test = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Section" forIndexPath:indexPath];
    if(indexPath.section == 0)
    {
         test.title.text = @"ひらがな Hiragana";
    }
    else if(indexPath.section == 1)
    {
        test.title.text = @"カタカナ Katakana";
    }
    
    test.backgroundColor = [UIColor whiteColor];
    
    return test;
    
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
    
    return myCell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{    
    Lesson * lesson = [[self lessonsForSection:indexPath.section] objectAtIndex:indexPath.row];
    
    LessonContainerController *lessonController = [[LessonContainerController alloc] init];
    lessonController.managedObjectContext = _managedObjectContext;
    lessonController.lesson =  lesson;
    lessonController.parameters = lesson.parameters;
    
    [self.navigationController pushViewController:lessonController animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"segue me");
    
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
