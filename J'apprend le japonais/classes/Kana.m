//
//  Kana.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 29/11/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "Kana.h"


@implementation Kana

@dynamic col;
@dynamic isSelected;
@dynamic japan;
@dynamic position;
@dynamic romanji;
@dynamic row;
@dynamic scoring;
@dynamic section;
@dynamic type;


- (NSString *)displayRomanji
{
    [self willAccessValueForKey:@"romanji"];
    NSString *myName = [self primitiveValueForKey:@"romanji"];
    
    [self didAccessValueForKey:@"romanji"];
    return [myName stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                             withString:[[myName  substringToIndex:1] capitalizedString]];;
    
}


- (void) increaseScore
{
    NSNumber * futurValue = [NSNumber numberWithInt:[self.scoring intValue] + 1];
    
    if([futurValue intValue] <= SCORE_MAX)
    {
        self.scoring = futurValue;
    }
}

- (void) decrementScore
{
    NSNumber * futurValue = [NSNumber numberWithInt:[self.scoring intValue] - 1];
    
    if([futurValue intValue] >= SCORE_MIN)
    {
        self.scoring = futurValue;
    }
}

@end
