//
//  StatUtils.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 13/01/13.
//  Copyright (c) 2013 Guillaume chave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatUtils : NSObject

+ (BOOL) entityIsKnow:(id)entity;
+ (BOOL) entityIsPendingKnow:(id)entity;
+ (BOOL) entityIsUnknow:(id)entity;

- (BOOL) isKnow:(int) score;
- (BOOL) isUnkKnow:(int) score;
- (BOOL) isPendingKnow:(int) score;

@end
