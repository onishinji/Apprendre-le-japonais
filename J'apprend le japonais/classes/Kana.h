//
//  Kana.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 29/11/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Kana : NSManagedObject

@property (nonatomic, retain) NSNumber * col;
@property (nonatomic, retain) NSNumber * isSelected;
@property (nonatomic, retain) NSString * japan;
@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSString * romanji;
@property (nonatomic, retain) NSNumber * row;
@property (nonatomic, retain) NSNumber * scoring;
@property (nonatomic, retain) NSNumber * section;
@property (nonatomic, retain) NSNumber * type;

@end
