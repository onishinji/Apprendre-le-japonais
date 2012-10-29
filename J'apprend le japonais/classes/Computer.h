//
//  Computer.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 28/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hiragana.h"
@interface Computer : NSObject
{
    
}



@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;

+ (id)sharedInstance;

-(Hiragana *) createHiragana:(NSString *)romanji japan:(NSString *)japan position:(int)position;
-(Hiragana *) getRandomHiragana:(NSArray *)knowRomanjis;

-(Hiragana *) toggleSelectedHiragana:(Hiragana *)hiragana;
-(NSArray *)  getAllHiragana;
-(void)flush;

@end
