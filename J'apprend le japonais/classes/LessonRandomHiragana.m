//
//  LessonRandomHiragana.m
//  J'apprend le japonais
//
//  Created by Guillaume chave on 27/10/12.
//  Copyright (c) 2012 Guillaume chave. All rights reserved.
//

#import "LessonRandomHiragana.h"
#import "Computer.h"

@interface LessonRandomHiragana ()

- (void) displayNextHiragana;

@end

@implementation LessonRandomHiragana

@synthesize btnNext = _btnNext;
@synthesize btnPrev = _btnPrev;
@synthesize msg = _msg;
@synthesize hiraganaView = _hiraganaView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        knows = [[NSMutableArray alloc] init];
        knowsRomanji = [[NSMutableArray alloc] init];
        currentPos = 0;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self displayNextHiragana];
    
    [_btnNext addTarget:self action:@selector(displayNextHiragana) forControlEvents:UIControlEventTouchUpInside];
    [_btnPrev addTarget:self action:@selector(displayPrevHiragana) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void) displayNextHiragana
{
    currentPos++;
    
    int nbHiraganaLesson = [[[Computer sharedInstance] getSelectedsHiragana] count];
    
    
    Hiragana * hiragana = nil;
    if(currentPos < [knows count])
    {
        hiragana = [knows objectAtIndex:currentPos];
    }
    else
    {
        hiragana = [[Computer sharedInstance] getRandomHiragana:knowsRomanji];
    
        if(hiragana != nil)
        {
            currentPos = [knows count];
            [knowsRomanji addObject:hiragana.romanji];
            [knows addObject:hiragana];
            
        }
    }
    
    int nb = [[[Computer sharedInstance] getSelectedsHiragana] count] - currentPos - 1;
    
    if(nb == 0)
    {
        _msg.text = @"Encore un dernier effort et c'est fini !";
    }
    else
    {
        _msg.text = [NSString stringWithFormat:@"Encore %i hiragana(s) à deviner", nb ];
    }
    
    if(currentPos >= nbHiraganaLesson)
    {
        knows = [[NSMutableArray alloc] init];
        knowsRomanji = [[NSMutableArray alloc] init];
        
        _msg.text = @"Fini ! ";
        [_hiraganaView displayEmpty];
        currentPos = 0;
    }
    else
    {
        [_hiraganaView displayNewHiragana:hiragana];
    }

}

- (void) displayPrevHiragana
{
    if(currentPos > 0)
    {
        currentPos--;
        currentPos--;
        [self displayNextHiragana];
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBtnPrev:nil];
    [super viewDidUnload];
}
@end
