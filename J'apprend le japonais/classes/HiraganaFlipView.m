    //
//  HiraganaFlipView.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 29/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "HiraganaFlipView.h"

@implementation HiraganaFlipView

@synthesize imgCentral = _imgCentral;
@synthesize lblHiragana = _lblHiragana;

- (void) initialize{
    //init your ivars here
    UISwipeGestureRecognizer *oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(oneFingerSwipeRight:)];
    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    
    UISwipeGestureRecognizer *oneFingerSwipeLeft = [[UISwipeGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(oneFingerSwipeLeft:)];
    [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    [self addGestureRecognizer:oneFingerSwipeRight];
    [self addGestureRecognizer:oneFingerSwipeLeft];
    
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

- (void) displayNewHiragana:(Hiragana *)hiragana
{
    _hiragana = hiragana;
    
    isJapanFace = TRUE;
    _lblHiragana.text = hiragana.japan;
    _imgCentral.image = nil;
}

- (void) displayEmpty
{
    _lblHiragana.text = @"";
    _hiragana = nil;
    _imgCentral.image = [UIImage imageNamed:@"tired-konata.jpeg"];
    [_imgCentral setContentMode:UIViewContentModeScaleAspectFill];
    [_imgCentral setClipsToBounds:YES];
    NSLog(@"%@", NSStringFromCGRect(_imgCentral.frame));
}


- (void)oneFingerSwipeRight:(UITapGestureRecognizer *)recognizer {
    // Insert your own code to handle swipe right
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
 
    [self toggleFace];
    
    [UIView commitAnimations];
    
}


- (void)oneFingerSwipeLeft:(UITapGestureRecognizer *)recognizer {
    // Insert your own code to handle swipe right
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    
    [self toggleFace];
    
    [UIView commitAnimations];
    
}

- (void) toggleFace
{
    
    if(isJapanFace)
    {
        _lblHiragana.text = _hiragana.romanji;
        isJapanFace = false;
    }
    else
    {
        isJapanFace = true;
        _lblHiragana.text = _hiragana.japan;
    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
