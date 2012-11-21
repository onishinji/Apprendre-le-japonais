//
//  Computer.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 28/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "Computer.h"

@implementation Computer

@synthesize managedObjectContext = _managedObjectContext;

static Computer *sharedObject;

+ (Computer*)sharedInstance
{
    if (sharedObject == nil) {
        sharedObject = [[super allocWithZone:NULL] init];
        NSLog(@"create instance");
    }
    return sharedObject;
}

-(Hiragana *) createHiragana:(NSString *)romanji japan:(NSString *)japan position:(int)position col:(int)col row:(int)row section:(int)section type:(int)type
{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Hiragana" inManagedObjectContext:_managedObjectContext];
    Hiragana * hir = [[Hiragana alloc] initWithEntity:entity insertIntoManagedObjectContext:_managedObjectContext];
    
    hir.position = [NSNumber numberWithInt:position];
    
    hir.romanji = romanji;
    hir.japan = japan;
    hir.isSelected = [NSNumber numberWithBool:TRUE];
    hir.row = [NSNumber numberWithInt:row];
    hir.col = [NSNumber numberWithInt:col];
    hir.section = [NSNumber numberWithInt:section];
    
    
    return hir;
}

-(Hiragana *) getRandomHiragana:(NSArray *)knowRomanjis
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Hiragana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (romanji in %@) AND isSelected = 1", knowRomanjis];
    [request setPredicate:predicate];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"romanji" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSError *error = nil;
    NSArray *array = [_managedObjectContext executeFetchRequest:request error:&error];
    if (array == nil)
    {
        NSLog(@"Error while retriving\n%@",
              ([error localizedDescription] != nil) ? [error localizedDescription]: @"Unknown Error");
    }
    
    if([array count] == 0)
    {
        return nil;
    }
    else
    {
        Hiragana * aResult = [array objectAtIndex: arc4random() % [array count]];
        return aResult;
    }
}


-(NSMutableArray *) getRandomHiraganaExcept:(Hiragana *)hiragana limit:(int)limit
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Hiragana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    [request setFetchLimit:limit];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT romanji = %@ AND isSelected = 1", hiragana.romanji];
    [request setPredicate:predicate];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"romanji" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSError *error = nil;
    NSArray *array = [_managedObjectContext executeFetchRequest:request error:&error];
    if (array == nil)
    {
        NSLog(@"Error while retriving\n%@",
              ([error localizedDescription] != nil) ? [error localizedDescription]: @"Unknown Error");
    }
    
    if([array count] == 0)
    {
        return nil;
    }
    else
    {
        NSMutableArray * mutable = [NSMutableArray arrayWithArray:array];
        [mutable shuffle];
        
        if([mutable count] < limit)
        {
            for(int i = 0; i < [mutable count] - limit; i++)
            {
                [mutable addObject:[mutable objectAtIndex:0]];
            }
        }
        
        return mutable;
    }
}

-(NSArray *) getSelectedsHiragana
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Hiragana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@" isSelected = 1"];
    [request setPredicate:predicate];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"romanji" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSError *error = nil;
    NSArray *array = [_managedObjectContext executeFetchRequest:request error:&error];
    if (array == nil)
    {
        NSLog(@"Error while retriving\n%@",
              ([error localizedDescription] != nil) ? [error localizedDescription]: @"Unknown Error");
    }
    
    if([array count] == 0)
    {
        return nil;
    }
    else
    {
        return array;
    }
}

-(NSArray *) getAllHiragana
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Hiragana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"position" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSError *error = nil;
    NSArray *array = [_managedObjectContext executeFetchRequest:request error:&error];
    if (array == nil)
    {
        NSLog(@"Error while retriving\n%@",
              ([error localizedDescription] != nil) ? [error localizedDescription]: @"Unknown Error");
    }
    
    NSLog(@"nb item %d", [array count]);
    
    return array;
}

-(NSFetchedResultsController *) getHiraganaPerSections
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Hiragana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"position" ascending:YES];
    NSSortDescriptor *sort2 = [[NSSortDescriptor alloc] initWithKey:@"section" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObjects: sort, sort2, nil]];
    
    
    // Create and initialize the fetch results controller
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:_managedObjectContext sectionNameKeyPath:@"section" cacheName:@"Root"];
    
    
    NSError *error = nil;
    
    [aFetchedResultsController performFetch:&error];
    
    if(error != nil)
    {
        
        NSLog(@"Error while retriving\n%@",
              ([error localizedDescription] != nil) ? [error localizedDescription]: @"Unknown Error");
        
    }
    NSLog(@"nb section %d", [[aFetchedResultsController sections] count]);
    
    return aFetchedResultsController;
}

-(Hiragana *) toggleSelectedHiragana:(Hiragana *)hiragana
{
    NSLog(@"%@", hiragana.isSelected);
    
    bool b = [hiragana.isSelected boolValue];
    b = !b;
    
    hiragana.isSelected = [NSNumber numberWithBool:b];
    
    [self flush];
    
    return hiragana;
}

-(Hiragana *) getHiraganaWithRomanji:(NSString *)romanji
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Hiragana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"romanji = %@", romanji];
    [request setPredicate:predicate];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"romanji" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSError *error = nil;
    NSArray *array = [_managedObjectContext executeFetchRequest:request error:&error];
    if (array == nil)
    {
        NSLog(@"Error while retriving\n%@",
              ([error localizedDescription] != nil) ? [error localizedDescription]: @"Unknown Error");
    }
    
    if([array count] == 0)
    {
        return nil;
    }
    else
    {
        Hiragana * aResult = [array objectAtIndex: arc4random() % [array count]];
        return aResult;
    }
}

-(void) flush
{
    NSLog(@"Flush it");
    
    NSError *error = nil;
    if (![_managedObjectContext save: &error]) {
        NSLog(@"Error while saving\n%@",
              ([error localizedDescription] != nil) ? [error localizedDescription]: @"Unknown Error");
    }
    
}

@end
