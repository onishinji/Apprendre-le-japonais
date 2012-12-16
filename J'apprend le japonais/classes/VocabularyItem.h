//
//  VocabularyCell.h
//  J'apprend le japonais
//
//  Created by Guillaume chave on 16/12/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VocabularyItem : NSObject
{
    
}

@property (nonatomic, strong) NSString * romanji;
@property (nonatomic, strong) NSString * kana;
@property (nonatomic, strong) NSString * kanji;
@property (nonatomic, strong) NSString * traduction;
@property (nonatomic, strong) NSString * sampleUsageRomanji;
@property (nonatomic, strong) NSString * sampleUsageJapan;
@property (nonatomic, strong) NSString * sampleUsageTraduction;

@end
