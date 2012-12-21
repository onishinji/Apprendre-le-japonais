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

-(Kana *) getRandomHiragana:(NSArray *)knowRomanjis
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Kana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (romanji in %@) AND isSelected = 1 and type = 0", knowRomanjis];
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


-(Kana *) getRandomKatakana:(NSArray *)knowRomanjis
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Kana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (romanji in %@) AND isSelected = 1 and type = 1", knowRomanjis];
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


-(NSMutableArray *) getRandomHiraganaExcept:(Kana *)hiragana limit:(int)limit
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Kana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    [request setFetchLimit:limit];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT romanji = %@ AND isSelected = 1 and type = 0", hiragana.romanji];
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


-(NSMutableArray *) getRandomKatakanaExcept:(Kana *)hiragana limit:(int)limit
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Kana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    [request setFetchLimit:limit];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT romanji = %@ AND isSelected = 1 and type = 1", hiragana.romanji];
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
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"romanji = %@ and type = 1", romanji];
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
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"japan = %@ and type = 1", romanji];
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
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"romanji = %@ and type = 0", romanji];
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
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"japan = %@ and type = 0", romanji];
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
    if([self hasGrantedToVocabulary])
    {
        if(![[NSUserDefaults standardUserDefaults] objectForKey:@"is_granted"])
        {
            [[[UIAlertView alloc] initWithTitle:@"Merci" message:@"Vous avez activé le mode beta, relancer l'application." delegate:nil cancelButtonTitle:@"Fermer" otherButtonTitles:nil, nil] show];
        
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"is_granted"];
        }
    }
    else
    {
       // [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"is_granted"];
    }
    
    NSError *error = nil;
    if (![_managedObjectContext save: &error]) {
        NSLog(@"Error while saving\n%@",
              ([error localizedDescription] != nil) ? [error localizedDescription]: @"Unknown Error");
    }
    
}

- (BOOL) hasGrantedToVocabulary
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Kana" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSArray * knowRomanjis = [NSArray arrayWithObjects:@"ya", @"ma", @"gu", @"chi", nil];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"romanji in %@ AND isSelected = 1 and type = 0", knowRomanjis];
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
    
    BOOL hasYamaGuchi = [array count] == 4;

        BOOL hasOnlyTrueKana = [[self getSelectedsHiragana] count] == 4;

    return hasYamaGuchi && hasOnlyTrueKana;

}


@end
