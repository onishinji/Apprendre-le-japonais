    //
//  HiraganaFlipView.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 29/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "KanaFlipView.h"

@implementation KanaFlipView


- (void) initialize{
    [super initialize];
    
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

- (void) displayNext:(Kana *)hiragana
{
    [self setCurrentHiragana:hiragana];
    
    isJapanFace = TRUE;
    
    [self displayJapan];
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

- (void) switchToggleFace
{
    if(isJapanFace)
    {        
        [self oneFingerSwipeRight:nil];
    }
    else
    {
        [self oneFingerSwipeLeft:nil];
    }
}

- (void) toggleFace
{
    
    if(isJapanFace)
    {
        [self displayRomanji];
        isJapanFace = false;
    }
    else
    {
        [self displayJapan];
        isJapanFace = true;
    }
}

@end
