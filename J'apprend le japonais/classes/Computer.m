//
//  Computer.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 28/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "Computer.h"
#import "Kana.h"

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

-(Kana *) createKana:(NSString *)romanji japan:(NSString *)japan position:(int)position col:(int)col row:(int)row section:(int)section type:(int)type
{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Kana" inManagedObjectContext:_managedObjectContext];
    Kana * hir = [[Kana alloc] initWithEntity:entity insertIntoManagedObjectContext:_managedObjectContext];
    
    hir.position = [NSNumber numberWithInt:position];
    
    hir.romanji = romanji;
    hir.japan = japan;
    hir.isSelected = [NSNumber numberWithBool:TRUE];
    hir.row = [NSNumber numberWithInt:row];
    hir.col = [NSNumber numberWithInt:col];
    hir.section = [NSNumber numberWithInt:section];
    hir.type = [NSNumber numberWithInt:type];
    
    
    return hir;
}

-(Kana *) getRandomHiragana:(NSArray *)knowsJapan
{    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Kana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (japan in %@) AND isSelected = 1 and type = 0", knowsJapan];
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
        Kana * aResult = [array objectAtIndex: arc4random() % [array count]];
        return aResult;
    }
}


-(Kana *) getRandomKatakana:(NSArray *)knowsJapan
{    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Kana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (japan in %@) AND isSelected = 1 and type = 1", knowsJapan];
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
    
    
    NSLog(@"nb kana restant à trouver %i", array.count);
    
    if([array count] == 0)
    {
        return nil;
    }
    else
    {
        Kana * aResult = [array objectAtIndex: arc4random() % [array count]];
        return aResult;
    }
}


-(NSMutableArray *) getRandomHiraganaExcept:(Kana *)hiragana limit:(int)limit
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Kana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT japan = %@ AND isSelected = 1 and type = 0", hiragana.japan];
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
        NSLog(@"%@ %i", array, array.count);
        NSMutableArray * mutable = [NSMutableArray arrayWithArray:array];
        [mutable shuffle];
        
        NSMutableArray * result = [[NSMutableArray alloc] init];
        for(int i = 0; i < limit; i++)
        {
            [result addObject:[mutable objectAtIndex:i]];
        }
        
        return result;
    }
}


-(NSMutableArray *) getRandomKatakanaExcept:(Kana *)hiragana limit:(int)limit
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Kana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT japan = %@ AND isSelected = 1 and type = 1", hiragana.japan];
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
        
        NSMutableArray * result = [[NSMutableArray alloc] init];
        for(int i = 0; i < limit; i++)
        {
            [result addObject:[mutable objectAtIndex:i]];
        }
        
        return result;
    }
}

-(NSArray *) getSelectedsHiragana
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Kana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@" isSelected = 1 and type = 0"];
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

-(NSArray *) getSelectedsKatakana
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Kana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@" isSelected = 1 and type = 1"];
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

-(NSFetchedResultsController *) getHiraganaPerSections
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Kana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"position" ascending:YES];
    NSSortDescriptor *sort2 = [[NSSortDescriptor alloc] initWithKey:@"section" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObjects: sort, sort2, nil]];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@" type = 0"];
    [request setPredicate:predicate];
    
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


-(NSFetchedResultsController *) getKatakanaPerSections
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Kana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"position" ascending:YES];
    NSSortDescriptor *sort2 = [[NSSortDescriptor alloc] initWithKey:@"section" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObjects: sort, sort2, nil]];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@" type = 1"];
    [request setPredicate:predicate];
    
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

-(Kana *) toggleSelectedKana:(Kana *)hiragana withFlush:(BOOL)flush
{
    bool b = [hiragana.isSelected boolValue];
    b = !b;
    
    hiragana.isSelected = [NSNumber numberWithBool:b];
    
    if(flush)
    {
        [self flush];
    }
    
    return hiragana;
}


-(Kana *) getKatakanaWithRomanji:(NSString *)romanji
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Kana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"romanji = [c]%@ and type = 1", romanji];
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
        Kana * aResult = [array objectAtIndex: arc4random() % [array count]];
        return aResult;
    }
}


-(Kana *) getKatakanaWithJapan:(NSString *)romanji
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Kana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"japan = [c]%@ and type = 1", romanji];
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
        Kana * aResult = [array objectAtIndex: arc4random() % [array count]];
        return aResult;
    }
}

-(Kana *) getHiraganaWithRomanji:(NSString *)romanji
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Kana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"romanji = [c]%@ and type = 0", romanji];
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
        Kana * aResult = [array objectAtIndex: arc4random() % [array count]];
        return aResult;
    }
}


-(Kana *) getHiraganaWithJapan:(NSString *)romanji
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Kana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"japan = [c]%@ and type = 0", romanji];
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
        Kana * aResult = [array objectAtIndex: arc4random() % [array count]];
        return aResult;
    }
}


-(void) flush
{
    NSError *error = nil;
    if (![_managedObjectContext save: &error]) {
        NSLog(@"Error while saving\n%@",
              ([error localizedDescription] != nil) ? [error localizedDescription]: @"Unknown Error");
    }
}


- (Cache *) getWithKey:(NSString *)key
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Cache" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key = %@", key];
    [request setPredicate:predicate];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"key" ascending:NO];
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
        Cache * aResult = [array objectAtIndex: arc4random() % [array count]];
        return aResult;
    }
}

- (void) setWithKey:(NSString *)key andValue:(NSData *)value
{
    Cache * cache = [self getWithKey:key];
    
    if(cache == nil)
    {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Cache" inManagedObjectContext:_managedObjectContext];
        cache = [[Cache alloc] initWithEntity:entity insertIntoManagedObjectContext:_managedObjectContext];
        cache.key = key;
    }
    
    cache.value = value;
    
    [self flush];
}

- (void) upgradeDatabaseForStat
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Kana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"scoring > %@", [NSNumber numberWithInt:SCORE_MAX]];
    [request setPredicate:predicate];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"romanji" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSError *error = nil;
    NSArray *array = [_managedObjectContext executeFetchRequest:request error:&error];
    
    for(Kana * kana in array)
    {
        [kana setScoring:[NSNumber numberWithInt:SCORE_MAX]];
    }
     
    
    predicate = [NSPredicate predicateWithFormat:@"scoring < %@", [NSNumber numberWithInt:SCORE_MIN]];
    [request setPredicate:predicate]; 
     
    array = [_managedObjectContext executeFetchRequest:request error:&error];
    
    for(Kana * kana in array)
    {
        [kana setScoring:[NSNumber numberWithInt:SCORE_MIN]];
    }
    
    
    [self flush];
    
}


@end
