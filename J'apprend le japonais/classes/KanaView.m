//
//  HiraganaView.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 21/11/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "KanaView.h"

@implementation KanaView

@synthesize imgCentral = _imgCentral;
@synthesize lblHiragana = _lblHiragana;
@synthesize currentHiragana = _currentHiragana;
@synthesize mode = _mode;


- (BOOL) isForRomanjiToJapan
{
    return [self.mode isEqualToNumber:[NSNumber numberWithInt:MODE_ROMANJI_JAPAN]];
}

- (BOOL) isForJapanToRomanji
{
    return [self.mode isEqualToNumber:[NSNumber numberWithInt:MODE_JAPAN_ROMANJI]];
}

- (void) initialize{
    
    
    _imgCentral.image = [UIImage imageNamed:@"boardcard.png"];
    [_imgCentral setContentMode:UIViewContentModeScaleAspectFill];
    [_imgCentral setClipsToBounds:YES];
}

- (id) initWithCoder:(NSCoder *)aCoder{
    if(self = [super initWithCoder:aCoder]){
        [self initialize];
    }
    return self;
}

- (id) initWithFrame:(CGRect)rect{
    if(self = [super initWithFrame:rect]){
        [self initialize];
    }
    return self;
}

- (void) displayEmpty
{
    _lblHiragana.text = @"";
    [self setCurrentHiragana:nil]; 
}



- (void) displayRomanji
{ 
    fontSize = self.lblHiragana.font.pointSize; 
    
    if([self isForRomanjiToJapan])
    { 
        [_lblHiragana setFont:[UIFont fontWithName:@"Arial" size:fontSize]];
        
        _lblHiragana.text = _currentHiragana.romanji;
    }
    else
    { 
        [_lblHiragana setFont:[UIFont fontWithName:@"EPSON ã≥â»èëëÃÇl" size:fontSize]];
        
        _lblHiragana.text = _currentHiragana.japan;
    }
}

- (void) displayJapan
{ 
    fontSize = self.lblHiragana.font.pointSize; 
    if([self isForRomanjiToJapan])
    { 
        [_lblHiragana setFont:[UIFont fontWithName:@"EPSON ã≥â»èëëÃÇl" size:fontSize]];
        
        _lblHiragana.text = _currentHiragana.japan;
    }
    else
    {
        [_lblHiragana setFont:[UIFont fontWithName:@"Arial" size:fontSize]];
        
        _lblHiragana.text = _currentHiragana.romanji;
    }
    
}

@end
