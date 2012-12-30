//
//  Cache.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 30/12/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Cache : NSManagedObject

@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSData * value;

@end
