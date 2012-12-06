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
    
    _imgCentral.image = [UIImage imageNamed:@"tired-konata.jpeg"];
    [_imgCentral setContentMode:UIViewContentModeScaleAspectFill];
    [_imgCentral setClipsToBounds:YES];
    
    NSLog(@"%@", NSStringFromCGRect(_imgCentral.frame));
}



- (void) displayRomanji
{
    _imgCentral.image = nil;
    
    if([self isForRomanjiToJapan])
    {
        _lblHiragana.text = _currentHiragana.romanji;
    }
    else
    {
        _lblHiragana.text = _currentHiragana.japan;
    }
}

- (void) displayJapan
{
    _imgCentral.image = nil;
    
    if([self isForRomanjiToJapan])
    {
        _lblHiragana.text = _currentHiragana.japan;
    }
    else
    {
        _lblHiragana.text = _currentHiragana.romanji;
    }
    
    
    [_lblHiragana setFont:[UIFont fontWithName:@"EPSON ã≥â»èëëÃÇl" size:105]];
}

@end
