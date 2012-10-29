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

-(Hiragana *) createHiragana:(NSString *)romanji japan:(NSString *)japan position:(int)position
{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Hiragana" inManagedObjectContext:_managedObjectContext];
    Hiragana * hir = [[Hiragana alloc] initWithEntity:entity insertIntoManagedObjectContext:_managedObjectContext];
    
    hir.position = [NSNumber numberWithInt:position];
    
    hir.romanji = romanji;
    hir.japan = japan;
    hir.isSelected = [NSNumber numberWithBool:TRUE];
    
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
    
    NSLog(@"nb hiragana %d", [array count]);
    
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

    return array;
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
