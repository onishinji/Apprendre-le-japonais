//
//  StatUtils.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 13/01/13.
//  Copyright (c) 2013 Guillaume chave. All rights reserved.
//

#import "StatUtils.h"
#import "Kana.h"


#define KNOW_SETP_NO 1
#define KNOW_SETP_YES 5

@implementation StatUtils


+ (BOOL) entityIsKnow:(id)entity
{
    if([entity isKindOfClass:[Kana class]])
    {
        Kana * obj = (Kana *) entity;
        
        StatUtils * manager = [[StatUtils alloc] init];
        return [manager isKnow:[obj.scoring intValue]];
    }
    
    if([entity isKindOfClass:[NSArray class]])
    {
        NSArray * container = (NSArray *) entity;
        return [[self class] getPourcentScoreWithArray:container] >= 90;
    }
    
    return false;
}

+ (float) computeNbIsKnow:(NSArray *)container
{
    int nbElements = [container count];
    int nbStateElements = 0;
    for(id obj in container)
    {
        if([[self class] entityIsKnow:obj])
        {
            nbStateElements++;
        }
    }
    
    return (float) nbStateElements / (float) nbElements * 100.0f;
}

+ (BOOL) entityIsPendingKnow:(id)entity
{
    if([entity isKindOfClass:[Kana class]])
    {
        Kana * obj = (Kana *) entity;
        
        StatUtils * manager = [[StatUtils alloc] init];
        return [manager isPendingKnow:[obj.scoring intValue]];
    }
    
    
    
    if([entity isKindOfClass:[NSArray class]])
    {
        NSArray * container = (NSArray *) entity;
        
        return [[self class] getPourcentScoreWithArray:container] >= 45;
        
    }
    
    return false;
}

+ (float) getPourcentScoreWithArray:(NSArray *)container
{   
    float nbElements = [container count];
    float nbSilver = 0, nbGold = 0;
    for(id obj in container)
    {
        if([[self class] entityIsPendingKnow:obj])
        {
            nbSilver++;
        }
        
        if([[self class] entityIsKnow:obj])
        {
            nbGold++;
        }
    }
    
    return (nbSilver / 2 + nbGold) / nbElements * 100;
}

+ (BOOL) entityIsUnknow:(id)entity
{
    if([entity isKindOfClass:[Kana class]])
    {
        Kana * obj = (Kana *) entity;
        
        StatUtils * manager = [[StatUtils alloc] init];
        return [manager isUnkKnow:[obj.scoring intValue]];
    }
    
    
    
    if([entity isKindOfClass:[NSArray class]])
    {
        NSArray * container = (NSArray *) entity;
        
        int nbElements = [container count];
        int nbStateElements = 0;
        for(id obj in container)
        {
            if([[self class] entityIsUnknow:obj])
            {
                nbStateElements++;
            }
        }
        
        return (float) nbStateElements / (float) nbElements * 100.0f > 0;
        
    }
    
    return false;
}

- (BOOL) isKnow:(int) score
{
    return score >= KNOW_SETP_YES;
    
}

- (BOOL) isPendingKnow:(int) score
{
    return score >= KNOW_SETP_NO  && score < KNOW_SETP_YES;
}

- (BOOL) isUnkKnow:(int) score
{
    return score < KNOW_SETP_NO;
}


@end
