//
//  ViewController.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "MainController.h"
#import "LessonCell.h"
#import "Lesson.h"
#import "LessonController.h"

@interface MainController ()

@end

@implementation MainController


@synthesize lessons = _lessons;
@synthesize managedObjectContext = _managedObjectContext;

- (void)viewDidLoad
{
    NSLog(@"coucou");
    [super viewDidLoad];
    
    _lessons = [[NSMutableArray alloc] init];
    
    [_lessons addObject:[[Lesson alloc] initWithTitle:@"QCM Hiragana" icon:[UIImage imageNamed:@"QCM"] className:@"LessonRandomHiragana"]];
    
    
    [_lessons addObject:[[Lesson alloc] initWithTitle:@"Parametres" icon:[UIImage imageNamed:@"parameters"] className:@"ParametersHiraganaViewController"]];
    
	// Do any additional setup after loading the view, typically from a nib.
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return [_lessons count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LessonCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"Lesson"
                                    forIndexPath:indexPath];
    
    Lesson * lesson = [_lessons objectAtIndex:indexPath.row];
    myCell.title.text = lesson.title;
    
    return myCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d a été cliqué", [indexPath row]);
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
    
}- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
