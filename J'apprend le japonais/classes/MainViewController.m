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
#import "LessonController.h"
#import "SectionLessonCell.h"

@interface MainViewController ()

@end

@implementation MainViewController


@synthesize lessons = _lessons;
@synthesize managedObjectContext = _managedObjectContext;

- (void)viewDidLoad
{
    NSLog(@"coucou");
    [super viewDidLoad];
    
    _lessons = [[NSMutableArray alloc] init];
    
    [_lessons addObject:[[Lesson alloc] initWithTitle:@"Shuffle Hiragana" icon:[UIImage imageNamed:@"memory.png"] className:@"LessonRandomHiragana"]];
    
    
    [_lessons addObject:[[Lesson alloc] initWithTitle:@"QCM" icon:[UIImage imageNamed:@"qcm"] className:@"LessonQCMHiragana"]];
    
    [_lessons addObject:[[Lesson alloc] initWithTitle:@"Parametres" icon:[UIImage imageNamed:@"parameters.png"] className:@"ParametersHiraganaViewController"]];
    
    
    [self.collectionView registerClass:SectionLessonCell.class forCellWithReuseIdentifier:@"Section"];
    
	// Do any additional setup after loading the view, tyxpically from a nib.
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
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
    
    NSLog(@" coucou %@, %@", test, NSStringFromCGRect(test.frame));
    
    return test;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return [_lessons count];
}

- (PSUICollectionViewCell *)collectionView:(PSUICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    LessonCell *myCell = [cv dequeueReusableCellWithReuseIdentifier:@"Lesson" forIndexPath:indexPath];
    
    Lesson * lesson = [_lessons objectAtIndex:indexPath.row];
    myCell.title.text = lesson.title;
    myCell.icon.image = lesson.icon;
    
    return myCell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d a été cliqué", [indexPath row]);
    
    Lesson * lesson = [_lessons objectAtIndex:indexPath.row];
    
    LessonController *lessonController = [[LessonController alloc] init];
    lessonController.managedObjectContext = _managedObjectContext;
    lessonController.lesson =  lesson;
    
    [self.navigationController pushViewController:lessonController animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"segue me");
    
    if([segue.identifier isEqualToString:@"RunLesson"]){
        LessonCell *cell = (LessonCell *)sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        
        Lesson * lesson = [_lessons objectAtIndex:indexPath.row];
        
        LessonController *lessonController = (LessonController *)[segue destinationViewController];
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
