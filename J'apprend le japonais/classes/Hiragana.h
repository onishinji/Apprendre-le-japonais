//
//  Hiragana.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 04/11/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Hiragana : NSManagedObject

@property (nonatomic, retain) NSNumber * isSelected;
@property (nonatomic, retain) NSString * japan;
@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSString * romanji;
@property (nonatomic, retain) NSNumber * scoring;
@property (nonatomic, retain) NSNumber * col;
@property (nonatomic, retain) NSNumber * row;
@property (nonatomic, retain) NSNumber * section;

@end
