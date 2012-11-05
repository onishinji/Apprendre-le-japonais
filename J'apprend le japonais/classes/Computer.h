//
//  Computer.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 28/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hiragana.h"
#import "NSMutableArray+Shuffling.h"

@interface Computer : NSObject
{
    
}



@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;

+ (id)sharedInstance;

-(Hiragana *) createHiragana:(NSString *)romanji japan:(NSString *)japan position:(int)position col:(int)col row:(int)col section:(int)section;

-(NSArray *)  getAllHiragana;
-(NSFetchedResultsController *)  getHiraganaPerSections;
-(NSMutableArray *) getRandomHiraganaExcept:(Hiragana *)hiragana limit:(int)limit;
-(NSArray *) getSelectedsHiragana;


-(Hiragana *) getRandomHiragana:(NSArray *)knowRomanjis;
-(Hiragana *) getHiraganaWithRomanji:(NSString *)romanji;
-(Hiragana *) toggleSelectedHiragana:(Hiragana *)hiragana;


-(void)flush;

@end
