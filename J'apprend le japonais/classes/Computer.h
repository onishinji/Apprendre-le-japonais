//
//  Computer.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 28/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Kana.h"
#import "NSMutableArray+Shuffling.h"
#import "GData.h"
#import "Cache.h"

@interface Computer : NSObject
{
    GDataServiceGoogleSpreadsheet * service;
}



@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;

+ (id)sharedInstance;

-(Kana *) createKana:(NSString *)romanji japan:(NSString *)japan position:(int)position col:(int)col row:(int)col section:(int)section type:(int)type;

-(NSFetchedResultsController *)  getHiraganaPerSections;
-(NSFetchedResultsController *)  getKatakanaPerSections;



-(NSMutableArray *) getRandomHiraganaExcept:(Kana *)hiragana limit:(int)limit;
-(NSMutableArray *) getRandomKatakanaExcept:(Kana *)hiragana limit:(int)limit;

-(NSArray *) getSelectedsHiragana;
-(NSArray *) getSelectedsKatakana;


-(Kana *) getRandomKatakana:(NSArray *)knowsJapan;
-(Kana *) getRandomHiragana:(NSArray *)knowsJapan;

-(Kana *) getKatakanaWithRomanji:(NSString *)romanji;
-(Kana *) getKatakanaWithJapan:(NSString *)romanji;
-(Kana *) getHiraganaWithRomanji:(NSString *)romanji;
-(Kana *) getHiraganaWithJapan:(NSString *)romanji;

-(Kana *) toggleSelectedKana:(Kana *)hiragana withFlush:(BOOL)flush;

- (Cache *) getWithKey:(NSString *)key;
- (void) setWithKey:(NSString *)key andValue:(NSData *)value;

-(void)flush;

- (void) upgradeDatabaseForStat;

@end
